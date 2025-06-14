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

        stage('UFW Firewall Configuration') {
            steps {
                sh '''
                echo "=== Enabling UFW and allowing necessary ports ==="
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
                echo "=== Cloning GitHub repo with PAT ==="
                if [ -d "${REPO_DIR}" ]; then
                    echo "Repo already exists. Pulling latest changes."
                    cd ${REPO_DIR}
                    git pull
                else
                    git clone https://ajithdevopsproject:${GIT_PAT}@github.com/ajithdevopsproject/Gabriels.git
                fi
                '''
            }
        }

        stage('Python Virtual Env & Requirements') {
            steps {
                sh '''
                echo "=== Setting up Python environment and installing requirements ==="
                cd ${REPO_DIR}
                if [ -d "django-venv" ]; then
                    echo "Removing old virtual environment..."
                    rm -rf django-venv
                fi

                python3 -m venv django-venv
                . django-venv/bin/activate

                echo "Writing requirements.txt"
                cat <<EOF > requirements.txt
asgiref==3.7.2
Django==4.2.4
mysqlclient==2.2.0
PyMySQL==1.1.0
sqlparse==0.4.4
tzdata==2023.3
EOF

                echo "Installing requirements..."
                pip install --upgrade pip
                pip install -r requirements.txt
                '''
            }
        }

        stage('Configure settings.py') {
            steps {
                sh '''
                echo "=== Configuring Django settings.py ==="
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

        stage('Run Migrations & Start Server') {
            steps {
                sh '''
                echo "=== Running migrations and starting Django server ==="
                cd ${REPO_DIR}
                . django-venv/bin/activate
                python manage.py migrate
                nohup python manage.py runserver 0.0.0.0:8000 &
                '''
            }
        }
    }
}
