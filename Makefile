
DIMAGE=myanyenv-ubuntu-10.04

all: build anyenv.tar.gz

build:
	docker build -t $(DIMAGE) .

anyenv.tar.gz:
	docker run --rm $(DIMAGE) tar zvcC /home/app .anyenv .config > $@


