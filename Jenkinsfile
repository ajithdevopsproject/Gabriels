pipeline {
    agent any

    environment {
        VENV = 'django-venv'
        DJANGO_PORT = '8000'
        MYSQL_PORT = '3306'
    }

    stages {
        stage('System Update and Firewall Config') {
            steps {
                sh '''
                    echo "Updating packages and opening MySQL port..."
                    sudo apt update -y
                    sudo apt install python3-venv python3-pip ufw -y
                    
                    # Open MySQL port (3306) and Django port (8000)
                    sudo ufw allow ${MYSQL_PORT}/tcp
                    sudo ufw allow ${DJANGO_PORT}/tcp
                    sudo ufw --force enable
                    
                    echo "Firewall configured."
                '''
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ajithdevopsproject/Gabriels.git'
            }
        }

        stage('Create Virtual Environment') {
            steps {
                sh '''
                    python3 -m venv ${VENV}
                    . ${VENV}/bin/activate
                    pip install --upgrade pip
                '''
            }
        }

        stage('Install Requirements') {
            steps {
                sh '''
                    . ${VENV}/bin/activate
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Django Server') {
            steps {
                sh '''
                    echo "Starting Django server..."
                    . ${VENV}/bin/activate
                    nohup python manage.py runserver 0.0.0.0:${DJANGO_PORT} &
                '''
            }
        }
    }
}
