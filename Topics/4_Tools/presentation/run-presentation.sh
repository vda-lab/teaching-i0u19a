# Port 8004 because 4_Docker
docker run \
	-p 8004:8000 -p 35729:35729 \
	--name docker_presentation \
	-v $PWD/images:/opt/presentation/images \
	-v $PWD/slides:/opt/presentation/slides \
	-d jandot/docker-presentation
