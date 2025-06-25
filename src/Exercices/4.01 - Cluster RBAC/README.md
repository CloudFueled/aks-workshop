# 🚀 4.01 Command Authorization – Mastering Service Accounts and RBAC

### Imperial Command Permissions

The Empire’s fleet expansion demands strict control over who can issue commands to each starship and battlestation. Not every officer can fire the turbolasers or launch TIE fighters — only those with proper authorization.

As the newly appointed Security Officer of the Imperial Fleet, you must configure **service accounts**, **roles**, and **role bindings** to enforce the principle of least privilege. This will ensure each squadron and command unit operates under strict rules, preventing rogue officers from wreaking havoc.

> *"Power flows through control. Without it, even the strongest starship is just a floating hunk of metal."* — Admiral Thrawn

---

## 🎯 Mission Objective

You will:

1. Create a **Namespace** called `imperial-squadron`.
2. Define a **ServiceAccount** for the squadron commander.
3. Create a **Role** that allows reading pods within the `imperial-squadron` namespace.
4. Bind the Role to the ServiceAccount with a **RoleBinding**.
5. Create a **ClusterRole** granting permission to list all nodes cluster-wide.
6. Bind the ClusterRole to the ServiceAccount using a **ClusterRoleBinding**.
7. Test the permissions by impersonating the ServiceAccount.

---

## 🧭 Step-by-step: Assigning Command Permissions

### ⚙️ Phase I: Create the Namespace and ServiceAccount

* Define and apply YAML for `imperial-squadron` namespace.
* Define and apply YAML for a ServiceAccount named `squadron-commander` inside this namespace.

### ⚙️ Phase II: Create Role and RoleBinding

* Write a Role granting `get`, `list`, and `watch` permissions on `pods` in `imperial-squadron`.
* Bind this Role to `squadron-commander` via RoleBinding.

### ⚙️ Phase III: Create ClusterRole and ClusterRoleBinding

* Define a ClusterRole that allows `list` on `nodes`.
* Bind the ClusterRole to the same ServiceAccount cluster-wide with a ClusterRoleBinding.

### ⚙️ Phase IV: Verify Access

* Use `kubectl auth can-i` with `--as=system:serviceaccount:imperial-squadron:squadron-commander` to confirm permissions.
* Try listing pods in `imperial-squadron` (should succeed).
* Try listing pods in another namespace (should fail).
* Try listing nodes (should succeed).
