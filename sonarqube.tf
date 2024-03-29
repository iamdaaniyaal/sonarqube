// Configure the Google Cloud provider
provider "google" {
  credentials = "${file("${var.credentials}")}"
  project     = "${var.gcp_project}"
  region      = "${var.region}"
}

//SonarQube Instance
resource "google_compute_address" "sonarqubeip" {
  name   = "${var.sonarqube_instance_ip_name}"
  region = "${var.sonarqube_instance_ip_region}"
}


resource "google_compute_instance" "sonarqube" {
  name         = "${var.instance_name}"
  machine_type = "n1-standard-1"
  zone         = "us-east1-b"

  tags = ["name", "sonarqube", "http-server"]

  boot_disk {
    initialize_params {
      image = "centos-7-v20180129"
    }
  }

  // Local SSD disk
  #scratch_disk {
  #}

  network_interface {
    network    = "${var.sonarvpc}"
    subnetwork = "${var.sonarsub}"
    access_config {
      // Ephemeral IP
      nat_ip = "${google_compute_address.sonarqubeip.address}"
    }
  }
  metadata = {
    name = "sonarqube"
  }

  metadata_startup_script = "sudo yum update -y;sudo yum install git -y; sudo git clone https://github.com/iamdaaniyaal/sonarqube.git; cd /sonarqube; sudo chmod 777 /sonarqube/*; sudo sh sonarqube.sh"
}
