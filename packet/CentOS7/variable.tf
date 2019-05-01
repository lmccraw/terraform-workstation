# This is your Packet API Auth token
variable "auth_token" {}

# This is the string of numbers when you log into Packet and get to your Project Space
# For example, if you see your devices listed at
# https://app.packet.net/projects/352000fb2-ee46-4673-93a8-de2c2bdba33b
# .. then 352000fb2-ee46-4673-93a8-de2c2bdba33b is your project ID.

variable "project_id" {}

# Path to your ssh_key. Create a new one and use it solely for Packet.

variable "ssh_key" {
  type = "string"
}
