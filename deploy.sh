docker build -t jperezsl/multi-client:latest -t jperezsl/multi-client:$SHA -f .client/Dockerfile ./client
docker build -t jperezsl/multi-server:latest -t jperezsl/multi-server:$SHA -f .server/Dockerfile ./server
docker build -t jperezsl/multi-worker:latest -t jperezsl/multi-worker:$SHA -f .worker/Dockerfile ./worker

docker push jperezsl/multi-client:latest
docker push jperezsl/multi-client:$SHA

docker push jperezsl/multi-server:latest
docker push jperezsl/multi-server:$SHA

docker push jperezsl/multi-worker:latest
docker push jperezsl/multi-worker:$SHA

kubctl apply -f k8s
kubctl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubctl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubctl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA
