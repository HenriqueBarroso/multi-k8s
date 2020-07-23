docker build -t henriquebarroso/multi-client:latest -t henriquebarroso/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t henriquebarroso/multi-server:latest -t henriquebarroso/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t henriquebarroso/multi-worker:latest -t henriquebarroso/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push henriquebarroso/multi-client:latest
docker push henriquebarroso/multi-server:latest
docker push henriquebarroso/multi-worker:latest

docker push henriquebarroso/multi-client:$SHA
docker push henriquebarroso/multi-server:$SHA
docker push henriquebarroso/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=henriquebarroso/multi-server:$SHA
kubectl set image deployments/client-deployment client=henriquebarroso/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=henriquebarroso/multi-worker:$SHA
