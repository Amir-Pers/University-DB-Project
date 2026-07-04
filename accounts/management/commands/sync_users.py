from django.core.management.base import BaseCommand


class Command(BaseCommand):
    help = "Sync custom users with Django auth users"

    def handle(self, *args, **kwargs):
        self.stdout.write(
            self.style.SUCCESS("sync_users command is working.")
        )