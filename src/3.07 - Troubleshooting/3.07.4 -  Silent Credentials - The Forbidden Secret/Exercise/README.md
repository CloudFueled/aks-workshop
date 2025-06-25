# 🧰 Lab 3.07.4 - Silent Credentials: The Forbidden Secret

## 🎯 Scenario

You’re deploying a secure application that needs access to sensitive data through Kubernetes Secrets. You've configured the necessary RBAC and mounted the secret both as a volume and through environment variables. The application pod starts—but logs indicate that it cannot access the secret data.

---

## 🧭 Step-by-step

1. Create the `secure-app` namespace
2. Apply all manifests in the scenario directory
3. Check pod status and logs
4. Investigate why the application can't access secrets

---

## 🏁 Completion checklist

* [ ] Verified the ServiceAccount and its role bindings
* [ ] Confirmed the Role has access to the required resources
* [ ] Checked the Secret and the way it’s referenced in the Deployment
* [ ] Ensured the pod successfully accessed the secret (via logs)