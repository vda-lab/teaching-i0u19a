# Port is 8005 because 5_DataStorage
docker run \
	-p 8005:8000 -p 35729:35729 \
	--name i0u19a-nosql \
	-v $PWD/images:/opt/presentation/images \
	-v $PWD/slides:/opt/presentation/slides \
	-d jandot/docker-presentation
