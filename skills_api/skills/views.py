from django.shortcuts import render
from .models import Skill

def skill_list(request):
    skills = Skill.objects.all()
    return render(request, 'skill_list.html', {'skills': skills})
