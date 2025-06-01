from rest_framework import serializers
from .models import Risk

class RiskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Risk
        fields = ['id', 'title', 'description', 'category', 'likelihood', 'impact', 'owner', 'created_at', 'status']
