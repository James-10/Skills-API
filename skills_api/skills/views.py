from django.shortcuts import render, get_object_or_404
from .models import Skills, SkillsDetail

def skill_list(request):
    skills = Skills.objects.all()
    return render(request, 'skill_list.html', {'skills': skills})

def skill_detail (request, skill_id):
    skill = get_object_or_404(Skills, pk=skill_id)
    skill_detail =SkillsDetail.objects.filter(skill_name_id=skill_id)

    return render(request, 'skill_detail.html', {'skill': skill, 'skill_detail': skill_detail })