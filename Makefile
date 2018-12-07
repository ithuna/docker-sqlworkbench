.DEFAULT_GOAL := fresh

build:
	docker build -t sqlworkbench .

clean:
	docker system prune -f

enter:
	docker run --rm -it sqlworkbench sh

run:
	docker run --rm sqlworkbench

fresh: clean build
