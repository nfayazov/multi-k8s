docker build -t nfayazov/multi-client:latest -t nfayazov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nfayazov/multi-server:latest -t nfayazov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nfayazov/multi-worker:latest -t nfayazov/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nfayazov/multi-client:latest
docker push nfayazov/multi-server:latest
docker push nfayazov/multi-worker:latest

docker push nfayazov/multi-client:$SHA
docker push nfayazov/multi-server:$SHA
docker push nfayazov/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nfayazov/multi-server:$SHA
kubectl set image deployments/client-deployment client=nfayazov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nfayazov/multi-worker:$SHA
