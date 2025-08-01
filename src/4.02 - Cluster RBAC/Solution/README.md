# 🚀 4.02 Command Authorization – mastering Service Accounts and RBAC

### ⚔️ *Imperial Command Permissions*

The Empire’s fleet expansion demands **strict control** over who can issue commands to each starship and battlestation. Not every officer is permitted to launch TIE fighters or scan hyperspace routes—only those with proper authorization.

As the newly appointed **Security Officer of the Imperial Fleet**, it is your duty to implement role-based access control (RBAC) using **ServiceAccounts**, **Roles**, and **Bindings**. This ensures that each squadron and command unit operates under the **principle of least privilege**.

> *"Power flows through control. Without it, even the strongest starship is just a floating hunk of metal."*
> — **Grand Admiral Thrawn**

---

## 🎯 Mission Objective

Your objectives for this operation are to:

1. Create a **Namespace** for your squadron's operations.
2. Define a **ServiceAccount** for the squadron commander.
3. Assign namespace-specific **read permissions on pods** using a Role and RoleBinding.
4. Assign cluster-wide **read access to nodes** using a ClusterRole and ClusterRoleBinding.
5. Simulate access checks using impersonation to validate permissions.

---

## 🧭 Step-by-step: Assigning Command Permissions

---

### ⚙️ Phase I: Establish the Operational Zone

Create the squadron’s command namespace and assign a secure ServiceAccount identity.

* **Namespace**: `imperial-squadron`
* **ServiceAccount**:

  * **Name**: `squadron-commander`
  * **Namespace**: `imperial-squadron`

---

### ⚙️ Phase II: Grant Local Authority

Define a `Role` with limited access to local pod data, and bind it to the squadron commander.

* **Role**

  * **Type**: `Role`
  * **Name**: `role-pod-reader`
  * **Namespace**: `imperial-squadron`
  * **Permissions**:

    * API Groups: `""`
    * Resources: `pods`
    * Verbs: `get`, `list`, `watch`

* **RoleBinding**

  * **Type**: `RoleBinding`
  * **Name**: `rb-squadron-commander`
  * **Namespace**: `imperial-squadron`
  * **Subject**:

    * Kind: `ServiceAccount`
    * Name: `squadron-commander`
  * **RoleRef**:

    * Refers to `role-pod-reader`

---

### ⚙️ Phase III: Assign Fleet-Wide Read Access

Create a `ClusterRole` to allow read-only access to infrastructure details—specifically, the cluster’s nodes.

* **ClusterRole**

  * **Type**: `ClusterRole`
  * **Name**: `clusterrole-node-reader`
  * **Permissions**:

    * API Groups: `""`
    * Resources: `nodes`
    * Verbs: `list`

* **ClusterRoleBinding**

  * **Type**: `ClusterRoleBinding`
  * **Name**: `crb-squadron-commander`
  * **Subject**:

    * Kind: `ServiceAccount`
    * Name: `squadron-commander`
    * Namespace: `imperial-squadron`
  * **RoleRef**:

    * Refers to `clusterrole-node-reader`

---

### ⚙️ Phase IV: Simulate Command Issuance

Validate your permissions by impersonating the squadron commander’s ServiceAccount using the CLI:

> 🔍 Run the following commands:

```bash
kubectl auth can-i list pods --namespace=imperial-squadron --as=system:serviceaccount:imperial-squadron:squadron-commander
kubectl auth can-i list pods --namespace=default --as=system:serviceaccount:imperial-squadron:squadron-commander
kubectl auth can-i list nodes --as=system:serviceaccount:imperial-squadron:squadron-commander
```

> Expected Results:
>
> ✅ List pods in `imperial-squadron`
> ❌ List pods in `default`
> ✅ List nodes cluster-wide

---

## 📦 Deliverables

By the end of this mission, you should have the following resources defined:

| Resource Type      | Name                      | Namespace           |
| ------------------ | ------------------------- | ------------------- |
| Namespace          | `imperial-squadron`       | -                   |
| ServiceAccount     | `squadron-commander`      | `imperial-squadron` |
| Role               | `role-pod-reader`         | `imperial-squadron` |
| RoleBinding        | `rb-squadron-commander`   | `imperial-squadron` |
| ClusterRole        | `clusterrole-node-reader` | -                   |
| ClusterRoleBinding | `crb-squadron-commander`  | -                   |