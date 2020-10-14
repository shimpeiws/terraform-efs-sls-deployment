```
docker build . --no-cache -f ../deployment-task/Dockerfile  --build-arg EFS_ENDPOINT="fs-50050671.efs.ap-northeast-1.amazonaws.com"  -t shimpeiws/efs-sls:1.0
```
