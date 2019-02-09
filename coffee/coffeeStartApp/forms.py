from django import forms
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from .models import *
from django.core.exceptions import ValidationError

class UserRegisterForm(UserCreationForm):
    email = forms.EmailField()

    class Meta:
        model = User
        fields = ['username', 'email', 'password1', 'password2']

class ReceptForm(forms.ModelForm):

    class Meta:
        model = Recept
        fields = ['title']

        widgets = {
            'title':forms.TextInput(attrs={'class':'form-control'}),
        }

class TypeOfDrinkForm(forms.ModelForm):

    class Meta:
        model = TypeOfDrink
        fields = ['title','cost','recepts']

        widgets = {
            'title':forms.TextInput(attrs={'class':'form-control'}),
            'cost':forms.TextInput(attrs={'class':'form-control'}),
            'recepts':forms.SelectMultiple(attrs={'class':'form-control'}),
        }

class CoffeeMachineForm(forms.ModelForm):

    class Meta:
        model = CoffeeMachine
        fields = ['title','address','is_worked']

        widgets = {
            'title':forms.TextInput(attrs={'class':'form-control'}),
            'address':forms.TextInput(attrs={'class':'form-control'}),
            'is_worked':forms.CheckboxInput(attrs={'class':'form-control'}),
            #'slug':forms.TextInput(attrs={'class': 'form-control'}),

        }

class OrderForm(forms.ModelForm):

    class Meta:
        model = Order
        fields = ['coffeemachine','user','typeofdrink']

        widgets = {
            'coffeemachine':forms.Select(attrs={'class':'form-control'}),
            'user':forms.Select(attrs={'class':'form-control'}),
            'typeofdrink':forms.Select(attrs={'class':'form-control'}),

        }
        
