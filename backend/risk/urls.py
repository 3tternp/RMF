from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import RiskViewSet

router = DefaultRouter()
router.register(r'', RiskViewSet)

urlpatterns = [
    path('', include(router.urls)),
]
