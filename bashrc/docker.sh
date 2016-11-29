
# remove all docker containers
function docker-rmall {
	docker ps -aq |
		while read container; do
			echo -n 'removing container: '
			docker rm $container
		done
}

# remove all docker images
function docker-rmiall {
	docker images -aq |
		while read image; do
			echo -n 'removing image: '
			docker rmi $image
		done
}
