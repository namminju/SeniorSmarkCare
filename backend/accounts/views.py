from django.shortcuts import render, redirect
from django.contrib.auth import login
from .models import User
from django.core.validators import RegexValidator
from django.core.exceptions import ValidationError, ObjectDoesNotExist

def signup(request):
    if request.method == 'POST':
        userName = request.POST.get('userName')
        userPhone = request.POST.get('userPhone')
        password1 = request.POST.get('password1')
        password2 = request.POST.get('password2')

        if not userName or not userPhone or not password1 or not password2:
            return render(request, 'signup.html', {'error': "All fields are required."})
        
        if password1 != password2:
            return render(request, 'signup.html', {'error': "Passwords don't match"})
        
        # Validate phone number
        phone_validator = RegexValidator(regex=r'^01[0-9]{8,9}$', message='Enter a valid phone number')
        try:
            phone_validator(userPhone)
        except ValidationError as e:
            return render(request, 'signup.html', {'error': e.message})
        
        # Create user
        try:
            user = User.objects.create_user(
                userName=userName,
                userPhone=userPhone,
                password=password1,
            )
            login(request, user)
            return redirect('/')
        except Exception as e:
            return render(request, 'signup.html', {'error': str(e)})

    return render(request, 'signup.html')
