data "yandex_compute_image" "image" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm_1" {
  name     = var.vm_1_name
  hostname = var.vm_1_name
  zone     = var.zone
  platform_id = var.platform_id

  metadata = {
    user-data = templatefile("${path.module}/init/metadata.yml",
      {
        SERVER_LOGIN = var.server_login,
        SSH_KEY = var.ssh_key
      })
  }

  resources {
    cores  = var.cores
    memory = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      type     = var.disk_type
      image_id = data.yandex_compute_image.image.id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id            = yandex_vpc_subnet.infra_subnet[0].id
    nat                  = var.nat
    security_group_ids   = [yandex_vpc_security_group.infra_sg.id]
  }
}