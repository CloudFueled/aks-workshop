# 🛠️ Lab 3.03 - Deploying with precision – Helm Charts

### **Imperial engineering doctrine: automated deployments with Helm**

With the Empire’s infrastructure spanning thousands of systems, manual deployments have proven inefficient and error-prone. The High Command now mandates use of **Helm** to deploy applications reliably and consistently across the galaxy.

Helm provides standardization and reusability, much like the stormtrooper armor—modular, battle-tested, and easy to replicate.

> _“You may fire when ready… just make sure you installed it with the correct values.”_ – Grand Moff Tarkin

---

## 🎯 Mission objectives

You will:

- Deploy an application using a public Helm chart
- Inspect installed Helm releases and their configuration
- Uninstall and clean up Helm deployments
- Re-deploy the chart with a custom `values.yaml`

---

## 🧭 Step-by-step: Helm in the service of the Empire

1.  Ensure Helm Is Installed

Verify that Helm is installed:

```bash
helm version
```

If not, install Helm following the [official guide](https://helm.sh/docs/intro/install/).

2.  Add a Helm Repository

Add the Bitnami Helm repo (or another public repo):

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

3.  Install a Helm Chart

Install NGINX from Bitnami:

```bash
helm install nginx bitnami/nginx
```

4.  Inspect Helm Releases

- List installed Helm releases

```bash
helm list
```

- Check the values used

```bash
helm get values nginx
```

- Optional: View all resources deployed by Helm:

```bash
kubectl get all -l app.kubernetes.io/instance=nginx
```

5.  Uninstall the Release

- Clean up the deployment:

```bash
helm uninstall nginx
```

- Confirm the resources are removed:

```bash
kubectl get all -l app.kubernetes.io/instance=nginx
```

6.  Deploy with Custom Imperial Configuration

Now deploy NGINX with a custom `values.yaml`—because the Empire requires tailored deployments.

Create a file named `values.yaml` with:

```yaml
service:
  type: LoadBalancer
  port: 8080

replicaCount: 3

ingress:
  enabled: false

resources:
  limits:
    cpu: 500m
    memory: 256Mi
  requests:
    cpu: 250m
    memory: 128Mi
```

Install the chart with custom values.

```bash
helm install nginx bitnami/nginx -f values.yaml
```

---

### 07. Verify Custom Configuration

- Ensure the service type is `LoadBalancer` and uses port `8080`:

  ```bash
  kubectl get svc nginx
  ```

- Confirm 3 pods are running:

  ```bash
  kubectl get pods -l app.kubernetes.io/instance=nginx
  ```

- Check resource requests and limits:

  ```bash
  kubectl describe pod <nginx-pod-name>
  ```

## 📚 Resources

* [Helm Commands](https://helm.sh/docs/helm/)
* [Helm Cheatsheet](https://helm.sh/docs/intro/cheatsheet/)
* [Bitnami Charts](https://charts.bitnami.com/)
