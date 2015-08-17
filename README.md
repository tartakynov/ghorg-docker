# Build the image

You can build the image as:

```
docker build -t ghorg .
```

# Start a container

In order to use the Docker image you've just built:

```
docker run -it ghorg /etc/bootstrap.sh
```

