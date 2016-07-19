# Adapt Authoring Dockerfile

A Dockerfile that follows instructions on the Adapt Authoring Wiki page for [server installation](https://github.com/adaptlearning/adapt_authoring/wiki/Install-on-Server) up to the `node install` step.

## Instructions

1. Install [Docker](https://www.docker.com/)

2. Build the adapt authoring dockerfile

	```
docker build --no-cache -t "adapt-authoring-bravo-branch" .
```

3. Verify the image built successfully (you should see it listed by name from step 2)
	```
docker images
```


3. Run the docker container which will forward port 80 to the docker mongodb on port 5000 of the container

	```
docker docker run -t -d -p 80:5000 adapt-authoring-bravo-branch
``` 

4. Connect to the authoring tool using a browser

	```
http://192.168.99.100/
``` 

5. Username / Password
	```
bravolt / bravolt
``` 

6. Enjoy! ;)