variable "subscription_id" {
  description = ""
}
variable "client_id" {
  description = ""
}
variable "client_secret" {
  description = ""
}
variable "tenant_id" {
  description = ""
}
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

# https://www.terraform.io/docs/backends/config.html
# https://www.terraform.io/docs/backends/types/azurerm.html
// terraform {
//   backend "azurerm" {}
// }
