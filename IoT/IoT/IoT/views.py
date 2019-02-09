from django.http import HttpResponse



def prepareCoffeeIntoCoffeeMachine (request):
    userName = request.GET['userOrder']
    coffeeMachineOrder = request.GET['coffeeMachine']
    typeofdrinkOrder = request.GET['typeOfDrink']
    print('Ваш напій: ' + typeofdrinkOrder + '\n' +
          'Для: ' + userName + '\n' +
          'Кавовий апарат: ' + coffeeMachineOrder + '\n' +
          'Ваш напій приготований!!! \n Дякуємо за довіру!!!')

    return HttpResponse("hello")
