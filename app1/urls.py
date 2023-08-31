from django.urls import path
from app1 import views
urlpatterns = [
    path('',views.home),
    path('filter-view',views.filterView),
    path('search-result',views.searchView),
]
