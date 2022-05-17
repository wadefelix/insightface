

## docker build
```bash
docker build -t insightface - < Dockerfile

# download models from my local nas
docker build -t insightface:buffalo_l --build-arg=DEFAULT_MP_NAME=buffalo_l --build-arg=DEFAULT_MP_NAME_DOWNLOAD_URL=http://my.nas/softwares/models/buffalo_l.zip - < Dockerfile
```

### mxnet retinaface-R50
```bash
docker build -t insightface:retinaface-R50 --build-arg=DEFAULT_MP_NAME=retinaface-R50 --build-arg=DEFAULT_MP_NAME_DOWNLOAD_URL=http://my.nas/softwares/models/retinaface-R50.zip - < retinaface.mx.Dockerfile
```


