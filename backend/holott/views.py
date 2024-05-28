from django.shortcuts import render
from django.contrib.auth.decorators import login_required
from holott.models import *

@login_required
def mypage(request):
    user = request.user
    return render(request, 'mypage.html', {'user': user})

def main(request):
    return render(request, 'main.html')