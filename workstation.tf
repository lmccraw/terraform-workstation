provider "packet" {
  auth_token = "${var.auth_token}"
}

resource "packet_device" "web1" {
  hostname         = "web1"
  plan             = "c1.small.x86"
  #plan             = ["x1.small.x86", "c1.small.x86", "t1.small.x86"]
  facilities         = ["iad1", "atl1", "ewr1"]
  operating_system = "centos_7"
  billing_cycle    = "hourly"
  project_id       = "${var.project_id}"

  provisioner "file" {
    source = "remote/setup.sh"
    destination = "/tmp/setup.sh"
  }
  provisioner "remote-exec" {
    on_failure = "fail"
    inline = [
      "bash /tmp/setup.sh"
    ]
  }
  connection {
    type = "ssh"
    host = "${packet_device.web1.access_public_ipv4}"
    user = "root"
    private_key = "${file(var.ssh_key)}"
  }
}
