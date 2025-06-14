pipeline {
    agent any

    environment {
        REPO_URL = "https://github.com/ajithdevopsproject/Gabriels.git"
        REPO_DIR = "Gabriels"
        GIT_PAT = "your_actual_pat_here"
    }

    stages {
        stage('System Setup') {
            steps {
                sh '''
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
                sudo ufw --force enable
                sudo ufw allow 22
                sudo ufw allow 80
                sudo ufw allow 8000
                sudo ufw allow 3306
                '''
            }
        }

        stage('Clone Repo') {
            steps {
                sh '''
                rm -rf ${REPO_DIR}
                git clone https://ajithdevopsproject:${GIT_PAT}@github.com/ajithdevopsproject/Gabriels.git
                '''
            }
        }

        stage('Setup Python and Install Requirements') {
            steps {
                sh '''
                cd ${REPO_DIR}
                python3 -m venv django-venv
                source django-venv/bin/activate
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Configure Django settings') {
            steps {
                sh '''
                cd ${REPO_DIR}
                cat <<EOL > Gabriels_task/Gabriels_task/settings.py
ALLOWED_HOSTS = ['13.203.209.162']

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'wiselearns_mari',
        'USER': 'admin',
        'PASSWORD': 'Admin@123',
        'HOST': '13.203.209.162',
        'PORT': '3306'
    }
}
EOL
                '''
            }
        }

        stage('Run Django Server') {
            steps {
                sh '''
                cd ${REPO_DIR}
                source django-venv/bin/activate
                python manage.py migrate
                nohup python manage.py runserver 0.0.0.0:8000 &
                '''
            }
        }
    }
}
