# 🛡️ **4.04 – Dockyard Protocols: Securing Container Blueprints**

### 🧊 **Imperial Security Breach Detected**

A recent audit of one of the Empire’s container blueprints (Dockerfiles) uncovered several critical vulnerabilities. Intelligence suggests these flaws may allow rebel saboteurs to exploit weak points in the fleet’s supply chain — particularly in unsecured or bloated images used across the galaxy.

You've been assigned as the **Imperial Container Security Engineer**. Your task: inspect the flawed Dockerfile and apply best practices to lock it down.

> *"A single insecure container image can dismantle a thousand battlestars."* — Grand Moff Tarkin

---

## 🎯 **Mission Objectives**

You will:

1. Review a **Dockerfile** containing three security flaws.
2. Identify each flaw and understand its potential risk.
3. Rewrite the Dockerfile using security best practices.
4. Build the new image and verify that the app still runs.
5. Compare the image size before and after — smaller is better.

---

## 🧾 **Situation Report**

The following Dockerfile has been intercepted from a compromised dev cluster:

```Dockerfile
# Flawed Dockerfile

FROM node:16

WORKDIR /app

COPY . .

RUN npm install

CMD ["node", "server.js"]
```

---

## 🔍 **Known Vulnerabilities to Look For**

You're expected to identify **three** of the following types of flaws:

* ❌ Using a full OS base image (instead of minimal base)
* ❌ Not setting a non-root user
* ❌ Unused build dependencies left in the final image
* ❌ No version pinning for dependencies
* ❌ Sensitive files copied unintentionally
* ❌ Exposed ports not declared
* ❌ No health check

---

## 🛠️ **Step-by-Step Mission Plan**

### ⚙️ Phase I: Inspect the Dockerfile

Look through the Dockerfile and identify **at least three** security flaws or bad practices. Think in terms of:

* Attack surface
* Least privilege
* Image size
* Supply chain integrity

Log them in comments for documentation.

---

### ⚙️ Phase II: Fix the Dockerfile

Create a new Dockerfile that includes at least:

* ✅ A minimal base image (e.g., `node:16-slim`)
* ✅ A dedicated non-root user
* ✅ A multi-stage build if needed (optional but preferred)
* ✅ Clean layering and minimized COPY context

Your final Dockerfile **must** still run the application as intended.

---

### ⚙️ Phase III: Build and Compare

Build both images and compare:

```bash
docker build -t insecure-app:latest -f Dockerfile.insecure .
docker build -t secure-app:latest -f Dockerfile.secure .
docker images
```

Compare:

* 🧊 Image size difference
* 🔐 Security posture improvements

---

### ⚙️ Phase IV: Run the Container

Ensure your secure image functions properly:

```bash
docker run -it --rm -p 3000:3000 secure-app:latest
```

Test endpoints or the app locally.

---

## 📦 **Deliverables**

| Item                  | Description                                   |
| --------------------- | --------------------------------------------- |
| `Dockerfile.insecure` | Original flawed Dockerfile                    |
| `Dockerfile.secure`   | Your corrected and hardened Dockerfile        |
| Image size comparison | CLI output showing size before and after      |
| Commented findings    | 3 documented flaws in the original Dockerfile |

---

## 💡 Pro Tips from Lord Vader

* Use multi-stage builds to separate dependencies from runtime.
* Avoid full OS images unless absolutely necessary.
* Drop root privileges unless explicitly required.
* The smaller the image, the less the attack surface.