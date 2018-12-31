start:
	docker-compose up -d

stop:
	docker-compose stop 

build:
	docker-compose build

shell-db:
	docker exec -it equals_db_1 mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} equals

dump-db:
	docker exec -it container_db mysqldump -u${MYSQL_USER} -p${MYSQL_PASSWORD} --quick --lock-tables=false ${MYSQL_DATABASE} > dump.sql

restore-db:
	docker exec -it container_db mysql -u${MYSQL_USER} -p${MYSQL_PASSWORD} ${MYSQL_DATABASE} < dump.sql

shell:
	docker-compose run  admin-panel /bin/bash

composer-update:
	docker-compose run  admin-panel php -dmemory_limit=-1 /usr/local/bin/composer update

composer-install:
	docker-compose run  admin-panel php -dmemory_limit=-1 /usr/local/bin/composer install

cache:
	sudo chmod 777 -R app/cache/ app/logs/
	sudo rm -rf app/cache/*
	sudo chmod 777 -R app/cache/ app/logs/
