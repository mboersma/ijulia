
ifndef IMAGE
	IMAGE = mboersma/ijulia
endif

ifndef TAG
 	TAG = latest
endif

ifndef VOLUME
	VOLUME = $(shell pwd)/notebooks
endif

run:
	docker run -it -p 8888:8888 -v $(VOLUME):/notebooks $(IMAGE):$(TAG)

build:
	docker build -t $(IMAGE):$(TAG) .

clean:
	docker rmi $(IMAGE):$(TAG)

full-clean:
	docker images -q $(IMAGE) | xargs docker rmi -f
