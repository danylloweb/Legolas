CONTAINER_NAME=api2

install:
	make build
	make up
up:
	docker-compose up -d
	docker exec worker php-fpm --daemonize
	docker exec onboarding php-fpm --daemonize
	docker ps

down:
	docker-compose down

bash:
	docker exec -it $(CONTAINER_NAME) bash

build:
	docker-compose build

composer-install:
	docker exec $(CONTAINER_NAME) composer install --no-interaction --no-scripts
	docker exec $(CONTAINER_NAME) php artisan migrate

test:
ifdef FILTER
	make up
	make clear
	docker exec -t $(CONTAINER_NAME) composer unit-test -- --filter="$(FILTER)"
else
	make up
	make clear
	docker exec -t $(CONTAINER_NAME) composer unit-test
endif

logs:
	docker-compose logs --follow

clear:
	docker exec $(CONTAINER_NAME) sh -c "php artisan cache:clear"
	docker ps

