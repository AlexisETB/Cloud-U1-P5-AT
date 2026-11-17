#Config del proveedor AWS
provider "aws" {
  region = "us-east-1" //region donde se desplegarán los recursos

}

#security group
resource "aws_security_group" "mi_grupo_seguridad" {
  name        = "mi-grupo-seguridad-terraform"
  description = "Grupo de seguridad para la instancia"
  vpc_id      = "vpc-0b3d9f1ade08f39b4" //ID de la VPC donde se creará el grupo de seguridad

  #reglas de entrada SSH y salida HTTP del grupo de seguridad
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
  ami           = "ami-0c230065b91270bc6" //AMI de Amazon Linux 2
  instance_type = "t2.micro"              //tipo de instancia

  security_groups = [aws_security_group.mi_grupo_seguridad.name] //grupos de seguridad para la instancia

  key_name = "mi-primera-llaves-at" //nombre del par de claves para acceder a la instancia

  tags = {
    Name = "MiInstanciaTerraform2"
  }

  vpc_security_group_ids = [aws_security_group.mi_grupo_seguridad.id] //ID del grupo de seguridad para la instancia
}
