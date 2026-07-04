from django.contrib.auth.models import User as AuthUser
from django.core.management.base import BaseCommand
from django.utils import timezone

from accounts.models import User


class Command(BaseCommand):
    help = "Sync custom users with Django auth users"

    def handle(self, *args, **kwargs):

        users = User.objects.filter(user_auth__isnull=True)

        self.stdout.write(f"{users.count()} user(s) found.")

        for profile in users:

            username = profile.phone

            auth_user, created = AuthUser.objects.get_or_create(
                username=username,
                defaults={
                    "is_active": True,
                },
            )
            if created:
                auth_user.set_password("ChangeMe123!")
                auth_user.save()
                
            profile.user_auth = auth_user

            if not profile.register_date:
                profile.register_date = timezone.now()

            profile.save()

            self.stdout.write(
                self.style.SUCCESS(
                    f"{profile.phone} synced."
                )
            )

        self.stdout.write(
            self.style.SUCCESS("Finished.")
        )