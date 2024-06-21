from rest_framework import serializers
from .models import DailySymptom, Symptom

class SymptomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Symptom
        fields = ['id', 'name', 'display_name']

class HeadSymptomSerializer(serializers.ModelSerializer):
    head_symptoms = serializers.PrimaryKeyRelatedField(queryset=Symptom.objects.filter(category__name='HEAD'), many=True, required=False)

    class Meta:
        model = DailySymptom
        fields = ['symptom_date', 'head_symptoms']

    def create(self, validated_data):
        user = self.context['request'].user
        symptom_date = validated_data.get('symptom_date')
        head_symptoms = validated_data.pop('head_symptoms', [])

        daily_symptom, created = DailySymptom.objects.get_or_create(user=user, symptom_date=symptom_date)
        daily_symptom.head_symptoms.set(head_symptoms, clear=True)
        return daily_symptom

class UpperBodySymptomSerializer(serializers.ModelSerializer):
    upper_body_symptoms = serializers.PrimaryKeyRelatedField(queryset=Symptom.objects.filter(category__name='UPPER_BODY'), many=True, required=False)

    class Meta:
        model = DailySymptom
        fields = ['symptom_date', 'upper_body_symptoms']

    def create(self, validated_data):
        user = self.context['request'].user
        symptom_date = validated_data.get('symptom_date')
        upper_body_symptoms = validated_data.pop('upper_body_symptoms', [])

        daily_symptom, created = DailySymptom.objects.get_or_create(user=user, symptom_date=symptom_date)
        daily_symptom.upper_body_symptoms.set(upper_body_symptoms, clear=True)
        return daily_symptom

class LowerBodySymptomSerializer(serializers.ModelSerializer):
    lower_body_symptoms = serializers.PrimaryKeyRelatedField(queryset=Symptom.objects.filter(category__name='LOWER_BODY'), many=True, required=False)

    class Meta:
        model = DailySymptom
        fields = ['symptom_date', 'lower_body_symptoms']

    def create(self, validated_data):
        user = self.context['request'].user
        symptom_date = validated_data.get('symptom_date')
        lower_body_symptoms = validated_data.pop('lower_body_symptoms', [])

        daily_symptom, created = DailySymptom.objects.get_or_create(user=user, symptom_date=symptom_date)
        daily_symptom.lower_body_symptoms.set(lower_body_symptoms, clear=True)
        return daily_symptom

class HandFootSymptomSerializer(serializers.ModelSerializer):
    hand_foot_symptoms = serializers.PrimaryKeyRelatedField(queryset=Symptom.objects.filter(category__name='HAND_FOOT'), many=True, required=False)

    class Meta:
        model = DailySymptom
        fields = ['symptom_date', 'hand_foot_symptoms']

    def create(self, validated_data):
        user = self.context['request'].user
        symptom_date = validated_data.get('symptom_date')
        hand_foot_symptoms = validated_data.pop('hand_foot_symptoms', [])

        daily_symptom, created = DailySymptom.objects.get_or_create(user=user, symptom_date=symptom_date)
        daily_symptom.hand_foot_symptoms.set(hand_foot_symptoms, clear=True)
        return daily_symptom

class DailySymptomSerializer(serializers.ModelSerializer):
    head_symptoms = SymptomSerializer(many=True, read_only=True)
    upper_body_symptoms = SymptomSerializer(many=True, read_only=True)
    lower_body_symptoms = SymptomSerializer(many=True, read_only=True)
    hand_foot_symptoms = SymptomSerializer(many=True, read_only=True)

    class Meta:
        model = DailySymptom
        fields = ['symptom_date', 'head_symptoms', 'upper_body_symptoms', 'lower_body_symptoms', 'hand_foot_symptoms']
