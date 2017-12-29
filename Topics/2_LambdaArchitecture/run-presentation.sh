# Port 8002 because 2_LambdaArchitecture
docker run \
	-p 8002:8000 -p 35729:35729 \
	--name i0u19a-lambda \
	-v $PWD/images:/opt/presentation/images \
	-v $PWD/slides:/opt/presentation/slides \
	-d jandot/docker-presentation
