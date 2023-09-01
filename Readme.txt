1 Create virtual Environment
	python -m venv django-venv
	django-venv/Sources/activate

2 Install requirements
	pip install  -r requirements.txt

3 copy the code from mysql script
  Run MySQL script on work-bench
	Filename -> mysql_script.sql
	
4 database configuration in settings.py
	path -> Gabriels_task/Gabriels_task/settings.py
		
	DATABASES = {
    		'default': {
        		'ENGINE': 'django.db.backends.mysql',
        		'NAME': 'wiselearnz_mari',
        		'USER': '<your mysql username>',
        		'PASSWORD':'<your mysql password>',
        		'HOST':'<your host name>',
        		'PORT':'<your port number>'
    			}
		}

5 Run the Project
	python manage.py run server

6 open the link on the browser
	http://127.0.0.1:8000/

7 Add Some more data in mysql
