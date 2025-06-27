# 🛸 Imperial Kubernetes Initiative

> _“Peace. Security. Order. Through Kubernetes.”_ — Emperor Palpatine, addressing the Galactic DevOps Senate

---

**IMPERIAL RECORD 1138-A**  
**TOP SECRET | EYES ONLY | DO NOT LEAK TO REBELS**

---

## 🪐 Welcome, Cadet

By decree of the Emperor, you have been conscripted into the **Imperial Kubernetes Corps**, a prestigious DevOps initiative tasked with deploying, managing, and dominating the galaxy’s infrastructure — one pod at a time.

The Rebellion believes in chaos: random containers, exposed services, and unversioned configs.  
We believe in **order**, **replicaSets**, and **clearly defined liveness probes**.

Over the next three galactic cycles (days), you will undergo basic Kubernetes combat training:

---

## 🧠 Imperial Expectations

Failure to comply with best practices will result in immediate reassignment to Java monolith maintenance duty.

Those who excel may be fast-tracked to the **Dark Helm Program** — specializing in Helm chart development and planetary-scale rollouts.

---

## 🖖 Glory to the Cluster

Your mission begins now, Cadet.  
Don’t disappoint the Emperor.  
He’s... monitoring the logs.

![DevOps](https://darksiderconfessions.blog/wp-content/uploads/2018/05/sith-red-gif2.gif)

## 🛠️ Setup

- Azure subscription with no network restrictions
- WSL2 with the following installed:

  - Fully up-to-date

    ```bash
    sudo apt update
    sudo apt upgrade
    ```

  - Azure CLI

    ```bash
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    ```

  - kubectl

    ```bash
    az aks install-cli
    ```

    In case of issues, you can also install kubectl manually:

    ```bash
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    ```

  - helm

    ```bash
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    ```

  - git

    Make sure you also have a git repo for the GitOps labs

    ```bash
    sudo apt-get install git
    ```

  - brew

    ```bash
    sudo apt-get install build-essential procps curl file git
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
    ```

## 🐛 Known issues

- If you encounter connection issues with `kubectl` commands, ensure your WSL2 is properly configured to access the Azure AKS cluster (correct kube context).

```bash
echo ‘export KUBECONFIG=”/mnt/c/Users/{{username}}/.kube/config”’ >> ~/.bashrc
```
