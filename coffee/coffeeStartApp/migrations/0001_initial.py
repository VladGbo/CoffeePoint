# Generated by Django 2.1.4 on 2018-12-26 20:50

from django.conf import settings
import django.core.validators
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='CoffeeMachine',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=70, unique=True)),
                ('address', models.CharField(max_length=70)),
                ('is_worked', models.BooleanField(default=True)),
                ('slug', models.SlugField(blank=True, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date', models.DateTimeField(auto_now_add=True)),
                ('slug', models.SlugField(blank=True, unique=True)),
                ('coffeemachine', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coffeeStartApp.CoffeeMachine')),
            ],
        ),
        migrations.CreateModel(
            name='Recept',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=70, unique=True)),
                ('slug', models.SlugField(blank=True, unique=True)),
            ],
        ),
        migrations.CreateModel(
            name='TypeOfDrink',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=70, unique=True)),
                ('cost', models.IntegerField(default=1, validators=[django.core.validators.MinValueValidator(1), django.core.validators.MaxValueValidator(9999999999)])),
                ('slug', models.SlugField(blank=True, unique=True)),
                ('recepts', models.ManyToManyField(related_name='recepts', to='coffeeStartApp.Recept')),
            ],
        ),
        migrations.AddField(
            model_name='order',
            name='typeofdrink',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='coffeeStartApp.TypeOfDrink'),
        ),
        migrations.AddField(
            model_name='order',
            name='user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
    ]
