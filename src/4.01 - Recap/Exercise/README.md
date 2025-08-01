# 🌌 Lab 4.01 – Bounty Base Construction 🧱

### **Mission Briefing – Recap Protocol Alpha**

The Guild’s bounty operations require a secure, isolated base from which to manage contracts, targets, and intel. Over the past days, you've acquired the skills necessary to build such an environment using Kubernetes and Azure Bicep modules.

This mission will validate your command over both **Kubernetes infrastructure** and **Azure IaC best practices**.

> *"A bounty hunter is only as good as their deployment infrastructure."* – **Fennec Shand**

---

## 🎯 Mission Objectives

You will:

* Define a reusable database module using Bicep
* Integrate and parameterize the database into your main Bicep deployment
* Set up Kubernetes configuration and application resources
* Enforce application availability via Pod Disruption Budgets

---

## 🧭 Step-by-Step

---

### 🧱 Section 1: Azure Infrastructure – Define the PostgreSQL Module

#### 1. Create a `database.bicep` module with the following properties:

* **Target scope**: `resourceGroup`

#### Parameters:

| Name                         | Type            | Notes                                                            |
| ---------------------------- | --------------- | ---------------------------------------------------------------- |
| `location`                   | `string`        | The Azure location to deploy into                                |
| `dbName`                     | `string`        | Name of the Postgres flexible server                             |
| `administratorLogin`         | `string`        | Administrator username                                           |
| `administratorLoginPassword` | `secure string` | Secure password (marked with `@secure()`)                        |
| `skuTier`                    | `string`        | Must be one of: `Burstable`, `GeneralPurpose`, `MemoryOptimized` |
| `skuName`                    | `string`        | Must be `Standard_D4ds_v4`                                       |

#### Resource:

* A **PostgreSQL Flexible Server** (API version: `2025-01-01-preview`)
* Enable both **Active Directory** and **Password Auth**
* Set `publicNetworkAccess` to `Enabled`
* Use the supplied SKU parameters

---

#### 2. Modify your `main.bicep` file to include the database module:

* Use the module keyword to reference the `database.bicep` file
* Provide values for all required parameters
* Use logical, unique names (e.g., `'bounty-db'`) where applicable

---

#### 3. Update your `midSector.bicepparam` file:

* Add values for:

  * `dbName`
  * `administratorLogin`
  * `administratorLoginPassword`
  * `skuTier`
  * `skuName`

💡 *Note*: Store sensitive values securely (e.g., use Key Vault references in a production environment).

---

### ✅ Section 2: Create the Namespace

* Create a Kubernetes **namespace** named: `bounty`

---

### 🔐 Section 3: Configuration Resources

#### Secret – Database Connection

* Type: `Secret`
* Name: `secret-bounty-db-connectionstring`
* Key: `connectionstring`
* Value: `Server=<<Database Name>>;Database=bounty;Port=5432;User Id=<<Administrator Name>>;Password=<<Administrator Password>>;Ssl Mode=Require;`

#### ConfigMaps

1. **Persistence Manager ConfigMap**

   * Name: `cm-bounty-persistence`
   * Keys:

     * `Migration__ApplyMigrations`: `"true"`
     * `Migration__RecreateDatabase`: `"false"`
     * `Migration__SeedDatabase`: `"true"`

2. **Client ConfigMap**

   * Name: `cm-bounty-client`
   * Key: `Apis__BountyApiUrl`
   * Value: Should point to the API's internal service name and port

---

### 💽 Section 4: Persistent Storage Setup

#### StorageClass

* Name: `bounty-azure-ssd`
* Provisioner: `kubernetes.io/azure-disk`
* Parameters:

  * `skuName`: `Premium_LRS`
  * `kind`: `Managed`
* Enable `allowVolumeExpansion`
* Use `volumeBindingMode`: `Immediate`

#### PersistentVolumeClaim

* Name: `images-claim`
* Namespace: `bounty`
* Storage Class: `bounty-azure-ssd`
* Size: `1Gi`
* Access Mode: `ReadWriteOnce`

---

### 🚀 Section 5: Deployments & Services

Deploy two applications in the `bounty` namespace with the following specs:

#### Deployment – `bounty-api`

* Init container: `bountypersistence` image

  * Pulls from secret and configmap for DB setup
* Main container: `bountyapi` image

  * Same env sources
  * CPU request: `0.5`, limit: `0.75`
  * Memory request: `256Mi`, limit: `512Mi`

#### Service – `svc-bounty-api`

* Port: `5000`
* TargetPort: `8080`
* Selector: `app: bounty-api`

---

#### Deployment – `bounty-client`

* Container: `bountyclient` image

  * Uses `cm-bounty-client` for environment
  * Adds liveness probe on `/` (port `8080`)
  * Mounts volume `images-claim` at `/app/wwwroot/uploads`
  * CPU request: `0.5`, limit: `0.75`
  * Memory request: `256Mi`, limit: `512Mi`

#### Service – `svc-bounty-client`

* Port: `5500`
* TargetPort: `8080`
* Selector: `app: bounty-client`

---

### 🛡️ Section 6: Pod Disruption Budgets

Ensure high availability during voluntary disruptions (e.g., node upgrades):

#### PDB – `bounty-api`

* `minAvailable`: `1`
* Match label: `app: bounty-api`

#### PDB – `bounty-client`

* `minAvailable`: `1`
* Match label: `app: bounty-client`

---

## 📦 Deliverables

You should produce the following artifacts by the end of this lab:

| Resource Type         | Name                                                                               | Namespace |
| --------------------- | ---------------------------------------------------------------------------------- | --------- |
| Bicep Module File     | `database.bicep`                                                                   | -         |
| Module Call in Bicep  | `bounty-db`                                                                        | -         |
| Parameter File Entry  | `dbName`, `skuTier`, `skuName`, `administratorLogin`, `administratorLoginPassword` | -         |
| Namespace             | `bounty`                                                                           | -         |
| Secret                | `secret-bounty-db-connectionstring`                                                | `bounty`  |
| ConfigMap             | `cm-bounty-persistence`                                                            | `bounty`  |
| ConfigMap             | `cm-bounty-client`                                                                 | `bounty`  |
| StorageClass          | `bounty-azure-ssd`                                                                 | -         |
| PersistentVolumeClaim | `images-claim`                                                                     | `bounty`  |
| Deployment            | `bounty-api`                                                                       | `bounty`  |
| Deployment            | `bounty-client`                                                                    | `bounty`  |
| Service               | `svc-bounty-api`                                                                   | `bounty`  |
| Service               | `svc-bounty-client`                                                                | `bounty`  |
| PodDisruptionBudget   | `pdb-bounty-api`                                                                   | `bounty`  |
| PodDisruptionBudget   | `pdb-bounty-client`                                                                | `bounty`  |