rosource "aws_instance" "test-server" {
ami = "ami-04b70fa74e45c3917"
instance_type = "t2.micro"
key_name = "sri"
vpc_security_group_ids = ["sg-0c77b822c85ed438d"] 
tags = {
Name = "test-server" 
}
connection {
type = "ssh"
user = "ubuntu"
private_key = file("./sri.pem")
host = self.public_ip
}
provisioner "remote-exec" {
  inline = [" echo 'wait to start instance' "]
  }
provisioner "local-exec" {
   command = " echo $(aws_instance.test-server.public_ip) > inventory "
   }
provisioner "local-exec" {
   command =  "ansible-playbook /home/sri/workspace/BANK-PROJECT/scripts/finance-playbook.yml"
   } 
   }
