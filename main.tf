resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = "n1-standard-1"  
  zone         =  var.jenkins_zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"  
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-SCRIPT
    #!/bin/bash
    # Install Jenkins
    wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo 
apt-key add -
    sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > 
/etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install -y openjdk-11-jdk jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins
  SCRIPT
}

resource "google_compute_firewall" "jenkins_firewall" {
  name    = "jenkins-firewall"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "qserver" {
  name         = "qserver"
  machine_type = "n1-standard-1"
  zone         = var.qserver_zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}

resource "google_compute_instance" "prod" {
  name         = "prod"
  machine_type = "n1-standard-1"
  zone         = var.prod_zone
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}

