from django.shortcuts import render
from holott.models import *

def mypage(request, num = "1"):
    myInfo = User.objects.get(id = num)
    return render(request, 'mypage.html', {'myInfo': myInfo})