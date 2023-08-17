install-pytorch:
	pip install --upgrade pip &&\
		pip install -r requirements.txt

install-tensorflow:
	pip install --upgrade pip &&\
		pip install -r requirements-tensorflow.txt

lint:
	pylint --disable=R,C *.py

format:
	black ./

test:
	python -m pytest -vv --cov=hello test_hello.py

docker-build:
	docker build -t mlops-interop .

docker-run:
	docker run -p 5000:5000 mlops-interop

docker-debug:
	#to debug inside the container
	docker run -d -p 5000:5000 --name mlops-interop-container mlops-interop
	docker exec -it mlops-interop-container bash

docker-clean:
	#remove all images locally
	if [ -n "$$(docker images -aq)" ]; then \
		docker rmi -f $$(docker images -aq); \
	fi

all:
	install lint test