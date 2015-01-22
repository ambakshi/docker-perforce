#### Perforce Server

This is how to iterate on the perforce server

    docker rm -f perforce || true
    make perforce-server-{image,tag}
    docker run -d -p 8080:8080 -p 1666:1666 -h perforce --name perforce ambakshi/perforce-server
    docker logs -f perforce

