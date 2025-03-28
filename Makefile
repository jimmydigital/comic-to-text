build:
	docker-compose build

run:
	docker-compose up -d

stop:
	docker-compose down

shell:
	docker-compose exec image-processing bash
	