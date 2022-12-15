data "external" "whatismyip" {
  program = ["/bin/bash" , "${path.module}/whatismyip.sh"]
}
resource "aws_security_group_rule" "allow_ssh_from_my_ip" {
 type = "ingress"
 from_port = 22
 to_port = 22
 protocol = "tcp"
 cidr_blocks = [format("%s/%s",data.external.whatismyip.result["internet_ip"],32)]
 security_group_id = "sg-0cb7069aaf1460c93"
}