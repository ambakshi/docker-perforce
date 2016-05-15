# Docker Perforce Images

A collection of [Perforce](http://perforce.com) docker images:

- Perforce Base, an image containing the official repo and the p4 client
- Perforce P4D Server
- Perforce Git Fusion
- Perforce Swarm

## Installation

All operations on the images and repositories are encapsulated in Makefiles.

Build images (the Makefile's default target):

    $ make [image]

Tag your images with your repo username and push the images to the Docker registry:

    $ docker login
    $ DOCKER_REPO=ambakshi make image push

## Usage

The perforce server images are contained in their respective directories.
Each server comes with an example 'run' target that you can use to get
a server up and running quickly.

    $ make -C perforce-server run
    $ make -C


### docker-compose

Using docker-compose it is much simpler to setup a working environment. Modify the
`docker-compose.yml` and the supplied `envfile` to customize your site. Once done,
run:

    $ make
    $ docker-compose up -d perforce    # for p4d server
    $ docker-compose up -d gfperforce  # for p4d + git-fusion server

The perforce-git-fusion image is setup to run its own p4d server. If you prefer to
run a seperate git+ssh server and connect to a running p4d instance, please open a
PR.

## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

2014/12/24  - initial version
2016/05/14  - fixed perforce-git-fusion
2016/05/15  - added docker-compose support

## Credits

- Amit Bakshi (ambakshi@gmail.com)

## License

- [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)
