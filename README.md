# Legolas

Requisitos: Docker Desktop e google-cloud-sdk instalados e configurados.


## Gcloud:
```
gcloud auth login --brief
gcloud auth configure-docker
```
Se no linux ocorrer algum error de libssl/python sei-la do que, use o seguinte comando:
```
export LD_LIBRARY_PATH=/usr/local/lib
```

## Docker
```
make up 
```
#### Parando o ambiente sem destruir o banco:
```
make down 
```