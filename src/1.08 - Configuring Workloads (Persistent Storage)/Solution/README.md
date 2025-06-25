# 🛰️ Lab 1.08 - Data must survive – Persistent Volumes

### **Imperial engineering briefing – long-term data storage**

With frequent skirmishes and redeployments, TIE Fighters often lose valuable telemetry and targeting data when their pods are terminated. This has hindered fleet-wide tactical analytics.

The solution: **externalized, persistent data storage**.

In this mission, you’ll set up a secure storage system using Kubernetes **PersistentVolumes (PVs)** and **PersistentVolumeClaims (PVCs)**. These volumes live independently from your pods, ensuring that your critical mission data survives—even if the vessel does not.

> _“Secure the data. The Empire will rebuild, but only if the intelligence remains.”_ – Moff Jerjerrod

---

## 🎯 Mission objectives

- Define a **PersistentVolume (PV)** representing an external storage device.
- Create a **PersistentVolumeClaim (PVC)** that binds to the PV.
- Deploy a pod (e.g., a TIE Fighter telemetry logger) that uses the PVC to store logs to persistent storage.
- Validate the data path and confirm that pod restarts do **not** lose data.

---

## 🧭 Step-by-step: deploying external storage for Imperial telemetry

### ⚙️ Phase I: Define the PersistentVolume

1. Create a `PersistentVolume` named `imperial-datalog` with the following specs:

   - **Storage**: 1Gi
   - **Access Mode**: ReadWriteOnce
   - **Volume Type**: Use `hostPath` (for demo purposes)
   - **Path**: `/tmp/imperial-data` on the node

### ⚙️ Phase II: create a PersistentVolumeClaim

2. Define a `PersistentVolumeClaim` named `datalog-claim` that requests:

   - **Storage**: 1Gi
   - **Access Mode**: ReadWriteOnce
   - Must match the PV’s storage class or leave it unset

### ⚙️ Phase III: deploy the data logger Pod

3. Create a pod named `tie-logger` that:
   - Uses the `busybox` image
   - Mounts the `datalog-claim` at `/data`
   - Runs a long sleep or loop so you can inspect it

```
command: ["/bin/sh"]
args: ["-c", "while true; do echo $(date) >> /data/log.txt; sleep 10; done"]
```

### ⚙️ Phase IV: apply and verify

4. Apply all manifests.

5. Verify that the PVC is **bound** to the PV.

6. Inspect the logs written to the mounted volume:

```bash
kubectl exec tie-logger -- cat /data/log.txt
```

### ⚙️ Phase V: test Pod destruction and persistence

7. Delete and recreate the pod.

8. Confirm that the log file still contains earlier entries—proving that the volume preserved the data.

### ⚙️ Phase VI: dynamic provisioning with Azure Disks (CSI)

The Empire has moved its infrastructure to a high-availability hyperspace region—Azure Sector 13. You’ll now integrate Azure Disks using the Container Storage Interface (CSI) for dynamic storage provisioning. This allows you to attach reliable, persistent volumes to pods without manual provisioning.

> _“The cloud is vast. Use it to scale the fleet.”_ – SithOps Lead Architect

9. Create a `StorageClass` using Azure Disk CSI

Define a `StorageClass` named `imperial-azure-ssd` with the following specs:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: imperial-azure-ssd
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_LRS
  kind: Managed
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
```

- **Provisioner**: `disk.csi.azure.com` – Azure CSI driver
- **skuName**: Use `Premium_LRS` for SSD-backed managed disks
- **volumeBindingMode**: `WaitForFirstConsumer` ensures the disk is provisioned in the same zone as the pod
- **allowVolumeExpansion**: Enables resizing volumes later

📚 Reference: [Azure Disk CSI Driver](https://learn.microsoft.com/en-us/azure/aks/azure-disk-csi)

10. Create a `PersistentVolumeClaim` using the Azure StorageClass

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure-datalog-claim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: imperial-azure-ssd
  resources:
    requests:
      storage: 5Gi
```

This will dynamically provision a 5Gi Azure-managed disk when a pod mounts the claim.

11. Deploy the telemetry pod using the dynamic claim

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: tie-logger-azure
spec:
  containers:
    - name: logger
      image: busybox
      command: ["/bin/sh"]
      args:
        ["-c", "while true; do echo $(date) >> /data/log.txt; sleep 10; done"]
      volumeMounts:
        - name: azure-logs
          mountPath: /data
  volumes:
    - name: azure-logs
      persistentVolumeClaim:
        claimName: azure-datalog-claim
```

12. Apply your Azure-backed storage setup:

13. Validate Dynamic Provisioning in Azure

- Confirm PVC is **Bound**:

- Confirm a dynamically created Azure Disk:

- Optional: Check in the Azure Portal to view the provisioned disk under **Disks**.

---

## 📚 Resources

- [Volumes](https://kubernetes.io/docs/concepts/storage/volumes/)
- [Persistent Volumes](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)
- [Storage Classes](https://kubernetes.io/docs/concepts/storage/storage-classes/)
