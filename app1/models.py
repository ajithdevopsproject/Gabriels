from django.db import models

# Create your models here.

class Userdataa(models.Model):
    userid = models.AutoField(db_column='UserId', primary_key=True)  # Field name made lowercase.
    username = models.CharField(db_column='Username', max_length=20, blank=True, null=True)  # Field name made lowercase.
    useraddress = models.CharField(db_column='UserAddress', max_length=30, db_collation='utf8mb3_general_ci', blank=True, null=True)  # Field name made lowercase.
    userphone = models.CharField(db_column='UserPhone', max_length=25, db_collation='utf8mb3_general_ci', blank=True, null=True)  # Field name made lowercase.
    usermail = models.CharField(db_column='UserMail', max_length=20, blank=True, null=True)  # Field name made lowercase.
    userprofileimg = models.CharField(db_column='UserProfileImg', max_length=255, db_collation='utf8mb3_general_ci', blank=True, null=True)  # Field name made lowercase.
    dateupdated = models.DateTimeField(db_column='DateUpdated', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'userdataa'