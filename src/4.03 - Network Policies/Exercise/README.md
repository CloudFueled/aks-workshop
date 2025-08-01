# 🚀 4.03 Cilium Networking and Hubble — *Interstellar Traffic Control*

### The Mission: Enforce Order Across the Starbase Network

The Galactic Starbase Network is in chaos.

Pods from various fleets (tenant-a, tenant-b, tenant-c) are able to communicate across sectors and even with unknown external systems. As the new **Interstellar Traffic Controller**, your job is to deploy an advanced visibility and security mesh using **Cilium** and **Hubble**.

To restore balance to this system, you must **observe** and then **control** network flows using Cilium Network Policies, backed by real-time flow data from Hubble.

> *"To monitor is to control. To visualize is to predict."* — CNI Admiral Elara Nox

---

## 🎯 Mission Objective

You will:

1. Deploy demo applications in three separate namespaces.
2. Validate Cilium and Hubble status.
3. Observe traffic flow using the Hubble CLI and UI.
4. Apply a deny-all policy and selectively allow traffic.
5. Verify enforcement using CLI and flows.

---

## 🧭 Step-by-Step: Bring Order to the Network Chaos

### ⚙️ Phase I: Deploy the Services

Create three isolated starbase namespaces:

```sh
kubectl create ns tenant-a
kubectl create ns tenant-b
kubectl create ns tenant-c
```

Deploy the same services into each namespace:

```sh
kubectl apply -f tenant.yaml -n tenant-a
kubectl apply -f tenant.yaml -n tenant-b
kubectl apply -f tenant.yaml -n tenant-c
```

Wait until all pods are up:

```sh
kubectl get pods --all-namespaces | grep tenant
```

---

### ⚙️ Phase II: Validate Cilium & Hubble Status

Confirm that Cilium components are healthy:

```sh
cilium status --wait
```

Validate Hubble connectivity:

```sh
hubble status
hubble list nodes
```

---

### ⚙️ Phase III: Observe Initial Flows

From `tenant-a`, issue traffic to various destinations:

```sh
kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-a

kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-b

kubectl exec -n tenant-a frontend-service -- \
  curl -sI https://api.twitter.com
```

Then inspect the outgoing TCP traffic using:

```sh
hubble observe --from-pod tenant-a/frontend-service --protocol tcp
```

Identify:

* Internal traffic within tenant-a
* Cross-namespace traffic
* External traffic

---

### ⚙️ Phase IV: Visualize in Hubble UI

1. Launch the Hubble UI.
2. Navigate to **Policies → tenant-a**.
3. You should see **no policy** and **all traffic marked FORWARDED**.

---

### ⚙️ Phase V: Apply a Cilium Deny-All Policy

Create a CiliumNetworkPolicy that denies all by default:

```yaml
# tenant-a-default-deny.yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: default
  namespace: tenant-a
spec:
  endpointSelector: {}
```

Apply it:

```sh
kubectl apply -f tenant-a-default-deny.yaml
```

Re-run the earlier curl tests — they should now **fail or time out**.

Use Hubble to confirm traffic is now **DROPPED**:

```sh
hubble observe --namespace tenant-a --verdict DROPPED
```

---

### ⚙️ Phase VI: Open the Right Channels

Now update the policy to allow:

* Ingress & egress within the namespace
* Egress to kube-dns (UDP 53)

```yaml
# tenant-a-allow-internal.yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: default
  namespace: tenant-a
spec:
  endpointSelector: {}
  ingress:
    - fromEndpoints:
        - {}
  egress:
    - toEndpoints:
        - {}
    - toEndpoints:
        - matchLabels:
            io.kubernetes.pod.namespace: kube-system
            k8s-app: kube-dns
      toPorts:
        - ports:
            - port: "53"
              protocol: UDP
          rules:
            dns:
              - matchPattern: "*"
```

Apply the updated policy:

```sh
kubectl apply -f tenant-a-allow-internal.yaml
```

Re-run internal curl test:

```sh
kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-a
```

✅ Success!

---

### ⚙️ Phase VII: Visualize & Refine in UI

Head to Hubble UI, and:

* Inspect dropped external traffic.
* Create a **new policy** named `extra` in namespace `tenant-a`.
* Use the dropped flows to **add rules** for:

  * Egress to `backend-service.tenant-b`
  * Egress to `api.twitter.com`

Apply and test:

```sh
kubectl exec -n tenant-a frontend-service -- \
  curl -sI backend-service.tenant-b

kubectl exec -n tenant-a frontend-service -- \
  curl -sI https://api.twitter.com
```

Then confirm:

```sh
hubble observe --namespace tenant-a
```

---

## ✅ Deliverables

* `tenant-a-default-deny.yaml` (default deny policy)
* `tenant-a-allow-internal.yaml` (internal + DNS)
* `tenant-a-extra.yaml` (allow tenant-b + external)
* Screenshots or CLI outputs of:

  * Observed flows (FORWARDED & DROPPED)
  * Hubble UI showing policies and flows

---

## 💡 Pro Tips

* Use `--verdict DROPPED` with `hubble observe` to track blocked traffic.
* Use the Hubble UI’s **flow table** to generate YAML policy rules.
* Apply policies incrementally for better visibility and debugging.

---

## 🏁 Mission Accomplished

You've taken full command of **Cilium networking** and **Hubble observability**. The traffic within your starbase is now regulated, documented, and visualized with military precision.

Ready for the next fleet-wide challenge?