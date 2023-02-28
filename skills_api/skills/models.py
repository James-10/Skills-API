from django.db import models
    
class Skills(models.Model):
    id = models.AutoField(primary_key=True)
    skill_name = models.CharField(max_length=255)

class SkillsDetail(models.Model):
    id = models.AutoField(primary_key=True)
    skill_name = models.ForeignKey(Skills, on_delete=models.CASCADE)
    description = models.TextField(blank=True)
    years_experience = models.SmallIntegerField()

    def __str__(self):
        return self.skill_name