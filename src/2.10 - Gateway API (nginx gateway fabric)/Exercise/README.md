# 🛰️ Lab 2.10 - Establishing the Hyperspace Gateway Network – Gateway API

### **Imperial communications initiative – Outer Rim network relay**

The Empire is expanding its control across the Outer Rim. To maintain order and ensure high-speed, secure communication between strategic sectors, a **galactic ingress gateway** must be established. The new **NGINX Gateway Fabric** will serve as the central **hyperspace relay system**—directing fleet traffic, mission briefings, and resource logistics to the correct planetary systems.

As a systems officer, you are tasked with deploying this hyperspace network manually and declaratively—without Helm or GitOps tooling.

> _“The hyperspace relays are our lifeline — secure them, and the outer systems will follow.”_ – Moff Jerjerrod

---

## 🎯 Mission objectives

You will:

1. Deploy the **NGINX Gateway Fabric** controller using raw Kubernetes manifests.
2. Install the **Gateway API CRDs**.
3. Define a `Gateway` resource to accept traffic.
4. Define an `HTTPRoute` to forward traffic to the `tie-squadron` service.
5. Validate that external access to the `tie-squadron` is operational.

---

## 🧭 Step-by-step: Establishing the Gateway

1.  Deploy the NGINX Gateway Fabric Controller

The manifests are found at: 
* https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.0.1/deploy/crds.yaml
* https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.0.1/deploy/default/deploy.yaml


2.  Create the Gateway Resource

Create a Gateway that listens on HTTP with the following specifications:

* name: hyperspace-gateway
* namespace: nginx-gateway
* hostname: "*.outerrim.com"
* port: 80
* protocol: HTTP
* allow routes from all namespaces

3.  Create the HTTPRoute to TIE Squadron with `tie-fighter.outerrim.com` as hostname in the same namespace as the `tie-squadron deployment`

4. Port-forward to the `hyperspace-gateway-nginx` service in the `nginx-gateway` namespace to port 8080

5.  Validate the Gateway Setup

```bash
curl http://tie-fighter.outerrim.com:8080 --resolve tie-fighter.outerrim.com:8080:127.0.0.1
```

---

## 📚 Resources

- [Install NGINX Gateway Fabric with Manifests](https://docs.nginx.com/nginx-gateway-fabric/install/manifests/)
- [Get started](https://docs.nginx.com/nginx-gateway-fabric/get-started/#create-gateway-and-httproute-resources)
- [Simple Gateway](https://gateway-api.sigs.k8s.io/guides/http-routing/)
