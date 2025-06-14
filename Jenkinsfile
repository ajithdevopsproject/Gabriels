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

                    echo "=== Installing required packages ==="
                    sudo apt install -y python3 python3-pip python3-venv \
                        default-libmysqlclient-dev build-essential \
                        pkg-config libmysqlclient-dev ufw
                '''
            }
        }

        stage('Configure Firewall') {
            steps {
                sh '''
                    echo "=== Enabling UFW and allowing ports ==="
                    sudo ufw --force enable
                    sudo ufw allow 22
                    sudo ufw allow 80
                    sudo ufw allow 8000
                    sudo ufw allow 8080
                    sudo ufw allow 3306
                    sudo ufw reload
                '''
            }
        }

        stage('Clone Repo') {
            steps {
                sh '''
                    echo "=== Cloning GitHub repo ==="
                    if [ -d "${REPO_DIR}" ]; then
                        echo "Repo already cloned."
                    else
                        git clone https://ajithdevopsproject:${GIT_PAT}@github.com/ajithdevopsproject/Gabriels.git
                    fi
                '''
            }
        }

        stage('Setup Python Environment & Install Requirements') {
            steps {
                sh '''
                    echo "=== Creating virtual environment and installing requirements ==="
                    cd ${REPO_DIR}
                    rm -rf django-venv
                    python3 -m venv django-venv
                    . django-venv/bin/activate && \
                    pip install --upgrade pip && \
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Configure settings.py') {
            steps {
                sh '''
                    echo "=== Writing custom DB config to settings.py ==="
                    cd ${REPO_DIR}
                    cat <<EOL > Gabriels_task/Gabriels_task/settings.py
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

        stage('Run Django') {
            steps {
                sh '''
                    echo "=== Running Django server ==="
                    cd ${REPO_DIR}
                    . django-venv/bin/activate && \
                    python manage.py migrate && \
                    nohup python manage.py runserver 0.0.0.0:8000 &
                '''
            }
        }
    }
}
