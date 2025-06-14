pipeline {
    agent any

    environment {
        VENV_NAME = 'django-venv'
        MYSQL_DB = 'wiselearns_mari'
        MYSQL_USER = 'admin'
        MYSQL_PASSWORD = 'welcome'
        MYSQL_HOST = '65.2.69.41'
        MYSQL_PORT = '3306'
        SETTINGS_FILE = 'Gabriels_task/Gabriels_task/settings.py'
    }

    stages {
        stage('Install OS Dependencies') {
            steps {
                sh '''
                    PY_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
                    echo "Detected Python version: $PY_VERSION"
                    sudo apt update
                    sudo apt install -y python${PY_VERSION}-venv
                '''
            }
        }

        stage('Create Virtual Environment') {
            steps {
                sh '''
                    python3 -m venv ${VENV_NAME}
                    source ${VENV_NAME}/bin/activate
                '''
            }
        }

        stage('Install Python Requirements') {
            steps {
                sh '''
                    source ${VENV_NAME}/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Apply MySQL Script') {
            steps {
                sh '''
                    mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} -h${MYSQL_HOST} -P${MYSQL_PORT} ${MYSQL_DB} < mysql_script.sql
                '''
            }
        }

        stage('Update Django settings.py') {
            steps {
                sh '''
                    sed -i "s/'ENGINE':.*/'ENGINE': 'django.db.backends.mysql',/" ${SETTINGS_FILE}
                    sed -i "s/'NAME':.*/'NAME': '${MYSQL_DB}',/" ${SETTINGS_FILE}
                    sed -i "s/'USER':.*/'USER': '${MYSQL_USER}',/" ${SETTINGS_FILE}
                    sed -i "s/'PASSWORD':.*/'PASSWORD': '${MYSQL_PASSWORD}',/" ${SETTINGS_FILE}
                    sed -i "s/'HOST':.*/'HOST': '${MYSQL_HOST}',/" ${SETTINGS_FILE}
                    sed -i "s/'PORT':.*/'PORT': '${MYSQL_PORT}'/" ${SETTINGS_FILE}
                '''
            }
        }

        stage('Run Django App') {
            steps {
                sh '''
                    source ${VENV_NAME}/bin/activate
                    python manage.py migrate
                    nohup python manage.py runserver 0.0.0.0:8000 &
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Django app is running. Open http://<your-server-ip>:8000/'
        }
        failure {
            echo '❌ Build failed. Check the logs above.'
        }
    }
}
