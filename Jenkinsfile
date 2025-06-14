pipeline {
    agent any

    environment {
        GIT_CREDENTIALS = credentials('github_pat') // Add your GitHub PAT to Jenkins credentials with ID: github_pat
        REPO_URL = "https://github.com/ajithdevopsproject/Gabriels.git"
        REPO_DIR = "Gabriels"
        DJANGO_HOST = "13.203.209.162" // Replace with your actual EC2 public IP
    }

    stages {

        stage('System Setup') {
            steps {
                sh '''
                echo "=== Updating system packages and installing dependencies ==="
                sudo apt update -y
                sudo apt install -y python3 python3-pip python3-venv \
                    default-libmysqlclient-dev build-essential \
                    pkg-config libmysqlclient-dev ufw git
                '''
            }
        }

        stage('Firewall Setup') {
            steps {
                sh '''
                echo "=== Configuring UFW Firewall ==="
                sudo ufw --force enable
                sudo ufw allow 22
                sudo ufw allow 80
                sudo ufw allow 8000
                sudo ufw allow 3306
                sudo ufw reload
                '''
            }
        }

        stage('Clone GitHub Repository') {
            steps {
                sh '''
                echo "=== Cloning GitHub repository ==="
                rm -rf ${REPO_DIR}
                git clone https://${GIT_CREDENTIALS}@github.com/ajithdevopsproject/Gabriels.git
                '''
            }
        }

        stage('Set Up Python Environment') {
            steps {
                sh '''
                echo "=== Creating virtual environment and installing Python packages ==="
                cd ${REPO_DIR}
                python3 -m venv django-venv
                bash -c '
                    source django-venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '
                '''
            }
        }

        stage('Configure Django settings.py') {
            steps {
                sh '''
                echo "=== Writing custom settings.py with DB and ALLOWED_HOSTS config ==="
                cd ${REPO_DIR}
                cat > Gabriels_task/Gabriels_task/settings.py <<EOF
from pathlib import Path
import os

BASE_DIR = Path(__file__).resolve().parent.parent
SECRET_KEY = 'django-insecure-0=)&kth-o5upqfqq-a^w*k3o7a&bmvvfv-k&9u9m74gol1a-z@'
DEBUG = True
ALLOWED_HOSTS = ['${DJANGO_HOST}']

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

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

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

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

STATIC_URL = 'static/'
STATICFILES_DIRS = [BASE_DIR / 'static']
MEDIA_URL = "/media/"
MEDIA_ROOT = os.path.join(BASE_DIR, "media")

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
EOF
                '''
            }
        }

        stage('Run Django Application') {
            steps {
                sh '''
                echo "=== Starting Django app with runserver ==="
                cd ${REPO_DIR}
                bash -c '
                    source django-venv/bin/activate
                    python manage.py makemigrations
                    python manage.py migrate
                    nohup python manage.py runserver 0.0.0.0:8000 &
                '
                '''
            }
        }
    }
}
