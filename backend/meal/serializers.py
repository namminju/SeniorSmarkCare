from rest_framework import serializers
from .models import Meal

class MealCntSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meal
        fields = ['mealAlarmCnt',]


class MealTimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meal
        fields = ['mealTime1', 'mealTime2', 'mealTime3']

    def validate(self, data):
        mealAlarmCnt = self.instance.mealAlarmCnt
        mealTime1 = data.get('mealTime1')
        mealTime2 = data.get('mealTime2')
        mealTime3 = data.get('mealTime3')

        if mealAlarmCnt == 1 and not mealTime1:
            raise serializers.ValidationError("mealTime1 is required when mealAlarmCnt is 1")
        if mealAlarmCnt == 2 and (not mealTime1 or not mealTime2):
            raise serializers.ValidationError("mealTime1 and mealTime2 are required when mealAlarmCnt is 2")
        if mealAlarmCnt == 3 and (not mealTime1 or not mealTime2 or not mealTime3):
            raise serializers.ValidationError("mealTime1, mealTime2, and mealTime3 are required when mealAlarmCnt is 3")

        return data
