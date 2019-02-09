from django.shortcuts import render
from django.shortcuts import redirect
from django.shortcuts import get_object_or_404
from django.views.generic.edit import FormView


from django.shortcuts import render
from django.shortcuts import redirect
from django.shortcuts import get_object_or_404
from django.views.generic.edit import FormView

from .models import *



class ObjectDetailMixin:
    model = None
    template = None

    def get(self, request, slug):
        obj = get_object_or_404(self.model, slug__iexact=slug)

        return render(request,self.template,context={'obj':obj,'admin_object':obj,'detail':True})


class ObjectCreateMixin:
    model_form = None
    template = None
    model = None

    def get(self,request):
        form = self.model_form()
        return render(request, self.template,context={'form':form})

    def post(self,request):
        bound_form = self.model_form(request.POST or None,request.FILES or None)
        if bound_form.is_valid():
            new_obj = bound_form.save()
            return redirect(new_obj)
        return render(request,self.template,context={'form':bound_form})


class ObjectUpdateMixin:
    model = None
    model_form = None
    template = None

    def get(self, request, slug):
        obj = self.model.objects.get(slug__iexact=slug)
        bound_form = self.model_form(instance=obj)
        return render(request,self.template,context={'form':bound_form,'obj':obj})

    def post(self,request,slug):
        obj = self.model.objects.get(slug__iexact=slug)
        bound_form = self.model_form(request.POST or None,request.FILES or None,instance=obj)

        if bound_form.is_valid():
            new_obj = bound_form.save()
            return redirect(new_obj)
        return render(request,self.template,context={'form':bound_form,'obj':obj})


class ObjectDeleteMixin:
    model = None
    template = None
    redirect_url = None

    def get(self,request, slug):
        obj = self.model.objects.get(slug__iexact=slug)
        return render(request,self.template,context={'obj':obj})

    def post(self,request,slug):
        obj = self.model.objects.get(slug__iexact=slug)
        obj.delete()
        return redirect(reverse(self.redirect_url))
