pipeline {
    agent any

    environment {
        REPO_URL = "https://github.com/ajithdevopsproject/Gabriels.git"
        REPO_DIR = "Gabriels"
        GIT_PAT = "your_actual_github_pat"  // ❗Replace with your actual GitHub Personal Access Token
        DJANGO_HOST = "13.203.209.162"      // ✅ Use public IP or domain here
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
                git clone https://ajithdevopsproject:${GIT_PAT}@github.com/ajithdevopsproject/Gabriels.git
                '''
            }
        }

        stage('Set Up Python Environment') {
            steps {
                sh '''
                echo "=== Creating Python virtual environment and installing requirements ==="
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
                echo "=== Writing settings.py with DB and ALLOWED_HOSTS ==="
                cd ${REPO_DIR}
                mkdir -p Gabriels_task/Gabriels_task
                cat <<EOL > Gabriels_task/Gabriels_task/settings.py
ALLOWED_HOSTS = ['${DJANGO_HOST}']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'wiselearns_mari',
        'USER': 'admin',
        'PASSWORD': 'Admin@123',
        'HOST': '${DJANGO_HOST}',
        'PORT': '3306'
    }
}
EOL
                '''
            }
        }

        stage('Run Django Application') {
            steps {
                sh '''
                echo "=== Running Django app ==="
                cd ${REPO_DIR}
                bash -c '
                    source django-venv/bin/activate
                    python manage.py migrate
                    nohup python manage.py runserver 0.0.0.0:8000 &
                '
                '''
            }
        }
    }
}
