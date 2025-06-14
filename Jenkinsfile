pipeline {
    agent any
    environment {
        VENV = 'django-venv'
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/ajithdevopsproject/Gabriels.git'
            }
        }

        stage('Install MySQL & Configure Port') {
            steps {
                sh '''
                    sudo apt update
                    sudo apt install -y mysql-server

                    # Allow external connections
                    sudo sed -i "s/^bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf
                    sudo systemctl restart mysql

                    # Open port 3306 if UFW is enabled
                    sudo ufw allow 3306/tcp || true
                '''
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
