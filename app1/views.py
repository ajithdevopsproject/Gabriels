from django.shortcuts import render
from app1.models import Userdataa
from django.views.decorators.csrf import csrf_exempt
import string
import json
# Create your views here.

a2z = string.ascii_uppercase
def home(request):
    users = Userdataa.objects.all()
    global a2z
    context = {
        'usrs':users,
        'a2z':a2z
    }
    return render(request,'home.html',context)

@csrf_exempt
def filterView(request):
     if request.method == 'POST':
        data = json.loads(request.body)
        searchVal = data['value']
        global a2z
        users = Userdataa.objects.filter(username__startswith=searchVal)
        context = {
            'usrs':users,
            'searchVal':searchVal,
            'a2z':a2z
            }
        return render(request,'filter-view.html',context)

@csrf_exempt
def searchView(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        val = data['value']
        users = Userdataa.objects.filter(username__contains = val.capitalize())
        users = users.union(Userdataa.objects.filter(username__contains=val.lower()))
        users = users.union(Userdataa.objects.filter(username__contains=val.upper()))
        global a2z
        context = {
            'usrs':users,
            'a2z':a2z,
        }
        return render(request,'search-result.html',context)