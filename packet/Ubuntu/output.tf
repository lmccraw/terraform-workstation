#Fix output before running
output "public_ip" {
  value = "${packet_device.web1.access_public_ipv4}"
}
