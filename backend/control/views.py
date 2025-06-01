from rest_framework import viewsets
from .models import Control
from .serializers import ControlSerializer
from rest_framework.permissions import IsAuthenticated

class ControlViewSet(viewsets.ModelViewSet):
    queryset = Control.objects.all()
    serializer_class = ControlSerializer
    permission_classes = [IsAuthenticated]
