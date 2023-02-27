from django.db import models

class Skill(models.Model):
    id = models.UUIDField(primary_key=True)
    skill_name = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    years_experience = models.SmallIntegerField()

    def __str__(self):
        return self.skill_name