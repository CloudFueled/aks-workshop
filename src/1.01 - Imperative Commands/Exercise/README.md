# 🌌 Lab 1.01 - Imperial Rapid Deployment – mastering imperative commands

Sometimes, as an officer of the Empire, you must act swiftly—no time to craft manifests or YAML files. In the heat of battle, the ability to deploy and manage resources with a few typed commands can be the difference between victory and defeat.

In this exercise, you will **use only imperative `kubectl` commands** to complete your orders. No YAML files, just direct, immediate action.

---

## 🧭 Step-by-step: complete your Imperial Orders using imperative commands

1. Deploy a pod named `nginx` using the `nginx:alpine` image

2. Deploy a pod named `redis` with image `redis:alpine` and label `tier=db`

3. Create a ClusterIP service named `redis-service` to expose redis on port 6379

4. Create a deployment named `webapp` using the image `busybox` with 3 replicas. What do you spot when checking the deployment `webapp`? Do you know why?

5. Create a pod named `custom-nginx` using the `nginx` image, exposing container port 8080

6. Create a namespace named `dev-ns`

7. Create a deployment named `redis-deploy` in namespace `dev-ns` using image `redis` with 2 replicas

8. Create a pod named `httpd` using the image `httpd:alpine` in the `default` namespace and expose it as a ClusterIP service named `httpd` targeting port 80 (as few steps as possible)

9. Create a pod interactively named `curl` using the image `curlimages/curl:latest` in the `default` namespace, and curl the httpd pod

🧾 **Expected output**: <Your Answer>

10. Generate a YAML file for a deployment named `stormtrooper` using image `nginx`, without creating it

11. Restart the `webapp` deployment to simulate a redeploy scenario

12. Scale the `webapp` deployment to 5 replicas

13. Port forward traffic from your local machine (port 8080) to the httpd service (port 80). What do you see when you access `http://localhost:8080`?

🔗 Then access:
[http://localhost:8080](http://localhost:8080)
🧾 You’ll see the default Apache web page from the `httpd` pod.

14. Create a ConfigMap named `app-config` with the following key-value pairs:

* `ENV=prod`
* `LOG_LEVEL=debug`


15. Create a Secret named `db-secret` with:

* `username=admin`
* `password=imperial123`

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