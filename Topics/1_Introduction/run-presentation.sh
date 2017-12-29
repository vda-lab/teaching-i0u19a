# Port 8001 because 1_Introduction
docker run \
	-p 8001:8000 -p 35729:35729 \
	--name i0u19a-introduction \
	-v $PWD/images:/opt/presentation/images \
	-v $PWD/slides:/opt/presentation/slides \
	-d jandot/docker-presentation
