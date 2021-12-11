1) 192.168.49.44 - your docker host IP in Dockerfile
2) jvisualvm - run
3) install plugin VisualGC
```bash
docker build -t test .
docker run  -ti --rm -p9999:9999  -p9998:9998  test
```