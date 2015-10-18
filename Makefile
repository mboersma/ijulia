
ifndef NAME
	NAME = ijulia
endif

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
# start a new ijulia notebook webserver at [docker ip]:8888
	docker run --name=$(NAME) --rm -it -p 8888:8888 -v $(VOLUME):/notebooks $(IMAGE):$(TAG)

shell:
# open a bash shell in the currently running ijulia container
	docker exec -it $(NAME) bash

julia:
# open a new interactive julia command-line REPL session
	docker run -rm -it -p :8888 -v $(VOLUME):/notebooks $(IMAGE):$(TAG) julia

pull:
# pull the mboersma/ijulia:latest docker image from Docker Hub
	docker pull $(IMAGE):$(TAG)

build:
# build the mboersma/ijulia:latest docker image
	docker build -t $(IMAGE):$(TAG) .

clean:
# remove the ijulia docker container and mboersma/ijulia:latest docker image
	-docker rm $(NAME)
	-docker rmi $(IMAGE):$(TAG)

full-clean:
# force removal of all mboersma/ijulia docker images
	-docker images -q $(IMAGE) | xargs docker rmi -f
