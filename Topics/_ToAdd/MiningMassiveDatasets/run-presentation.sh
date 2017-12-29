docker run \
	-p 8000:8000 -p 35729:35729 \
	--name docker_presentation \
	-v /Users/jaerts/GoogleDrive/_Teaching/I0U19A/2016-2017/MiningMassiveDatasets/images:/opt/presentation/images \
	-v /Users/jaerts/GoogleDrive/_Teaching/I0U19A/2016-2017/MiningMassiveDatasets/slides:/opt/presentation/slides \
	-d jandot/docker-presentation
