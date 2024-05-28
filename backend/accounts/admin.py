from django.contrib import admin
from django.contrib.auth.admin import UserAdmin as BaseUserAdmin
from django.contrib.auth.models import Group
from .models import User

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
        ('Personal info', {'fields': ('userBirth', 'userGender', 'userType', 'guardPhone')}),
        ('Permissions', {'fields': ('is_admin', 'is_active', 'is_staff', 'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login',)}),
        ('Alarm Counts', {'fields': ('mealAlarmCnt', 'exerciseAlarmCnt')}),
    )
    list_display = ('userName', 'userPhone', 'is_admin')
    search_fields = ('userName', 'userPhone')
    ordering = ('userName',)

admin.site.register(User, UserAdmin)
admin.site.unregister(Group)
