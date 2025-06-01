from rest_framework import serializers
from .models import Audit

class AuditSerializer(serializers.ModelSerializer):
    class Meta:
        model = Audit
        fields = ['id', 'title', 'risk', 'control', 'findings', 'status', 'audit_date']
