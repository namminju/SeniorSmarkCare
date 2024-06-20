from rest_framework import serializers
from .models import Meal

class MealCntSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meal
        fields = ['mealAlarmCnt',]


class MealTimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Meal
        fields = ['mealTime1', 'mealTime2', 'mealTime3', 'mealTime4', 'mealTime5']

    def validate(self, data):
        mealAlarmCnt = self.instance.mealAlarmCnt
        mealTime1 = data.get('mealTime1')
        mealTime2 = data.get('mealTime2')
        mealTime3 = data.get('mealTime3')
        mealTime4 = data.get('mealTime4')
        mealTime5 = data.get('mealTime5')

        if mealAlarmCnt == 1 and not mealTime1:
            raise serializers.ValidationError("mealTime1 is required when mealAlarmCnt is 1")
        if mealAlarmCnt == 2 and (not mealTime1 or not mealTime2):
            raise serializers.ValidationError("mealTime1 and mealTime2 are required when mealAlarmCnt is 2")
        if mealAlarmCnt == 3 and (not mealTime1 or not mealTime2 or not mealTime3):
            raise serializers.ValidationError("mealTime1, mealTime2, and mealTime3 are required when mealAlarmCnt is 3")
        if mealAlarmCnt == 3 and (not mealTime1 or not mealTime2 or not mealTime3 or not mealTime4):
            raise serializers.ValidationError("mealTime1, mealTime2, mealTime3, and mealTime4 are required when mealAlarmCnt is 4")
        if mealAlarmCnt == 3 and (not mealTime1 or not mealTime2 or not mealTime3 or not mealTime4 or not mealTime5):
            raise serializers.ValidationError("mealTime1, mealTime2, mealTime3, mealTime4, and mealTime5 are required when mealAlarmCnt is 5")

        return data
