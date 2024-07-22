===========  NODE  ===========
#melihat semua node
kubectl get node

#melihat detail node
kubectl describe node nginx



===========  POD  ===========
#melihat semua pod
kubectl get pod

#melihat detail pod
kubectl describe pod nginx

#membuat pod
kubectl create -f nginx.yaml

#melihat pod
kubectl get pod
kubectl get pod -o wide
kubectl describe pod nginx

#mengakses pod
kubectl port-forward namapod portAkses:portPod
kubectl port-forward nginx 8888:80

#menambahkan label di pod
kubectl create -f nginx.yaml
kubectl get pod --show-labels

#menambah label di pod
kubectl label pod nginx environment=development

#mengubah label di pod
kubectl label pod nginx environment=qa --overwrite

#melihat pod di namespace
kubectl get pod --namespace finance

#menghapus namespace
kubectl delete namespace finance

#menghapus pod
kubectl delete pod nginx

#menghapus pod by environment
kubectl delete pod -l environment=development



===========  RC  ===========

#melihat replication controller
kubectl get rc
kubectl get pod

#menghapus RC 
kubectl get rc
kubectl delete rc nginx-rc

#menghapus rc tetapi pod tidak terhapus
kubectl delete rc nginx-rc --cascade=false 


===========  RS  ===========
#melihat replicaset fitur baru dibandingkan dengan rc
kubectl get rs

#RS matchexpresion
kubectl get pod --show-labels

#get daemin set
kubectl get daemonsets

#delete daemonset
kubectl delete daemonsets daemon-nginx

===========  JOB  ===========
kubectl get all
kubectl get job
kubectl describe job nodejs-job
kubectl delete job nodejs-job


===========  CRON JOB  ===========
kubectl create -f cronjob-nodejs.yaml
kubectl logs nodejs-cronjob-28683592-xfdpz
kubectl describe cronjob nodejs-cron
kubectl delete cronjob nodejs-cronjob
kubectl get all


===========  ALL  ===========
kubectl get all
kubectl delete all --all

===========  SERVICE  ===========
kubectl create -f service-nginx.yaml
kubectl get service
kubectl get all
kubectl exec -it curl -- /bin/sh
curl http://10.103.89.160:8080
kubectl delete service service-nginx

===========  RUN SERVICE  ===========
kubectl create -f service-nginx.yaml
kubectl get service
kubectl get all
kubectl exec -it curl -- /bin/sh
env
NGINX_SERVICE_SERVICE_HOST=10.101.139.24
NGINX_SERVICE_SERVICE_PORT=8080

dns
curl http://nginx-service.default.svc.cluster.local:8080

#melihat semua endpoints
kubectl get endpoints

===========  EXTERNAL SERVICE  ===========
kubectl describe service nginx-service
kubectl create -f service-example.yaml
kubectl get all
kubectl get endpoints
kubectl exec -it curl -- /bin/sh
curl http://example-service.default.svc.cluster.local


===========  MENGEKSPOSE SERVICE  ===========
kubectl create -f service-nginx-nodeport.yaml
kubectl get all
minikube service nginx-service



===========  MINIKUBE INGRESS  ===========
brew install minikube
minikube start
minikube addons list
minikube addons enable ingress
kubectl get all --namespace kube-system
kubectl create -f service-nginx-ingres.yaml
kubectl get ingresses
kubectl delete ingress nginx-ingress
minikube ip

===========  MULTI CONTAINER PORT  ===========
kubectl create -f multi-container-pod.yaml
kubectl get all
kubectl exec -it curl -- /bin/sh

===========  VOLUME  ===========
kubectl create -f volume.yaml
kubectl get all
kubectl exec -it nodejs-writer -- /bin/sh
cd /app/html
ls 
cat index.html

===========  SHARING VOLUME  ===========
kubectl create -f sharing-volume.yaml
kubectl get all
minikube service nginx-service


===========  ENV VARIABEL  ===========
kubectl create -f environment-variabel.yaml
kubectl get all
kubectl exec -it nodejs-writer -- /bin/sh
env
cd /app/folder-from-env
ls
cat index.html


===========  CONFIG MAPS  ===========
kubectl create -f configmap.yaml
kubectl get all
kubectl get configmaps
kubectl describe configmap nodejs-env-config
kubectl exec -it nodejs-env-zms84 -- /bin/sh
env
kubectl delete configmap nodejs-env-config


===========  SECRET  ===========
kubectl create -f secret.yaml
kubectl get all
kubectl get configmaps
kubectl describe configmap nodejs-env-config
kubectl describe secrets
kubectl get all
kubectl exec -it nodejs-env-zp2mm -- /bin/sh
env
minikube service nodejs-env-service 


===========  DOWNWARD API  ===========
kubectl delete all --all
kubectl get all
kubectl create -f downward-api.yaml
kubectl get all
kubectl exec -it nodejs-env-pdmkk -- /bin/sh
env
minikube service nodejs-env-service


=========== MANAGEMENT KUBERNETES OBJECT  ===========
kubectl create -f nginx.yaml
kubectl get pods nginx
kubectl get -f nginx.yaml
kubectl get -f nginx.yaml -o yaml
kubectl get -f nginx.yaml -o json
kubectl replace -f nginx.yaml
kubectl delete -f nginx.yaml


=========== APPLY  ===========
kubectl apply -f nginx.yaml
kubectl get -f nginx.yaml -o json
kubectl delete -f nginx.yaml

kubectl create -f nginx.yaml
kubectl get -f nginx.yaml -o json
kubectl delete -f nginx.yaml


=========== DEPLOYMENT  ===========
kubectl get deployments
kubectl apply -f deployment.yaml
kubectl get deployments
kubectl get all
minikube service nodejs-web-service
kubectl describe deployment nodejs-web
kubectl delete -f deployment.yaml


=========== UPDATE DEPLOYMENT  ===========
kubectl apply -f deployment.yaml
kubectl get all
minikube service nodejs-web-service

kubectl apply -f deployment-update.yaml
kubectl get all

=========== ROLLBACK DEPLOYMENT  ===========
kubectl rollout
kubectl rollout history deployment nodejs-web
kubectl rollout status deployment nodejs-web
kubectl apply -f deployment-update-again.yaml
kubectl rollout history deployment nodejs-web
minikube service nodejs-web-service
kubectl rollout undo deployment nodejs-web
kubectl rollout status deployment nodejs-web
kubectl rollout history deployment nodejs-web
kubectl get all
kubectl delete -f deployment.yaml
kubectl get all
kubectl delete all --all


=========== PERSISTENT VOLUME  ===========
kubectl get pv
kubectl create -f persistent-volume.yaml
kubectl get -f persistent-volume.yaml
kubectl exec -it nodejs-writer  -- /bin/sh
cd /app/html
ls -l
cat index.html
kubectl describe pv nodejs-writer-volume 
kubectl get pvc
kubectl describe pvc nodejs-writer-volume 
kubectl delete pv nodejs-writer-volume 
kubectl delete pvc nodejs-writer-volume 


=========== STATEFULSET  ===========
kubectl create -f statefulset.yaml
kubectl get all
kubectl get pvc

kubectl describe statefulset nama
kubectl delete statefulset nama

=========== DASHBOARD  ===========
minikube addons enable dashboard
kubectl get all --namespace kubernetes-dashboard
minikube dashboard




===========  COMPUTATIONAL RESOURCES  ===========
kubectl apply -f resources.yaml
kubectl get all


===========  HORIZONTAL POD AUTOSCALER  (HPA) ===========
minikube addons list
minikube addons enable metrics-server
kubectl get all --namespace kube-system

kubectl apply -f horizontal-pod-autoscaler.yaml

kubectl get hpa
kubectl describe hpa nama

