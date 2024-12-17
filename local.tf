locals {
  public_ip = jsondecode(data.http.my_public_ip.body).ip
}
