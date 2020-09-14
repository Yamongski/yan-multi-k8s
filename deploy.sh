  
docker build -t yamongski/multi-client:latest -t yamongski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t yamongski/multi-server:latest -t yamongski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t yamongski/multi-worker:latest -t yamongski/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push yamongski/multi-client:latest
docker push yamongski/multi-server:latest
docker push yamongski/multi-worker:latest

docker push yamongski/multi-client:$SHA
docker push yamongski/multi-server:$SHA
docker push yamongski/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=yamongski/multi-server:$SHA
kubectl set image deployments/client-deployment client=yamongski/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=yamongski/multi-worker:$SHA