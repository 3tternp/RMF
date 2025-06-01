from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include('core.urls')),
    path('api/risks/', include('risk.urls')),
    path('api/controls/', include('control.urls')),
    path('api/audits/', include('audit.urls')),
    path('api/dashboards/', include('dashboards.urls')),
]
