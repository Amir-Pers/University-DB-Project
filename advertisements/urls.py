from django.urls import path, include
from . import views

app_name = "advertisements"

urlpatterns = [
    path("<int:ad_id>/", views.advertisement_detail, name="detail"),
    path("post_ad/", views.post_ad_view, name="post_ad"),
    path("delete/<int:ad_id>/", views.delete_ad_view, name="delete_ad"),
    path("edit/<int:ad_id>/", views.edit_ad_view, name="edit_ad"),
    path("toggle-status/<int:ad_id>/", views.toggle_ad_status_view, name="toggle_ad_status"),
]
