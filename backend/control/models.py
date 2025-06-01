from django.db import models

class Control(models.Model):
    NIST_CONTROL_FAMILIES = (
        ('AC', 'Access Control'),
        ('AU', 'Audit and Accountability'),
        ('CM', 'Configuration Management'),
        ('IA', 'Identification and Authentication'),
        ('RA', 'Risk Assessment'),
        # Add other NIST 800-53 families as needed
    )
    control_id = models.CharField(max_length=10, unique=True)  # e.g., AC-1
    family = models.CharField(max_length=50, choices=NIST_CONTROL_FAMILIES)
    title = models.CharField(max_length=200)
    description = models.TextField()
    implementation_status = models.CharField(max_length=50, default='Not Implemented')

    def __str__(self):
        return f"{self.control_id}: {self.title}"
