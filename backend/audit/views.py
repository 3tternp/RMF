from rest_framework import viewsets
from .models import Audit
from .serializers import AuditSerializer
from rest_framework.permissions import IsAuthenticated

class AuditViewSet(viewsets.ModelViewSet):
    queryset = Audit.objects.all()
    serializer_class = AuditSerializer
    permission_classes = [IsAuthenticated]
