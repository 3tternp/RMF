from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from risk.models import Risk
from control.models import Control
from audit.models import Audit

class DashboardView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        risks = Risk.objects.all().count()
        controls = Control.objects.all().count()
        open_audits = Audit.objects.filter(status='open').count()
        return Response({
            'total_risks': risks,
            'total_controls': controls,
            'open_audits': open_audits,
        })
