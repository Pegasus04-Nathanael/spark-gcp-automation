variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "europe-west1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "europe-west1-b"
}

variable "machine_type_master" {
  description = "Type de machine pour le master"
  type        = string
  default     = "e2-medium"
}

variable "machine_type_worker" {
  description = "Type de machine pour les workers"
  type        = string
  default     = "e2-medium"
}

variable "worker_count" {
  description = "Nombre de workers Spark"
  type        = number
  default     = 2
}

variable "network_cidr" {
  description = "CIDR du réseau VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR du subnet"
  type        = string
  default     = "10.0.1.0/24"
}