from django.db import models
from django.contrib.auth.models import User
from django.shortcuts import reverse
from django.core.validators import MinValueValidator, MaxValueValidator
# Create your models here.
from django.utils.text import slugify
from time import time
from django.db import connection
from django.db.models import F
def gen_slug(s):
    new_slug = slugify(s, allow_unicode=True)
    return new_slug + '-' +str(int(time()))

class Recept(models.Model):
    title = models.CharField(max_length=70,unique=True)
    slug = models.SlugField(max_length=50,unique=True, blank=True)
    def save(self, *args, **kwargs):
        if not self.id:
            self.slug = gen_slug(self.title)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('recept_detail_url',kwargs={'slug': self.slug})

    def get_update_url(self):
        return reverse('recept_update_url', kwargs={'slug':self.slug})

    def get_delete_url(self):
        return reverse('recept_delete_url', kwargs={'slug':self.slug})

    def __str__(self):
        return self.title


class TypeOfDrink(models.Model):
    title = models.CharField(max_length=70,unique=True)
    cost = models.IntegerField(validators=[MinValueValidator(1),MaxValueValidator(9999999999)],default=1)
    recepts = models.ManyToManyField(Recept,related_name='recepts')
    slug = models.SlugField(max_length=50,unique=True, blank=True)

    def save(self, *args, **kwargs):
        if not self.id:
            self.slug = gen_slug(self.title)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('typeofdrink_detail_url',kwargs={'slug': self.slug})

    def get_update_url(self):
        return reverse('typeofdrink_update_url', kwargs={'slug':self.slug})

    def get_delete_url(self):
        return reverse('typeofdrink_delete_url', kwargs={'slug':self.slug})

    def __str__(self):
        return self.title

class CoffeeMachine(models.Model):
    title = models.CharField(max_length=70,unique=True)
    address = models.CharField(max_length=70)
    is_worked = models.BooleanField(default=True)
    count = models.IntegerField(default=0)
    slug = models.SlugField(max_length=50,unique=True, blank=True)


    def save(self, *args, **kwargs):
        if not self.id:
            self.slug = gen_slug(self.title)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('coffeemachine_detail_url',kwargs={'slug': self.slug})

    def get_update_url(self):
        return reverse('coffeemachine_update_url', kwargs={'slug':self.slug})

    def get_delete_url(self):
        return reverse('coffeemachine_delete_url', kwargs={'slug':self.slug})

    def __str__(self):
        return self.title

class Order(models.Model):
    date = models.DateTimeField(auto_now_add=True)
    coffeemachine = models.ForeignKey(CoffeeMachine,on_delete=models.CASCADE)
    user = models.ForeignKey(User,on_delete=models.CASCADE)
    typeofdrink = models.ForeignKey(TypeOfDrink,on_delete=models.CASCADE)
    slug = models.SlugField(max_length=50,unique=True, blank=True)

    def save(self, *args, **kwargs):
        if Order.objects.filter(coffeemachine_id=self.coffeemachine.id).count()>=2:  
            CoffeeMachine.objects.filter(id=self.coffeemachine.id).update(is_worked=False)

        CoffeeMachine.objects.filter(id=self.coffeemachine.id).update(count=F('count') + 1)
        if not self.id:
            self.slug = gen_slug(self.typeofdrink.title)
        super().save(*args, **kwargs)

    def get_absolute_url(self):
        return reverse('order_detail_url',kwargs={'slug': self.slug})

    def get_update_url(self):
        return reverse('order_update_url', kwargs={'slug':self.slug})

    def get_delete_url(self):
        return reverse('order_delete_url', kwargs={'slug':self.slug})

    def __str__(self):
        return self.typeofdrink.title
