from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import ControlViewSet

router = DefaultRouter()
router.register(r'', ControlViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
