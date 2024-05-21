from django.shortcuts import render, redirect, get_object_or_404
from holott.models import *
from django.contrib import auth
from django.contrib.auth import login, authenticate
from django.contrib.auth.models import User

def signup(request):
    if request.method == 'POST':
        if request.POST['pass1'] == request.POST['pass2']:
            user = User.objects.create_user(
                userName = request.POST['userName'],
                password = request.POST['pass1'],
            )
            auth.login(request, user)
            return redirect('/')
        return render(request, 'signup.html')
    return render(request, 'signup.html')
        

def mypage(request, id = 1):
    user = get_object_or_404(User, id = 1)
    return render(request, 'mypage.html', {'user': user})