job "hello-world-web-php" {
  datacenters = ["dc1"]

  type = "service"

  update {
    max_parallel = 1
    min_healthy_time = "10s"
    healthy_deadline = "3m"
    progress_deadline = "10m"
    auto_revert = false
    canary = 0
  }

  migrate {
    max_parallel = 1
    health_check = "checks"
    min_healthy_time = "10s"
    healthy_deadline = "5m"
  }

  group "cache" {
    count = 3

    restart {
      attempts = 2
      interval = "30m"
      delay = "15s"
      mode = "fail"
    }

    ephemeral_disk {
      size = 300
    }

    task "hello-world-web-task" {
      driver = "docker"

      config {
        image = "registry.ws.so/apps-hello-world-php"
        port_map {
          http = 80
        }
      }

     resources {
        cpu    = 500 # 500 MHz
        memory = 256 # 256MB
        network {
          mbits = 3
          port "http" {}
        }
      }

     service {
        name = "helloworld"
        tags = ["global", "php", "urlprefix-helloworld.ws.so/"]
        port = "http"
        check {
          name     = "alive"
          type     = "tcp"
          interval = "10s"
          timeout  = "2s"
        }
      }
   }
  }
}
