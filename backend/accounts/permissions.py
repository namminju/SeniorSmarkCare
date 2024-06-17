from rest_framework import permissions

class CustomReadOnly(permissions.BasePermission):
# GET : 누구나 / PUT,PATCH : 해당 유저만
# permissions.SAFE_METHODS - 우선은 세 메소드 전부 누구나

    def has_object_permission(self, request, view, obj):
        if request.method in ['GET', 'PATCH', 'PUT']: # 안전한 메소드(GET)면
            return True
        return obj.user == request.user