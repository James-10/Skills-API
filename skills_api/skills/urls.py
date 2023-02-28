from django.conf import settings
from django.urls import path
from django.conf.urls.static import static
from .views import skill_list, skill_detail

urlpatterns = [
    path('', skill_list, name='skill_list'),
    path('<int:skill_id>', skill_detail, name='skill_detail')
] + static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
