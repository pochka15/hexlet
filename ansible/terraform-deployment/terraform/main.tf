terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.84.0"
    }
  }
}

variable "yandex_token" {}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = "b1gn8jo1kbnubin1iagk"
  folder_id = "b1gsl9933v8dibrl1ndc"
  zone      = "ru-central1-a"
}

resource "yandex_compute_instance" "l3-staging" {
  name                      = "l3-staging"
  platform_id               = "standard-v1"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ueg1g3ifoelgdaqhb" # Ubuntu 22.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.l3_network.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/digitalocean/id_rsa.pub")}"
  }
}

resource "yandex_compute_instance" "l3-prod" {
  name                      = "l3-prod"
  platform_id               = "standard-v1"
  zone                      = "ru-central1-a"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd8ueg1g3ifoelgdaqhb" # Ubuntu 22.04 LTS
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.l3_network.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/digitalocean/id_rsa.pub")}"
  }
}

output "compute_instances" {
  value = [
    yandex_compute_instance.l3-staging,
    yandex_compute_instance.l3-prod
  ]
}

resource "yandex_vpc_network" "l3_network" {}

resource "yandex_vpc_subnet" "l3_network" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.l3_network.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}

