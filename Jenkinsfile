pipeline {
    agent any

    environment {
        REPO_URL = "https://github.com/ajithdevopsproject/Gabriels.git"
        REPO_DIR = "Gabriels"
        GIT_PAT = "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"
    }

    stages {
        stage('System Setup') {
            steps {
                sh '''
                echo "=== Updating system packages ==="
                sudo apt update -y
                sudo apt upgrade -y

                echo "=== Installing Python3, pip, venv, MySQL client, and build tools ==="
                sudo apt install -y python3 python3-pip python3-venv \
                    default-libmysqlclient-dev build-essential \
                    pkg-config libmysqlclient-dev ufw

                
                '''
            }
        }
stage('UFW and allowing necessary ports') {
            steps {
                sh '''
                echo "=== Enabling UFW and allowing necessary ports ==="
                sudo ufw --force enable
                sudo ufw allow 22
                sudo ufw allow 80
                sudo ufw allow 8000
                sudo ufw allow 8080
		        sudo ufw allow 8306
                sudo ufw reload
                '''
            }
        }

        stage('Clone Repo') {
            steps {
                sh '''
                echo "=== Cloning your GitHub project using PAT ==="
                if [ -d "${REPO_DIR}" ]; then
                    echo "Directory '${REPO_DIR}' already exists. Skipping clone."
                else
                    git clone https://ajithdevopsproject:${GIT_PAT}@github.com/ajithdevopsproject/Gabriels.git
                fi
                '''
            }
        }

        stage('Setup Python Virtual Env') {
            steps {
                sh '''
                cd ${REPO_DIR}
                echo "=== Creating virtual environment ==="
                if [ -d "django-venv" ]; then
                    echo "Removing existing virtual environment..."
                    rm -rf django-venv
                fi

                python3 -m venv django-venv
                source django-venv/bin/activate

                echo "=== Installing Python requirements ==="
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Configure settings.py') {
            steps {
                sh '''
                cd ${REPO_DIR}
                echo "=== Configuring settings.py ==="
                cat <<EOL > Gabriels_task/Gabriels_task/settings.py
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'wiselearns_mari',
        'USER': 'admin',
        'PASSWORD': 'Admin@123',
        'HOST': '13.204.81.191',
        'PORT': '3306'
    }
}
EOL
                '''
            }
        }

        stage('Apply Migrations and Run Server') {
            steps {
                sh '''
                cd ${REPO_DIR}
                source django-venv/bin/activate
                echo "=== Running migrations ==="
                python manage.py migrate

                echo "=== Starting Django server ==="
                nohup python manage.py runserver 0.0.0.0:8000 &
                '''
            }
        }
    }
}
