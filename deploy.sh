docker build -t jperezsl/multi-client:latest -t jperezsl/multi-client:$SHA -f .client/Dockerfile ./client
docker build -t jperezsl/multi-server:latest -t jperezsl/multi-server:$SHA -f .server/Dockerfile ./server
docker build -t jperezsl/multi-worker:latest -t jperezsl/multi-worker:$SHA -f .worker/Dockerfile ./worker

docker push jperezsl/multi-client:latest
docker push jperezsl/multi-server:latest
docker push jperezsl/multi-worker:latest

docker push jperezsl/multi-client:$SHA
docker push jperezsl/multi-server:$SHA
docker push jperezsl/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=jperezsl/multi-server:$SHA
kubectl set image deployments/client-deployment client=jperezsl/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=jperezsl/multi-worker:$SHA
