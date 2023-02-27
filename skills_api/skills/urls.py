from django.urls import path
from .views import skill_list

urlpatterns = [
    path('', skill_list, name='skill_list'),
]
