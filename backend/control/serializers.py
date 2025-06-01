from rest_framework import serializers
from .models import Control

class ControlSerializer(serializers.ModelSerializer):
    class Meta:
        model = Control
        fields = ['id', 'control_id', 'family', 'title', 'description', 'implementation_status']
