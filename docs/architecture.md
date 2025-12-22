Architecture Spark sur GCP
==========================

VPC: spark-vpc (10.0.0.0/16)
│
└── Subnet: spark-subnet (10.0.1.0/24)
    │
    ├── spark-master (10.0.1.10)
    │   └── Services: Spark Master, Web UI (8080)
    │
    ├── spark-worker-1 (10.0.1.11)
    │   └── Services: Spark Worker
    │
    ├── spark-worker-2 (10.0.1.12)
    │   └── Services: Spark Worker
    │
    └── spark-edge (10.0.1.20)
        └── Services: Client, job submission

Firewall Rules:
- SSH (22) : depuis Internet
- Spark UI (8080, 7077, 4040) : depuis Internet
- Interne (all) : au sein du subnet