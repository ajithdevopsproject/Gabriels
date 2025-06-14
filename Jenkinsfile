pipeline {
    agent any

    environment {
        VENV = 'django-venv'
        DJANGO_PORT = '8000'
        MYSQL_PORT = '3306'
        MYSQL_HOST = '172.31.12.126'
        MYSQL_USER = 'admin'
        MYSQL_PASSWORD = 'Admin@123'
        MYSQL_DB = 'wiselearns_mari'
        MYSQL_SCRIPT = 'mysql_script.sql'
    }

    stages {
        stage('System Update and Firewall Config') {
            steps {
                sh '''
                    echo "Granting Jenkins user full access..."
                    echo "jenkins ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/jenkins

                    echo "Updating packages and opening ports..."
                    sudo apt update -y
                    sudo apt install -y python3-venv python3-pip mysql-client ufw

                    # Open MySQL and Django ports
                    sudo ufw allow ${MYSQL_PORT}/tcp
                    sudo ufw allow ${DJANGO_PORT}/tcp
                    sudo ufw --force enable

                    echo "System and firewall configuration complete."
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

        stage('Run MySQL Script') {
            steps {
                sh '''
                    echo "Executing MySQL initialization script..."
                    mysql -h ${MYSQL_HOST} -P 80 -u ${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DB} < ${MYSQL_SCRIPT}
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
