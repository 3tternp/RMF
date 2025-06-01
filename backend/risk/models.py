from django.db import models

class Risk(models.Model):
    RISK_CATEGORIES = (
        ('operational', 'Operational'),
        ('strategic', 'Strategic'),
        ('compliance', 'Compliance'),
        ('financial', 'Financial'),
    )
    title = models.CharField(max_length=200)
    description = models.TextField()
    category = models.CharField(max_length=50, choices=RISK_CATEGORIES)
    likelihood = models.FloatField()
    impact = models.FloatField()
    owner = models.ForeignKey('core.User', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.CharField(max_length=20, default='open')

    def __str__(self):
        return self.title
