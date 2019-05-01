provider "packet" {
  auth_token = "${var.auth_token}"
}

resource "packet_device" "web1" {
  hostname         = "workstation1"
  plan             = "t1.small.x86"
  facilities         = ["iad1", "atl1", "ewr1"]
  operating_system = "centos_7"
  billing_cycle    = "hourly"
  project_id       = "${var.project_id}"

  provisioner "file" {
    source = "remote/"
    destination = "/tmp"
  }
  provisioner "remote-exec" {
    on_failure = "fail"
    inline = [
      "bash /tmp/setup.sh"
    ]
  }
  provisioner "remote-exec" {
    inline = [
      "bash /tmp/tools.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "bash /tmp/docker.sh"
    ]
  }
  connection {
    type = "ssh"
    host = "${packet_device.web1.access_public_ipv4}"
    user = "root"
    private_key = "${file(var.ssh_key)}"
    timeout = "15m"
  }
}
