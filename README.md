# castlemock-docker
Build custom docker image for castlemock

## Usage
Start Castle Mock by running the following command:

```sh
docker run -d -p 8080:8080 ishinvin/castlemock
```

Castle Mock is now accessible from the following IP address:

```sh
http://{CONTAINER IP}:8080/castlemock
```
    
## Persistence
The data files created by Castle Mock can be accessed and stored outside the Docker container. In order to achieve this, you need to create a new volume. This is done by using the -v flag. Run the following command to store Castle Mock's data files in the directory your currenty at.  

    docker run -d -p 8080:8080 -v $(pwd):/root/.castlemock ishinvin/castlemock

## Import projects
We can import our existing castlemock projects when docker startup. To achieve this we need to put the `xml` into the folders that's predefined for `REST` and `SOAP` API. Those folders are `projects/rest` and `projects/soap`.

```sh
docker run -d -p 8080:8080 -v <your-project.xml>:/projects/rest ishinvin/castlemock
```

## Acknowledgments

* [https://github.com/castlemock/castlemock](https://github.com/castlemock/castlemock)
* [https://github.com/castlemock/docker](https://github.com/castlemock/docker)