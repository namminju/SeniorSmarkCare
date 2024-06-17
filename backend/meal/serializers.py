from .models import *
from rest_framework import serializers

class MealSerializer(serializers.Serializer):
    class Meta:
        model = Meal
        fields = [
            'mealAlarmCnt', 'mealTime1', 'mealTime2', 'mealTime3'
        ]
