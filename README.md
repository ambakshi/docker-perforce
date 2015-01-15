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
    $ DOCKER_REPO=ambakshi make image tag push

## Usage

The perforce server images are contained in their respective directories.
Each server comes with an example 'run' target that you can use to get
a server up and running quickly.

    $ make -C perforce-server run
    $ make -C


## Contributing

1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request :D

## History

2014/12/24  - initial version

## Credits

- Amit Bakshi (ambakshi@gmail.com)

## License

- [Apache License 2.0](http://www.apache.org/licenses/LICENSE-2.0)
