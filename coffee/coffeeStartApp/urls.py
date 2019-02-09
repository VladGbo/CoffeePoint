from django.contrib import admin
from django.urls import path,include
from .views import *
from django.contrib.auth import views as auth_views



urlpatterns = [
    path('',coffee_list,name='coffee_list_url'),
    path('like/',clear_count,name='clear_count'),
    path('accounts/profile/', profile, name='profile'),
    path('login/', auth_views.LoginView.as_view(template_name='coffeeStartApp/login.html'), name='login'),
    path('register/', register, name='register'),
    path('logout/', auth_views.LogoutView.as_view(template_name='coffeeStartApp/logout.html'), name='logout'),
    path('recepts/',recepts_list,name='recepts_list_url'),
    path('recept/create/',ReceptCreate.as_view(),name='recept_create_url'),
    path('recept/<str:slug>/', ReceptDetail.as_view(), name='recept_detail_url'),
    path('recept/<str:slug>/update/', ReceptUpdate.as_view(), name='recept_update_url'),
    path('recept/<str:slug>/delete/', ReceptDelete.as_view(), name='recept_delete_url'),
    path('typeofdrinks/',typeofdrinks_list,name='typeofdrinks_list_url'),
    path('typeofdrink/create/',TypeOfDrinkCreate.as_view(),name='typeofdrink_create_url'),
    path('typeofdrink/<str:slug>/', TypeOfDrinkDetail.as_view(), name='typeofdrink_detail_url'),
    path('typeofdrink/<str:slug>/update/', TypeOfDrinkUpdate.as_view(), name='typeofdrink_update_url'),
    path('typeofdrink/<str:slug>/delete/', TypeOfDrinkDelete.as_view(), name='typeofdrink_delete_url'),
    path('coffeemachines/',coffeemachines_list,name='coffeemachines_list_url'),
    path('coffeemachine/create/',CoffeeMachineCreate.as_view(),name='coffeemachine_create_url'),
    path('coffeemachine/<str:slug>/', CoffeeMachineDetail.as_view(), name='coffeemachine_detail_url'),
    path('coffeemachine/<str:slug>/update/', CoffeeMachineUpdate.as_view(), name='coffeemachine_update_url'),
    path('coffeemachine/<str:slug>/delete/', CoffeeMachineDelete.as_view(), name='coffeemachine_delete_url'),
    path('orders/',orders_list,name='orders_list_url'),
    path('order/create/',OrderCreate.as_view(),name='orders_create_url'),
    path('order/<str:slug>/', OrderDetail.as_view(), name='order_detail_url'),
    path('order/<str:slug>/update/', OrderUpdate.as_view(), name='order_update_url'),
    path('order/<str:slug>/delete/', OrderDelete.as_view(), name='order_delete_url'),
    path('iosuserlogin/', iosLogin, name=''),
    path('iosusercoffeemachine/', iosListCoffeeMachine, name=''),
    path('iosusercoffeerecepts/', iosListCoffeeRecept, name=''),
    path('iossignupuser/', iosSignUpUser, name=''),
    path('ioscreateorder/', iosCreateOrder, name='')
]
