from django.urls import path, include
from . import views

app_name = "advertisements"

urlpatterns = [
    path("<int:ad_id>/", views.advertisement_detail, name="detail"),
    path("post_ad/", views.post_ad_view, name="post_ad"),
    path("delete/<int:ad_id>/", views.delete_ad_view, name="delete_ad")
]
