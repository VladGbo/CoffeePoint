import django_filters
from .models import *
from django import forms


class CoffeeMachineFilter(django_filters.FilterSet):

    # CHOICES = (
    # ('title','Названию'),
    # ('album','Альбому')
    # )
    #
    # ordering = django_filters.ChoiceFilter(
    # label="Сортировка по ",
    # choices=CHOICES,
    # method='filter_by_order'
    # )
    is_worked = django_filters.BooleanFilter()
    #title = django_filters.CharFilter(lookup_expr='icontains',label='Название')
    #album = django_filters.ModelMultipleChoiceFilter(queryset=Album.objects.all(),
        #widget=forms.CheckboxSelectMultiple,label='Альбомы')
    class Meta:
        model = CoffeeMachine
        fields =['is_worked']
    def filter_by_order(self,queryset,name,value):
        return queryset.order_by(value)
