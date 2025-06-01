from rest_framework import viewsets
from .models import Risk
from .serializers import RiskSerializer
from rest_framework.permissions import IsAuthenticated

class RiskViewSet(viewsets.ModelViewSet):
    queryset = Risk.objects.all()
    serializer_class = RiskSerializer
    permission_classes = [IsAuthenticated]
