# 🔐 **4.04 – Vault Convergence: Synchronizing Secrets Across the Empire**

### ⚔️ **Mission Codename: "Operation Starshield"**

The **Empire’s Galactic Defense Grid** is powered by advanced APIs and encrypted relays. These systems are safeguarded by TLS certificates issued and managed by the Imperial Vault Core (Azure Key Vault). However, a failure in certificate propagation between ground systems and relay nodes (via the **ESO sync agent**) has left some installations unencrypted — an opening the Rebellion might exploit.

Your mission: configure a **Network Gateway Frontend (NGF)** to serve an HTTPS certificate retrieved from **Azure Key Vault**, and ensure it stays in sync via the **External Secrets Operator (ESO)**.

> *“A system without encryption is a system already lost.”* — Moff Gideon

---

## 🎯 **Mission Objectives**

You will:

1. Create a **self-signed certificate** using Azure CLI.
2. Upload the certificate to **Azure Key Vault**.
3. Configure **ESO (External Secrets Operator)** to sync the certificate as a Kubernetes secret.
4. Expose a **sample HTTPS app** using that synced certificate via **NGF (Ingress/Nginx)**.
5. Validate that HTTPS is correctly served using the synced certificate.

---

## 🧭 **Step-by-Step: Vault-to-NGF Certificate Propagation**

### ⚙️ Phase I: Generate & Upload a Self-Signed Certificate

Use Azure CLI to generate a PFX certificate and upload it to Key Vault:

```bash
# Variables
export CERT_NAME="starshield-cert"
export KEY_VAULT_NAME="<your-keyvault-name>"
export CERT_POLICY='@cert-policy.json'

# Optional: Create certificate policy file (cert-policy.json)
cat <<EOF > cert-policy.json
{
  "issuerParameters": {
    "name": "Self"
  },
  "x509CertificateProperties": {
    "subject": "CN=starshield.imperial",
    "validityInMonths": 12
  },
  "keyProperties": {
    "exportable": true,
    "keyType": "RSA",
    "keySize": 2048,
    "reuseKey": false
  },
  "secretProperties": {
    "contentType": "application/x-pkcs12"
  }
}
EOF

# Create self-signed certificate in Key Vault
az keyvault certificate create \
  --vault-name "$KEY_VAULT_NAME" \
  --name "$CERT_NAME" \
  --policy "$CERT_POLICY"
```

---

### ⚙️ Phase II: Sync Certificate Using ESO

Assuming ESO is installed and linked to Key Vault via a ClusterSecretStore:

1. Create an **ExternalSecret** in your cluster:

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: starshield-cert
  namespace: secure-zone
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: imperial-vault
    kind: ClusterSecretStore
  target:
    name: starshield-tls
    creationPolicy: Owner
    template:
      type: kubernetes.io/tls
      engineVersion: v2
  data:
    - secretKey: tls.crt
      remoteRef:
        key: starshield-cert
        property: cert
    - secretKey: tls.key
      remoteRef:
        key: starshield-cert
        property: key
```

> 📦 Note: You may need to convert the PFX in Azure or use `secretType: Opaque` if `tls.crt`/`tls.key` are not directly available.

---

### ⚙️ Phase III: Deploy HTTPS Ingress with Synced Certificate

Configure an NGINX Ingress to use the synced certificate:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: starshield-ingress
  namespace: secure-zone
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  tls:
    - hosts:
        - starshield.imperial
      secretName: starshield-tls
  rules:
    - host: starshield.imperial
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: starshield-api
                port:
                  number: 80
```

---

### ⚙️ Phase IV: Confirm the Sync & Secure Exposure

Run these checks:

```bash
# Ensure secret exists
kubectl get secret starshield-tls -n secure-zone -o yaml

# Check for TLS in the Ingress
kubectl describe ingress starshield-ingress -n secure-zone

# Access via HTTPS (requires DNS or /etc/hosts entry)
curl https://starshield.imperial --insecure
```

---

## 📦 **Deliverables**

| Resource Type  | Name                 | Scope/Namespace |
| -------------- | -------------------- | --------------- |
| Key Vault Cert | `starshield-cert`    | Azure Key Vault |
| ExternalSecret | `starshield-cert`    | `secure-zone`   |
| TLS Secret     | `starshield-tls`     | `secure-zone`   |
| Ingress        | `starshield-ingress` | `secure-zone`   |

---

## 🧠 **Post-Mission Debrief**

* Why is syncing certificates from AKV via ESO more secure than manual secret creation?
* What happens when the certificate is renewed in Azure?
* How can we automate validation and alerts for failed syncs?