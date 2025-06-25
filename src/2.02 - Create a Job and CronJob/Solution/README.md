# 🛰️ Lab 2.02 - Surveillance protocols – Jobs & CronJobs

As Rebel activity increases across the sector, Imperial Command has issued a directive to automate our patrol and diagnostic routines. Manual checks are no longer sufficient—our systems must continuously report on perimeter integrity and subsystem status without requiring officer intervention.

In this exercise, you will take your first steps into automating Empire operations by defining Jobs for one-time scans and CronJobs for recurring patrols. The future of the Death Star’s security depends on you.

> _“We need regular reports from the outer sectors. Schedule the droids.”_ – Grand Moff Tarkin

---

## 🎯 Mission objectives

- Create a one-time **Job** to simulate a diagnostic scan across Imperial systems.
- Deploy a recurring **CronJob** to report sector status every minute.
- Verify execution and logs to confirm successful automation.

---

## 🧭 Step-by-step: deploying surveillance Jobs for the Empire

1.  Create a one-time diagnostic job

Use the declarative method to define a **Job** named `system-scan` that runs the `busybox` image and echoes:

```
📡 Scanning for rebel frequencies...
```

2.  Apply the job and verify execution. Where can you find the output of the job?

3.  Schedule recurring perimeter scans

Create a **CronJob** named `perimeter-check` that runs every minute using the `busybox` image to echo:

```
🛰️ Scheduled scan initiated...
```

Use the `*/5 * * * *` schedule format.

4.  Apply and monitor the CronJob

5.  Check logs from one of the CronJob runs

---

## 📚 Resources

- [Jobs](https://kubernetes.io/docs/concepts/workloads/controllers/job/)
- [CronJobs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/)
