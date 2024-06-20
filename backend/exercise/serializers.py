from rest_framework import serializers
from .models import *

class ExerciseCntSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exercise
        fields = ['exerciseAlarmCnt',]


class ExerciseTimeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Exercise
        fields = ['exerciseTime1', 'exerciseTime2', 'exerciseTime3', 'exerciseTime4', 'exerciseTime5']

    def validate(self, data):
        exerciseAlarmCnt = self.instance.exerciseAlarmCnt
        exerciseTime1 = data.get('exerciseTime1')
        exerciseTime2 = data.get('exerciseTime2')
        exerciseTime3 = data.get('exerciseTime3')
        exerciseTime4 = data.get('exerciseTime4')
        exerciseTime5 = data.get('exerciseTime5')

        if exerciseAlarmCnt == 1 and not exerciseTime1:
            raise serializers.ValidationError("exerciseTime1 is required when exerciseAlarmCnt is 1")
        if exerciseAlarmCnt == 2 and (not exerciseTime1 or not exerciseTime2):
            raise serializers.ValidationError("2 exerciseTimes are required when exerciseAlarmCnt is 2")
        if exerciseAlarmCnt == 3 and (not exerciseTime1 or not exerciseTime2 or not exerciseTime3):
            raise serializers.ValidationError("3 exerciseTimes are required when exerciseAlarmCnt is 3")
        if exerciseAlarmCnt == 3 and (not exerciseTime1 or not exerciseTime2 or not exerciseTime3 or not exerciseTime4):
            raise serializers.ValidationError("4 exerciseTimes are required when exerciseAlarmCnt is 4")
        if exerciseAlarmCnt == 3 and (not exerciseTime1 or not exerciseTime2 or not exerciseTime3 or not exerciseTime4 or not exerciseTime5):
            raise serializers.ValidationError("5 exerciseTimes are required when exerciseAlarmCnt is 5")

        return data
