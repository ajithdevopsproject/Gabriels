pipeline {
    agent any

    environment {
        REPO_URL = "https://github.com/ajithdevopsproject/Gabriels.git"
        REPO_DIR = "Gabriels"
        GIT_PAT = "your_actual_github_pat"  // Replace with real PAT securely using Jenkins credentials
        DJANGO_HOST = "13.203.209.162"      // Your EC2 public IP
    }

    stages {

        stage('System Setup') {
            steps {
                sh '''
                echo "=== Installing packages ==="
                sudo apt update -y
                sudo apt install -y python3 python3-pip python3-venv \
                    default-libmysqlclient-dev build-essential \
                    pkg-config libmysqlclient-dev ufw git curl
                '''
            }
        }

        stage('Configure Firewall') {
            steps {
                sh '''
                echo "=== Configuring UFW ==="
                sudo ufw --force enable
                sudo ufw allow 22
                sudo ufw allow 80
                sudo ufw allow 8000
                sudo ufw allow 3306
                sudo ufw reload
                '''
            }
        }

        stage('Clone Project') {
            steps {
                sh '''
                echo "=== Cloning GitHub Repo ==="
                rm -rf ${REPO_DIR}
                git clone https://ajithdevopsproject:${GIT_PAT}@github.com/ajithdevopsproject/Gabriels.git
                '''
            }
        }

        stage('Python Environment Setup') {
            steps {
                sh '''
                echo "=== Creating virtualenv & installing requirements ==="
                cd ${REPO_DIR}
                python3 -m venv django-venv
                source django-venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt
                '''
            }
        }

        stage('Update settings.py') {
            steps {
                sh '''
                echo "=== Updating settings.py ==="
                cd ${REPO_DIR}/Gabriels_task/Gabriels_task

                cat > settings.py <<EOF
from pathlib import Path
import os

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = 'django-insecure-fake-key'

DEBUG = True

ALLOWED_HOSTS = ['${DJANGO_HOST}', 'localhost', '127.0.0.1']

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'app1',
]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'Gabriels_task.urls'

TEMPLATES = [{
    'BACKEND': 'django.template.backends.django.DjangoTemplates',
    'DIRS': [BASE_DIR / 'templates'],
    'APP_DIRS': True,
    'OPTIONS': {
        'context_processors': [
            'django.template.context_processors.debug',
            'django.template.context_processors.request',
            'django.contrib.auth.context_processors.auth',
            'django.contrib.messages.context_processors.messages',
        ],
    },
}]

WSGI_APPLICATION = 'Gabriels_task.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'wiselearns_mari',
        'USER': 'admin',
        'PASSWORD': 'Admin@123',
        'HOST': '${DJANGO_HOST}',
        'PORT': '3306',
    }
}

AUTH_PASSWORD_VALIDATORS = []

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

STATIC_URL = '/static/'
STATICFILES_DIRS = [BASE_DIR / 'static']
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
EOF
                '''
            }
        }

        stage('Run Django App') {
            steps {
                sh '''
                echo "=== Starting Django App ==="
                cd ${REPO_DIR}
                source django-venv/bin/activate

                python manage.py makemigrations
                python manage.py migrate

                echo "Launching app..."
                nohup python manage.py runserver 0.0.0.0:8000 > server.log 2>&1 &
                sleep 5
                curl -I http://localhost:8000 || true
                '''
            }
        }
    }
}
