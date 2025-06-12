data "yandex_compute_image" "image" {
  family = var.image_family
}

resource "yandex_compute_instance" "vm_1" {
  name     = var.vm_1_name
  hostname = var.vm_1_name
  zone     = var.zone
  platform_id = var.platform_id

  metadata = {
    # user-data = "${file("${path.module}/init/metadata.yml")}"
    user-data = templatefile("${path.module}/init/metadata.yml",
      {
        SERVER_LOGIN = var.server_login,
        SSH_KEY = var.ssh_key
      })
  }
  # metadata = {
  #   user-data = "${file("${path.module}/init/metadata.yml")}"
  # }
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

  # metadata = {
  #   ssh-keys = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDGalHSkdgJIA6zQ72iMql9q+3dQa3ybYaH2duvo3XqZ4scINidI64MnHqXKR2/o9WHQhWh7f6Imqj8XyRJXYujjqvqqeyYZ6N0p9v9jI3QXXOqiagaO4c+Yc5X4oSCWFlhqYiJ+Nt7SPBY24Og5772RlxhU1Qwr2LiFPbciHmsb+mQG+4EghGr2y55dNvDrST9k7NGo1hwGJUYawdTJl9X8a/VjqoJG9yTpPTwgzucjML5cp/53VKawB4wLUxUlb42X63pB2693cyo78k4ty4Iq3uKrWq71P4Dhl2r0+g/yP6V7R4BqHegVAq6OP49+fWwqk05O1hqocVT2EFteh1Wa5fIcSoBjlDusXAZnLyvoPeivXC4G1IfoYxbxtT8J3o9bgMZqzDl3O782KrzDABplqDE+edtDNXrp06UnCPs26Z9MAm1fhOzXoGbwTLet/o6TQN5rKUu1GY7R3qs/K5/8Dt96vizUraGloY1Xp+OkSJuCT/woCZY6l0lpw17KVAf4fUVpx2zCBuQVa13AAmDFzqd2b7amaUfqUE3qcf9HstI/maite0QWbWuxiGugnrWBzJ71oSkF0w15yXQ17P0IuQ7omPRhM81g7N0/TNE/b556sSIEF7QXZdHY7FC7YuMFdWnGjRHUx6SOY7AsTGOErcAQ7GnkRJUHbMncT+Tww== user@container-dev"
  # }

  # metadata = {
  #   user-data = "${file("${path.module}/init/metadata.yml")}"
  # }
  #
  # metadata = {
  #   user-data = "${file("${path.module}/init/metadata.yml")}"
  #   # user-data = templatefile("${path.module}/init/metadata.yml",
  #   #   {
  #   #     SERVER_LOGIN = var.server_login,
  #   #     SSH_KEY = var.ssh_key
  #   #   })
  # }
}