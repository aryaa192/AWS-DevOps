## What is Kubernetes?
<sub>
Kubernetes (often abbreviated as "k8s") is an open-source platform for automating the deployment, scaling, and management of containerized applications. It provides a way to orchestrate and manage containers, allowing developers to focus on writing code rather than worrying about the underlying infrastructure.

Kubernetes was originally developed by Google, and is now maintained by the Cloud Native Computing Foundation (CNCF). It is widely adopted in the industry and is considered the de facto standard for container orchestration.

Kubernetes provides several key features, including:

Automatic scaling: Kubernetes can automatically scale the number of replicas of a containerized application based on demand.

Self-healing: Kubernetes can automatically replace or restart containers that have failed.

Load balancing: Kubernetes can automatically distribute incoming traffic across multiple replicas of a containerized application.

Automated rollouts and rollbacks: Kubernetes can automatically update and roll back the version of a containerized application.

Service discovery: Kubernetes can automatically discover and connect to other services within a cluster.

Namespaces: Kubernetes allows to create separate environments for different teams or projects within a cluster.

Kubernetes can be used with a variety of container runtimes, including Docker and containerd.

Overall Kubernetes is a powerful tool for managing containerized applications at scale, and its popularity continues to grow as more organizations adopt containerization and microservices architecture.




</sub>

### *********************** Kubernetes Cheat Sheet ***********************************

### Basic Commands:
```
> kubectl get pods: Lists all pods in the current namespace
> kubectl get services: Lists all services in the current namespace
> kubectl get deployments: Lists all deployments in the current namespace
> kubectl describe pod/<pod-name>: Describes the specified pod in detail
> kubectl logs <pod-name>: Shows the logs for the specified pod
> kubectl exec -it <pod-name> bash: Opens a shell in the specified pod
```
#### Pods:
```
> kubectl create -f <pod-definition-file.yml>: Create a pod from a yaml definition file
> kubectl delete pod <pod-name>: Delete a pod
> kubectl scale --replicas=<number> deployment/<deployment-name>: Scale a deployment to a specified number of replicas
```
#### Services:
```
> kubectl expose deployment <deployment-name> --type=LoadBalancer --port=<port> --target-port=<target-port>: Expose a deployment as a load-balanced service
> kubectl delete service <service-name>: Delete a service
```
#### Deployments:
```
> kubectl create -f <deployment-definition-file.yml>: Create a deployment from a yaml definition file
> kubectl apply -f <deployment-definition-file.yml>: Update an existing deployment with changes from a yaml definition file
> kubectl rollout undo deployment/<deployment-name>: Rollback a deployment to the previous version
```
#### ReplicaSets:
```
> kubectl get replicasets: Lists all ReplicaSets in the current namespace
> kubectl describe replicaset <replicaset-name>: Describes the specified ReplicaSet in detail
> kubectl scale --replicas=<number> replicaset <replicaset-name>: Scale a ReplicaSet to a specified number of replicas
```
#### Nodes:
```
> kubectl get nodes: Lists all nodes in the cluster
> kubectl describe node <node-name>: Describes the specified node in detail
> kubectl cordon <node-name>: Mark a node as unschedulable (to drain it of pods)
> kubectl uncordon <node-name>: Mark a node as schedulable
```
#### Namespaces:
```
> kubectl get namespaces: Lists all namespaces in the cluster
> kubectl create namespace <namespace-name>: Create a new namespace
> kubectl config set-context --current --namespace=<namespace-name>: Set the current namespace
```



