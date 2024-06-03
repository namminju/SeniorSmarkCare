from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin, Permission, Group
from django.core.validators import MinValueValidator,RegexValidator
class UserManager(BaseUserManager):
    use_in_migrations = True
    #id = pk는 django에서 기본으로 설정되는 부분

    def create_user(self, userName, userPhone, password = None, **extra_fields) :
        if not userName:
            raise ValueError('must have userName')
        if not userPhone:
            raise ValueError('must have userPhone')
        user = self.model(
            userName = userName,
            userPhone = userPhone,
            **extra_fields,
        )
        user.set_password(password)
        user.save(using = self._db)
        return user
    
    def create_superuser(self, userName, userPhone, password = None, **extra_fields):
        user = self.create_user(
            userName = userName,
            userPhone = userPhone,
            password=password,
            **extra_fields,
        )
        user.is_admin = True
        user.is_superuser = True
        user.is_staff = True
        user.is_active = True
        user.save(using = self._db)
        return user
    
class User(AbstractBaseUser, PermissionsMixin):
    objects = UserManager()

    userName = models.CharField(max_length=255, unique=True)
    userPhone = models.CharField(
        max_length=11,
        unique=True,
        validators=[RegexValidator(regex=r'^01[0-9]{8,9}$', message='Enter a valid phone number')]
    )
    userBirth = models.DateField(null = True, blank = True)
    userGender = models.CharField(max_length=30, null = True, blank=True)
    userType = models.CharField(max_length= 30, null = True, blank = True)
    mealAlarmCnt = models.IntegerField(default=3, validators=[MinValueValidator(0)])
    exerciseAlarmCnt = models.IntegerField(default=3, validators=[MinValueValidator(0)])
    guardPhone = models.CharField(
        max_length=11,
        null=True,
        blank=True,
        validators=[RegexValidator(regex=r'^01[0-9]{8,9}$', message='Enter a valid phone number')]
    )
    is_admin = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    is_active = models.BooleanField(default=True)

    groups = models.ManyToManyField(Group, related_name='custom_user_set', blank=True)
    user_permissions = models.ManyToManyField(Permission, related_name='custom_user_set', blank=True)

    USERNAME_FIELD = 'userName'
    REQUIRED_FIELDS = ['userPhone']
