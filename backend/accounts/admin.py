from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.models import Group
from .models import *

class UserAdmin(BaseUserAdmin):
    # The forms to add and change user instances
    add_fieldsets = (
        (None, {
            'classes': ('wide',),
            'fields': ('userName', 'userPhone', 'password1', 'password2'),
        }),
    )
    fieldsets = (
        (None, {'fields': ('userName', 'userPhone', 'password')}),
        ('Permissions', {'fields': ('is_superuser','is_staff',)}),
    )
    list_display = ('userName', 'userPhone', 'is_superuser')
    list_filter = ('is_superuser', 'is_staff')
    search_fields = ('userName', 'userPhone')
    ordering = ('userName',)

class UserExtraInline(admin.StackedInline):
    model = UserExtra
    can_delete = False
    verbose_name_plural = "UserInfo"

class UserAdmin(UserAdmin):
    inlines = [UserExtraInline]

admin.site.register(User, UserAdmin)
admin.site.unregister(Group)
