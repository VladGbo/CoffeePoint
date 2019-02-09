import json
import requests


if __name__ == '__main__':

    req = requests.get(url='http://127.0.0.1:8000/iosusercoffeemachine/')
    listCoffeeMachine = req.json()
    print(listCoffeeMachine)
    count = 0
    for i in listCoffeeMachine:
        count += 1
        print(str(count) + ') ' + str(i['name']))

    print('Choice one of them')
    choisedCoffeeMachime = listCoffeeMachine[int(input()) - 1]
    print(choisedCoffeeMachime)

    while True:
        print("List of commands \n"+
              "1) List of preapred orders \n"+
              "2) Get status \n"+
              "0) Exit \n")
        responce = input()

        if responce == "0":
            break

        if responce == "":
            print("Choice task")
            continue

        if responce == "1":
            nameCoffeeMachine = choisedCoffeeMachime['name']
            sendOrder = {
                'name': nameCoffeeMachine
            }
            req = requests.get(url='http://127.0.0.1:8000/iotListOrderMchine/', params=sendOrder)
            count = 0
            for i in req.json():
                count += 1
                print(str(count) + ') '+ 'name: ' + i['name'] + ', ' + 'cost: ' + str(i['cost'])+ '\n')

        if responce == "2":
            isWork = choisedCoffeeMachime['isWorked']
            if isWork == True:
                print('Coffee machine is ready to work_____________________\n')
            if isWork == False:
                print('Error need repairs_____________ \n')
