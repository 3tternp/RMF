from django.db import models

class Audit(models.Model):
    title = models.CharField(max_length=200)
    risk = models.ForeignKey('risk.Risk', on_delete=models.CASCADE)
    control = models.ForeignKey('control.Control', on_delete=models.CASCADE)
    findings = models.TextField()
    status = models.CharField(max_length=20, default='open')
    audit_date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.title
