from django.shortcuts import render
from .forms import *
from django.contrib import messages
from django.shortcuts import render, redirect
from .utils import *
from django.views.generic import View,ListView
from django.contrib.auth.mixins import LoginRequiredMixin
from .models import *
from .filters import *
from django.contrib.auth.models import User
from django.db.models import F
from django.core import serializers

import json
import requests
from django.http import HttpResponse
from django.contrib.auth import authenticate, login
from django.views.decorators.csrf import csrf_exempt
from requests.auth import HTTPBasicAuth


# Create your views here.
@csrf_exempt
def iosLogin(request, format=None):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        user = User.objects.get(username=username)

        user_json = json.dumps({
            'id': user.id,
            'username': user.username,
            'email': user.email
        }, ensure_ascii=False)
        return HttpResponse(content=user_json)
    else:
        return "error login"
@csrf_exempt
def iosListCoffeeMachine(request):
    listRecepts = CoffeeMachine.objects.all()
    arr = []
    for i in listRecepts:
        a = {
            'name': i.title,
            'adrress': i.address,
            'isWorked': i.is_worked
        }
        arr.append(a)

    listRecepts = json.dumps(arr, ensure_ascii=False)
    return HttpResponse(content=listRecepts)

@csrf_exempt
def iosListCoffeeRecept(request):
    listRecepts = TypeOfDrink.objects.all()
    arr = []
    for i in listRecepts:
        a = {
            'name': i.title,
            'cost': i.cost
        }
        arr.append(a)
    listRecepts = json.dumps(arr, ensure_ascii=False)
    return HttpResponse(content=listRecepts)

@csrf_exempt
def iosSignUpUser(request):
    name = request.POST['name']
    password = request.POST['password']
    email = request.POST['userEmail']
    messageDecline = json.dumps({'resStatus': 'errorUserExist'}, ensure_ascii=False)
    messageAccept = json.dumps({'resStatus': 'userCreated'}, ensure_ascii=False)

    if len(User.objects.all().filter(username=name)) > 0:
        return HttpResponse(content= messageDecline, status=400)

    res = User.objects.create_user(username=name, password=password, email=email)
    print(res)
    return HttpResponse(content=messageAccept, status=200)

@csrf_exempt
def iosCreateOrder(request):
    idUser = request.POST['idUser']
    titleMachine = request.POST['titleMachine']
    titleDrink = request.POST['titleDrink']

    user_obj = User.objects.get(id=idUser)
    machine_obj = CoffeeMachine.objects.get(title=titleMachine)
    drink_obj = TypeOfDrink.objects.get(title=titleDrink)
    order = Order.objects.create(user=user_obj, coffeemachine=machine_obj, typeofdrink=drink_obj)
    res = {'userStatus': 'created'}
    listRes = json.dumps(res, ensure_ascii=False)
    sendOrder = {
            'userOrder':order.user.username,
            'coffeeMachine':order.coffeemachine.title,
            'typeOfDrink':order.typeofdrink.title,
            # 'dateorder': order.date
        }

    requests.get(url='http://127.0.0.1:5000/printresultfromcoffeee/', params=sendOrder)
    return HttpResponse(content=listRes, status=200)

def clear_count(request):
    group = get_object_or_404(CoffeeMachine,id=request.POST.get('group_id'))
    group.count = 0
    group.is_worked = True
    group.save()
    return redirect(group.get_absolute_url())

def coffee_list(request):
    coffeemachines = CoffeeMachine.objects.all()
    filter = CoffeeMachineFilter(request.GET,queryset=coffeemachines)
    return render(request,'coffeeStartApp/index.html',context={'filter':filter})


def register(request):
    if request.method == 'POST':
        form = UserRegisterForm(request.POST)
        if form.is_valid():
            form.save()
            username = form.cleaned_data.get('username')
            messages.success(request,'Your account has been created! You are now able to log in')
            return redirect('login')
    else:
        form = UserRegisterForm()
    return render(request, 'coffeeStartApp/register.html', {'form': form})

def profile(request):
    return render(request, 'coffeeStartApp/profile.html')

#CRUD Recept
def recepts_list(request):
    recepts = Recept.objects.all()

    return render(request,'coffeeStartApp/list_recept.html',context={'recepts':recepts})

class ReceptDetail(ObjectDetailMixin,View):
    model = Recept
    template = 'coffeeStartApp/detail_recept.html'

class ReceptCreate(LoginRequiredMixin,ObjectCreateMixin, View):
    model_form = ReceptForm
    model = Recept
    template = 'coffeeStartApp/create_recept.html'
    raise_exception = True


class ReceptDelete(LoginRequiredMixin,ObjectDeleteMixin,View):
    model = Recept
    template = 'coffeeStartApp/delete.html'
    redirect_url = 'recepts_list_url'
    raise_exception = True


class ReceptUpdate(LoginRequiredMixin,ObjectUpdateMixin,View):
    model = Recept
    model_form = ReceptForm
    template = 'coffeeStartApp/update.html'
    raise_exception = True


#CRUD TypeOfDrink

def typeofdrinks_list(request):
    typeofdrinks = TypeOfDrink.objects.all()
    return render(request,'coffeeStartApp/list_typeofdrink.html',context={'typeofdrinks':typeofdrinks})

class TypeOfDrinkDetail(ObjectDetailMixin,View):
    model = TypeOfDrink
    template = 'coffeeStartApp/detail_typeofdrink.html'

class TypeOfDrinkCreate(LoginRequiredMixin,ObjectCreateMixin, View):
    model_form = TypeOfDrinkForm
    model = TypeOfDrink
    template = 'coffeeStartApp/create_typeofdrink.html'
    raise_exception = True


class TypeOfDrinkDelete(LoginRequiredMixin,ObjectDeleteMixin,View):
    model = TypeOfDrink
    template = 'coffeeStartApp/delete.html'
    redirect_url = 'typeofdrinks_list_url'
    raise_exception = True

class TypeOfDrinkUpdate(LoginRequiredMixin,ObjectUpdateMixin,View):
    model = TypeOfDrink
    model_form = TypeOfDrinkForm
    template = 'coffeeStartApp/update.html'
    raise_exception = True


#CRUD CoffeeMachine

def coffeemachines_list(request):
    coffeemachines = CoffeeMachine.objects.all()
    return render(request,'coffeeStartApp/list_coffeemachine.html',context={'coffeemachines':coffeemachines})

class CoffeeMachineDetail(ObjectDetailMixin,View):
    model = CoffeeMachine
    template = 'coffeeStartApp/detail_coffeemachine.html'

    def get(self, request, slug):
        obj = get_object_or_404(self.model, slug__iexact=slug)
        orders = Order.objects.filter(coffeemachine_id=obj.id)
        return render(request,self.template,context={
        'obj':obj,
        'admin_object':obj,
        'detail':True,
        'orders':orders
        })




class CoffeeMachineCreate(LoginRequiredMixin,ObjectCreateMixin, View):
    model_form = CoffeeMachineForm
    model = CoffeeMachine
    template = 'coffeeStartApp/create_coffeemachine.html'
    raise_exception = True


class CoffeeMachineDelete(LoginRequiredMixin,ObjectDeleteMixin,View):
    model = CoffeeMachine
    template = 'coffeeStartApp/delete.html'
    redirect_url = 'coffeemachines_list_url'
    raise_exception = True


class CoffeeMachineUpdate(LoginRequiredMixin,ObjectUpdateMixin,View):
    model = CoffeeMachine
    model_form = CoffeeMachineForm
    template = 'coffeeStartApp/update.html'
    raise_exception = True


#CRUD Order

def orders_list(request):
    orders = Order.objects.all()
    return render(request,'coffeeStartApp/list_order.html',context={'orders':orders})

class OrderDetail(ObjectDetailMixin,View):
    model = Order
    template = 'coffeeStartApp/detail_order.html'



class OrderCreate(LoginRequiredMixin,ObjectCreateMixin, View):
    model_form = OrderForm
    model = Order
    template = 'coffeeStartApp/create_order.html'
    raise_exception = True

    def get(self,request):
        form = self.model_form()
        return render(request, self.template,context={'form':form})

    def post(self,request):
        bound_form = self.model_form(request.POST or None,request.FILES or None)
        if bound_form.is_valid():

            new_obj = bound_form.save()
            # print(dir(new_obj))
            return redirect(new_obj)
        return render(request,self.template,context={'form':bound_form})



class OrderDelete(LoginRequiredMixin,ObjectDeleteMixin,View):
    model = Order
    template = 'coffeeStartApp/delete.html'
    redirect_url = 'orders_list_url'
    raise_exception = True

    def get(self,request, slug):
        obj = self.model.objects.get(slug__iexact=slug)
        return render(request,self.template,context={'obj':obj})

    def post(self,request,slug):
        obj = self.model.objects.get(slug__iexact=slug)
        if Order.objects.filter(coffeemachine_id=obj.coffeemachine.id).count()<2:
            CoffeeMachine.objects.filter(id=obj.coffeemachine.id).update(is_worked=True)

        obj.delete()
        return redirect(reverse(self.redirect_url))

class OrderUpdate(LoginRequiredMixin,ObjectUpdateMixin,View):
    model = Order
    model_form = OrderForm
    template = 'coffeeStartApp/update.html'
    raise_exception = True
