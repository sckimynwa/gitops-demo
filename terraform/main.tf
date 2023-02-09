terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.34.0"
    }
  }
}

# module.gke.google_container_cluster.primary:
resource "google_container_cluster" "cluster-yeoul" {
    datapath_provider           = "LEGACY_DATAPATH"
    default_max_pods_per_node   = 110
    enable_intranode_visibility = false
    enable_kubernetes_alpha     = false
    enable_legacy_abac          = false
    enable_shielded_nodes       = true
    enable_tpu                  = false
    initial_node_count          = 0
    location                    = "asia-northeast3-c"
    name                        = "cluster-yeoul"
    network                     = "projects/playground-yeoul-kim-b12d/global/networks/default"
    networking_mode             = "VPC_NATIVE"
    node_version                = "1.24.8-gke.2000"
    min_master_version		    = "1.24.8-gke.2000"
    project                     = "playground-yeoul-kim-b12d"
    resource_labels             = {}
    subnetwork                  = "projects/playground-yeoul-kim-b12d/regions/asia-northeast3/subnetworks/default"

    addons_config {

        dns_cache_config {
            enabled = false
        }

        gce_persistent_disk_csi_driver_config {
            enabled = true
        }

        horizontal_pod_autoscaling {
            disabled = false
        }

        http_load_balancing {
            disabled = false
        }

        network_policy_config {
            disabled = true
        }
    }

    binary_authorization {
	evaluation_mode = "DISABLED"
    }

    cluster_autoscaling {
        enabled = false
    }

    database_encryption {
        state = "DECRYPTED"
    }

    default_snat_status {
        disabled = false
    }

    ip_allocation_policy {
        cluster_ipv4_cidr_block       = "10.84.0.0/14"
        services_ipv4_cidr_block      = "10.88.0.0/20"
    }

    logging_config {
        enable_components = [
            "SYSTEM_COMPONENTS",
            "WORKLOADS",
        ]
    }

    master_auth {
        client_certificate_config {
            issue_client_certificate = false
        }
    }

    monitoring_config {
        enable_components = [
            "SYSTEM_COMPONENTS",
        ]
    }

    network_policy {
        enabled  = false
        provider = "PROVIDER_UNSPECIFIED"
    }

    node_pool {
        max_pods_per_node           = 110
        name                        = "default-pool"
        node_count                  = 3
        version                     = "1.24.8-gke.2000"

        autoscaling {
            max_node_count = 1
            min_node_count = 0
        }

        management {
            auto_repair  = true
            auto_upgrade = true
        }

        node_config {
            disk_size_gb      = 100
            disk_type         = "pd-standard"
            guest_accelerator = []
            image_type        = "COS_CONTAINERD"
            labels            = {}
            local_ssd_count   = 0
            machine_type      = "e2-standard-2"
            metadata          = {
                "disable-legacy-endpoints" = "true"
            }
            oauth_scopes      = [
# google_client_config and kubernetes provider must be explicitly specified like the following.
                "https://www.googleapis.com/auth/devstorage.read_only",
                "https://www.googleapis.com/auth/logging.write",
                "https://www.googleapis.com/auth/monitoring",
                "https://www.googleapis.com/auth/service.management.readonly",
                "https://www.googleapis.com/auth/servicecontrol",
                "https://www.googleapis.com/auth/trace.append",
            ]
            preemptible       = false
            service_account   = "default"
            spot              = false
# google_client_config and kubernetes provider must be explicitly specified like the following.
            tags              = []
            taint             = []

            shielded_instance_config {
                enable_integrity_monitoring = true
                enable_secure_boot          = false
            }
        }

        upgrade_settings {
            max_surge       = 1
            max_unavailable = 0
        }
    }

    notification_config {
        pubsub {
# google_client_config and kubernetes provider must be explicitly specified like the following.
            enabled = false
        }
    }

    release_channel {
        channel = "REGULAR"
    }

    timeouts {}
}
