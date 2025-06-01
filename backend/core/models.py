from django.contrib.auth.models import AbstractUser
from django.db import models

class User(AbstractUser):
    ROLES = (
        ('admin', 'Administrator'),
        ('risk_manager', 'Risk Manager'),
        ('auditor', 'Auditor'),
        ('viewer', 'Viewer'),
    )
    role = models.CharField(max_length=20, choices=ROLES, default='viewer')

class Role(models.Model):
    name = models.CharField(max_length=50, unique=True)
    permissions = models.JSONField(default=dict)  # NIST 800-53 permissions

    def __str__(self):
        return self.name
