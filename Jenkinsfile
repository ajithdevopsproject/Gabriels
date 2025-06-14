pipeline {
    agent any

    environment {
        VENV = 'django-venv'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/ajithdevopsproject/Gabriels.git'
            }
        }

        stage('Create Virtual Environment') {
            steps {
                sh 'python3 -m venv ${VENV}'
                sh '. ${VENV}/bin/activate && pip install --upgrade pip'
            }
        }

        stage('Install Requirements') {
            steps {
                sh '. ${VENV}/bin/activate && pip install -r requirements.txt'
            }
        }

        stage('Run Django Server') {
            steps {
                sh '. ${VENV}/bin/activate && python manage.py runserver 0.0.0.0:8000'
            }
        }
    }
}
