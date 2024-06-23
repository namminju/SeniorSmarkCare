from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin, Permission, Group
from django.core.validators import RegexValidator
from django.dispatch import receiver
from django.db.models.signals import post_save


class UserManager(BaseUserManager):
    use_in_migrations = True
    #id = pk는 django에서 기본으로 설정되는 부분

    def create_user(self, userName, userPhone, password = None) :
        if not userName:
            raise ValueError('must have userName')
        if not userPhone:
            raise ValueError('must have userPhone')
        user = self.model(
            userName = userName,
            userPhone = userPhone,
        )
        user.set_password(password)
        user.save(using = self._db)
        return user
    
    def create_superuser(self, userName, userPhone, password = None):
        user = self.create_user(
            userName = userName,
            userPhone = userPhone,
            password = password,
        )
        user.is_superuser = True
        user.is_staff = True
        user.save(using = self._db)
        return user
    
class User(AbstractBaseUser, PermissionsMixin): #실제 유저 엔티티
    objects = UserManager()

    userName = models.CharField(max_length=255, unique=True)
    userPhone = models.CharField(
        max_length=11,
        unique=True,
        validators=[RegexValidator(regex=r'^01[0-9]{8,9}$', message='Enter a valid phone number')]
    )
    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)

    groups = models.ManyToManyField(Group, related_name='custom_user_set', blank=True)
    user_permissions = models.ManyToManyField(Permission, related_name='custom_user_set', blank=True)

    USERNAME_FIELD = 'userName'
    REQUIRED_FIELDS = ['userPhone']

def has_perm(self, perm, obj=None):
    return self.is_superuser

def has_module_perms(self, app_label):
    return self.is_superuser


class UserExtra(models.Model):
    GENDER_CHOICES = [
        ('Male', 'Male'),
        ('Female', 'Female'),
        ('Other', 'Other'),
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    #primary_key를 User의 pk로 설정하여 통합적으로 관리
    userBirth = models.DateField(null = True, blank = True)
    userGender = models.CharField(max_length=6, choices=GENDER_CHOICES, null = True, blank=True)
    guardPhone = models.CharField(
        max_length=11,
        null=True,
        blank=True,
        validators=[RegexValidator(regex=r'^01[0-9]{8,9}$', message='Enter a valid phone number')]
    )
    height = models.IntegerField(null=True, blank=True)
    weight = models.IntegerField(null=True, blank=True)
    hospitalCall = models.CharField(
        max_length=11,
        null=True,
        blank=True,
        validators=[RegexValidator(regex=r'^0[0-9]{8,10}$', message='Enter a valid call number')]
    )

class UserAddress(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, primary_key=True)
    postal_code = models.CharField(max_length=10, verbose_name="우편번호", blank=True, null=True)
    city = models.CharField(max_length=100, verbose_name="시/도", blank=True, null=True)
    district = models.CharField(max_length=100, verbose_name="시/군/구", blank=True, null=True)
    neighborhood = models.CharField(max_length=100, verbose_name="동/읍/면", blank=True, null=True)
    road_address = models.CharField(max_length=255, verbose_name="도로명 주소", blank=True, null=True)
    building_number = models.CharField(max_length=20, verbose_name="건물번호", blank=True, null=True)
    detailed_address = models.CharField(max_length=255, verbose_name="상세주소", blank=True, null=True)

    def __str__(self):
        return f"{self.postal_code}, {self.road_address}, {self.building_number}, {self.neighborhood}, {self.district}, {self.city}"


@receiver(post_save, sender = User)
def create_user_info(sender, instance, created, **kwargs):
    if created:
        UserExtra.objects.create(user = instance)