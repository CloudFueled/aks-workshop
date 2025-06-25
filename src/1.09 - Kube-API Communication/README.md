# 🔐 Lab 1.08 – Internal Comms: Talking to the Kube API from a Pod

### **Mission: Secret Retrieval Protocol**

To minimize surface exposure and reduce the risk of espionage, the Empire now mandates that sensitive information—such as access codes or encryption keys—be accessed _only_ from within the cluster, using secure API calls.

As part of the **Imperial SecureOps Task Force**, your task is to access a Kubernetes **Secret** from within a running pod by calling the **Kubernetes API** directly using the mounted service account token.

> _“If you want secure data, you don’t broadcast it across the galaxy—you go to the source.”_ – Director Krennic

---

## 🎯 Mission Objective

From inside a pod:

1. Access the Kubernetes API Server
2. Authenticate using the pod's service account token
3. Query a Secret named `encryption-codes` from namespace `imperial-datavault`
4. Decode the result

---

## 📁 Prerequisites

A secret has already been created in your cluster:

```bash
kubectl create secret generic encryption-codes \
  --from-literal=deathstar_plans=encrypted-hex
```

---

## 🧭 Step-by-step Instructions

### ⚙️ Phase I: Deploy a Test Pod

Start a temporary pod with curl and jq:

```bash
kubectl run secret-scanner \
  --image=radial/busyboxplus:curl \
  --restart=Never -it --rm
```

---

### ⚙️ Phase II: Discover the API Server

Inside the pod:

```bash
echo $KUBERNETES_SERVICE_HOST
```

Typically, this will be `10.0.0.1` or similar.

---

### ⚙️ Phase III: Use the Service Account Token

Inside the pod:

```bash
cat /var/run/secrets/kubernetes.io/serviceaccount/token
```

Save the token:

```bash
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
```

---

### ⚙️ Phase IV: Make the API Call

Run the following command inside the pod:

```bash
curl -sSk \
  -H "Authorization: Bearer $TOKEN" \
  https://$KUBERNETES_SERVICE_HOST/api/v1/namespaces/default/secrets/encryption-codes
```

Do you see the secret? Probably not! The default service account does not have permission to access secrets in the `default` namespace.

Let's fix the permissions of the default service account to allow secret access in the default namespace:
Run the following command outside the pod:

```bash
kubectl apply -f - <<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: namespace-reader
rules:
- apiGroups: [""]
  resources: ["secrets"]
  verbs: ["get", "list"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: default-namespace-reader
subjects:
- kind: ServiceAccount
  name: default
  namespace: default
roleRef:
  kind: ClusterRole
  name: namespace-reader
  apiGroup: rbac.authorization.k8s.io
EOF
```

This will grant the default service account in the `default` namespace permission to read secrets.

Try the API call again.

> 🔎 You should see a base64-encoded secret object.

---

### ⚙️ Phase V: Decode the Secret

```bash
echo "<base64_string>" | base64 -d
```

Replace `<base64_string>` with the value under `.data.deathstar_plans` from the previous step.

---
