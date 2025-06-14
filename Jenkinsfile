pipeline {
    agent any

    environment {
        VENV_NAME = 'django-venv'
        MYSQL_DB = 'wiselearns_mari'
        MYSQL_USER = 'admin'
        MYSQL_PASSWORD = 'welcome'
        MYSQL_HOST = '65.2.69.41'
        MYSQL_PORT = '3306'
    }

    stages {
        stage('Create Python Virtual Environment') {
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

        stage('Update settings.py') {
            steps {
                sh '''
                    sed -i "s/'ENGINE':.*/'ENGINE': 'django.db.backends.mysql',/" Gabriels_task/Gabriels_task/settings.py
                    sed -i "s/'NAME':.*/'NAME': '${MYSQL_DB}',/" Gabriels_task/Gabriels_task/settings.py
                    sed -i "s/'USER':.*/'USER': '${MYSQL_USER}',/" Gabriels_task/Gabriels_task/settings.py
                    sed -i "s/'PASSWORD':.*/'PASSWORD': '${MYSQL_PASSWORD}',/" Gabriels_task/Gabriels_task/settings.py
                    sed -i "s/'HOST':.*/'HOST': '${MYSQL_HOST}',/" Gabriels_task/Gabriels_task/settings.py
                    sed -i "s/'PORT':.*/'PORT': '${MYSQL_PORT}'/" Gabriels_task/Gabriels_task/settings.py
                '''
            }
        }

        stage('Run Django Server') {
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
            echo '✅ Django app is running. Open http://<your-jenkins-server-ip>:8000/'
        }
        failure {
            echo '❌ Build failed. Please check console output for errors.'
        }
    }
}
