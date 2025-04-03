build:
	docker-compose build

run:
	docker-compose up -d

stop:
	docker-compose down

shell:
	docker-compose exec image-processing bash

clean:
	docker image rm comic-to-text-image-processing

