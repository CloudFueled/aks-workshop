# ✨ 4.06 Security Context — *The Jedi Code of Pod Security*

## 🌌 Episode IV: A New Security Hope

In the Kubernetes galaxy, not all pods are created equal. Some wield the power of the root user, others are vulnerable to the dark side of privilege escalation. As a **Jedi Security Master**, your mission is to enforce the Jedi Code — ensuring every pod abides by strict security context rules.

> *"The Force will be with you, always — but only if you set your security context."*  
> — Master Yoda

---

## 🎯 Mission Objective

You will:

1. Understand the **security context** for pods and containers.
2. Apply best practices to restrict privileges and capabilities.
3. Prevent the rise of Sith-level exploits in your cluster.

---

## 🧭 Step-by-Step: The Path to Pod Security

### ⚙️ Phase I: Know Your Enemy

The default pod runs with more power than it needs. This can lead to:

- **Privilege escalation** (Sith infiltration)
- **Unrestricted host access** (Death Star breach)
- **Dangerous capabilities** (Force misuse)

Without a proper security context, a compromised container could exploit kernel vulnerabilities to escape its sandbox and access the host system. This could allow attackers to:

- Install malicious software on the node
- Access sensitive files outside the container
- Disrupt other workloads running on the same host

Setting a strict security context helps contain threats and limits the blast radius of any compromise.

---

### ⚙️ Phase II: The Dark Side — Example of a Root Pod

A pod running as root (the Sith way):

**Name**: `sith-pod`
**Namespace**: `imperial-squadron` 
**Image**: `busybox`
**Command**: `["sleep", "3600"]`

This pod has full root privileges inside its container, making it vulnerable to Sith-level exploits.  
You can verify this by running the following commands:

```sh
kubectl exec sith-pod -- whoami
kubectl exec sith-pod -- touch /etc/testfile
```

---

### ⚙️ Phase III: Set the Jedi Security Context

Apply a security context to your Jedi pod manifest:

**Name**: `jedi-pod`
**Namespace**: `imperial-squadron` 
**Image**: `busybox`
**Command**: `["sleep", "3600"]`

```yaml
securityContext:
    runAsUser: 1000 # Run as non-root user
    allowPrivilegeEscalation: false # Prevents processes from gaining more privileges
    capabilities:
        drop: ["ALL"]
    readOnlyRootFilesystem: true # Make the file system read-only so you can not tamper with it
```

**Capabilities** are like special powers a container can have in Linux. By default, containers get a bunch of these powers, but most apps don't need them.  
For example, the `NET_ADMIN` capability lets a container change network settings (like creating network interfaces or changing firewall rules). If you drop `NET_ADMIN`, the container can't mess with the network — making it safer.

```yaml
securityContext:
    capabilities:
        drop: ["ALL"]      # Remove all special powers
        add: ["NET_ADMIN"] # (Optional) Give back only the network admin power if needed
```

**Why drop capabilities?**  
Dropping unnecessary capabilities means even if someone breaks into your container, they can't use those powers to do harm.

Now Verify your defenses by executing the following commands onto the pod.

```sh
kubectl exec jedi-pod -- whoami
kubectl exec jedi-pod -- touch /tmp/testfile
```

---

### ⚙️ Phase IV: Enforcing Pod Security Standards

**What Are Pod Security Standards?**

Kubernetes defines three Pod Security Standards:

- **Privileged**: All features enabled (Sith-level danger)
- **Baseline**: Minimally restricted (Padawan level)
- **Restricted**: Strongest protections (Jedi Master level)

You can enforce these standards using namespace labels and the built-in Pod Security Admission controller.

**Step 1: Create A Dedicated Namespace For Restricted Security** 

First we create a new namespace where we want to **enforce pod security standards**.  
**Namespace:** `jedi-temple`
**Label:** `pod-security.kubernetes.io/enforce=restricted`
**Label:** `pod-security.kubernetes.io/enforce-version=latest`


**Step 2: Try Deploying a Sith Pod**
Try to deploy the `sith-pod` we created earlier to the `jedi-temple` namespace.

**Expected:**  
You should see an error:  
`pods "sith-pod" is forbidden: violates PodSecurity "restricted:latest"`

**Step 3: Deploy a Jedi Pod**

Try to deploy the following `jedi-pod` to the `jedi-temple` namespace.  
It ensures we have a met the strict security measures we have in place.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: jedi-pod
  namespace: jedi-temple
spec:
  containers:
    - name: jedi-container
      image: busybox
      command: ["sleep", "3600"]
      securityContext:
        runAsNonRoot: true
        runAsUser: 1000
        allowPrivilegeEscalation: false
        capabilities:
          drop: ["ALL"]
        readOnlyRootFilesystem: true
        seccompProfile:
          type: RuntimeDefault
```

**Expected:**  
Pod is created successfully.

---

## ✅ Deliverables

| Resource Type      | Name                      | Namespace           |
| ------------------ | ------------------------- | ------------------- |
| Namespace          | `imperial-squadron`       | -                   |
| Namespace          | `jedi-temple`             | -                   |
| Pod                | `sith-pod`                | `imperial-squadron` |
| Pod                | `jedi-pod`                | `imperial-squadron` |
| Pod                | `sith-pod-jedi-temple`    | `jedi-temple`       | 
| Pod                | `jedi-pod-jedi-temple`    | `jedi-temple`       |

---

## 💡 Jedi Wisdom

- Always drop unnecessary capabilities.
- Never run as root unless absolutely required.
- Use read-only filesystems to prevent tampering.
- The best defense is a well-defined security context.

---

## 🏁 The Force Is Strong With Your Pods

With the Jedi Code enforced, your pods are protected from the dark side. The Kubernetes galaxy is safer — until the next threat arises.

May the (security) Force be with