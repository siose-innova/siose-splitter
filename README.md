# siose-splitter

One Paragraph of project description goes here.

This makefile helps to:

- Launch docker/docker-compose services.
- Load ROIs to a siose database.
- Build splits.
- Push splits to the fileserver.


## Getting started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.


## Prerrequisites

What things you need to install the software and how to install them:

- Docker
- Docker-compose
- Make
- Images from the siose-docker-library


## Installing

A step by step series of examples that tell you how to get a development env running

0. Iniciar los servicios necesarios

```bash
make setup
```

Añadiendo un cliente ligero para explorar la base de datos
```bash
make pgclient=psql start-services
```
O añadiendo pgadmin4
```bash
make pgclient=pgadmin start-services
```


1. Descargar un listado de geohashes que interesa en cada caso:

```bash
make setup
```

2. Crear un fichero *.gh por cada geohash para facilitar el trabajo con Make.
3. Obtener `splits` del SIOSE en un formato específico.
4. Obtener todos los `splits` en todos los formatos.
5. ...

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system


## Contributing

Please read [CONTRIBUTING.md](https://gist.github.com/PurpleBooth/b24679402957c63ec426) for details on our code of conduct, and the process for submitting pull requests to us.


## Versioning

For the versions available, see the [tags on this repository](https://github.com/siose-innova/siose-splitter/tags). 


## Authors

- **Benito Zaragozí** - *Initial work* - [benito-zaragozi.com](http://benito-zaragozi.com)

See also the list of [contributors](https://github.com/siose-innova/siose-splitter/contributors) who participated in this project.

## License

This project is licensed under the GPL License - see the [LICENSE.md](LICENSE.md) file for details.

## Acknowledgments

* Hat tip to anyone whose code was used
* Inspiration
* etc


## TODOs

- Implement a logging strategy [See this thread](https://stackoverflow.com/questions/8483149/gnu-make-timing-a-build-is-it-possible-to-have-a-target-whose-recipe-executes)
- Test make -j + compose scale. make -j works pretty good, but compose --scale seems to make no difference.
