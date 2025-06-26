# 🌌 Lab 1.01 - Imperial Rapid Deployment – mastering imperative commands

Sometimes, as an officer of the Empire, you must act swiftly—no time to craft manifests or YAML files. In the heat of battle, the ability to deploy and manage resources with a few typed commands can be the difference between victory and defeat.

In this exercise, you will **use only imperative `kubectl` commands** to complete your orders. No YAML files, just direct, immediate action.

---

## 🧭 Step-by-step: complete your Imperial Orders using imperative commands

1. Deploy a pod named `nginx` using the `nginx:alpine` image

```bash
kubectl run nginx \
  --image=nginx:alpine
```

2. Deploy a pod named `redis` with image `redis:alpine` and label `tier=db`

```bash
kubectl run redis \
  --image=redis:alpine \
  --labels=tier=db
```

3. Create a ClusterIP service named `redis-service` to expose redis on port 6379
```bash
kubectl expose pod redis \
  --name=redis-service \
  --port=6379 \
  --target-port=6379 \
  --type=ClusterIP
```

4. Create a deployment named `webapp` using the image `busybox` with 3 replicas. What do you spot when checking the deployment `webapp`? Do you know why?
```bash
kubectl create deployment webapp \
  --image=busybox
  --replicas=3
```

5. Create a pod named `custom-nginx` using the `nginx` image, exposing container port 8080
```bash
kubectl run custom-nginx \
  --image=nginx \
  --port=8080
```

6. Create a namespace named `dev-ns`
```bash
kubectl create namespace dev-ns
```

7. Create a deployment named `redis-deploy` in namespace `dev-ns` using image `redis` with 2 replicas
```bash
kubectl create deployment redis-deploy --image=redis --replicas=2 -n dev-ns
```

8. Create a pod named `httpd` using the image `httpd:alpine` in the `default` namespace and expose it as a ClusterIP service named `httpd` targeting port 80 (as few steps as possible)
```bash
kubectl run httpd \
  --image=httpd:alpine \
  --port=80 \
  --expose
```

9. Create a pod interactively named `curl` using the image `curlimages/curl:latest` in the `default` namespace, and curl the httpd pod
```bash
kubectl run -it --rm curl \
  --image=curlimages/curl:latest \
  --restart=Never \
  -- sh
```

🧾 **Expected output**: It works!

10. Generate a YAML file for a deployment named `stormtrooper` using image `nginx`, without creating it
```bash
kubectl create deployment stormtrooper \
  --image=nginx \
  --dry-run=client \
  -o yaml > stormtrooper.yaml
```

11. Restart the `webapp` deployment to simulate a redeploy scenario
```bash
kubectl rollout restart deployment webapp
```

12. Scale the `webapp` deployment to 5 replicas
```bash
kubectl scale deployment webapp --replicas=5
```

13. Port forward traffic from your local machine (port 8080) to the httpd service (port 80). What do you see when you access `http://localhost:8080`?
```bash
kubectl port-forward service/httpd 8080:80
```

🔗 Then access:
[http://localhost:8080](http://localhost:8080)
🧾 You’ll see the default Apache web page from the `httpd` pod.

14. Create a ConfigMap named `app-config` with the following key-value pairs:

* `ENV=prod`
* `LOG_LEVEL=debug`

```bash
kubectl create configmap app-config --from-literal=ENV=prod --from-literal=LOG_LEVEL=debug
```

15. Create a Secret named `db-secret` with:

* `username=admin`
* `password=imperial123`

```bash
kubectl create secret generic db-secret --from-literal=username=admin --from-literal=password=imperial123
```

### Common `kubectl` verbs

Below are some commonly used verbs with `kubectl` and their purposes:

- **apply**: Apply a configuration to a resource by filename or stdin.
- **create**: Create a resource from a file or stdin.
- **delete**: Delete resources by file, name, or label selector.
- **get**: Display one or more resources.
- **describe**: Show detailed information about a specific resource or group of resources.
- **edit**: Edit a resource on the server.
- **logs**: Print the logs for a container in a pod.
- **exec**: Execute a command in a container.
- **scale**: Scale the number of replicas for a deployment, replica set, or replication controller.
- **rollout**: Manage the rollout of a resource (e.g., deployment).
- **port-forward**: Forward one or more local ports to a pod.
- **top**: Display resource (CPU/memory) usage of nodes or pods.
- **patch**: Update fields of a resource using a patch.
- **cp**: Copy files and directories to and from containers.
- **replace**: Replace a resource by filename or stdin.
- **annotate**: Add or update the annotations of a resource.
- **label**: Add or update the labels of a resource.

### Example commands

- **Get cluster info**:
  ```bash
  kubectl cluster-info
  ```
- **Get all nodes**:
  ```bash
  kubectl get node
  ```
- **Describe specific node**:
  ```bash
  kubectl describe node <node>
  ```
- **Get all namespaces**:
  ```bash
  kubectl get namespace
  ```
- **Change namespace**:
  ```bash
  kubectl config set-context --current --namespace <namespace>
  ```
- **List all pods**:
  ```bash
  kubectl get pods
  ```
- **Apply a configuration file**:
  ```bash
  kubectl apply -f <file.yaml>
  ```
- **Describe a resource**:
  ```bash
  kubectl describe <resource> <name>
  ```
- **Delete a resource**:
  ```bash
  kubectl delete <resource> <name>
  ```
  > **_IMPORTANT_:**
  > Don't use this if you don't know what you're doing to avoid unrecoverable loss

Replace `<resource>` with the type of resource (e.g., pod, service, deployment) and `<name>` with the name of the resource.  
For more advanced usage, refer to the official Kubernetes documentation.
