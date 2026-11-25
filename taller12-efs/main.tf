#Configuracion del proveedor de AWS
provider "aws" {
  region = var.region //region donde se desplegarán los recursos
}



#security group ec
resource "aws_security_group" "aws_my_security_group_efs_instancias_14" {
  name        = "mi-grupo-seguridad-efs-instancias-terraform"
  description = "Grupo de seguridad para la instancia"
  vpc_id      = "vpc-0b3d9f1ade08f39b4" //ID de la VPC donde se creará el grupo de seguridad

  #reglas de entrada SSH y salida HTTP del grupo de seguridad
  /*ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #egress {
   # from_port       = 2049
    #to_port         = 2049
    #protocol        = "tcp"
    #security_groups = [aws_security_group.aws_my_security_group_efs.id]
  #}
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  } */
}

#security group efs
resource "aws_security_group" "aws_my_security_group_efs_14" {
  name        = "mi-grupo-seguridad-efs-terraform"
  description = "Grupo de seguridad para la instancia"
  vpc_id      = "vpc-0b3d9f1ade08f39b4" //ID de la VPC donde se creará el grupo de seguridad

  #reglas de entrada SSH y salida HTTP del grupo de seguridad
  #ingress {
   # from_port       = 2049
    #to_port         = 2049
    #protocol        = "tcp"
    #security_groups = [aws_security_group.aws_my_security_group_efs_instancias.id]
  #}

  /*egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } */
}

#Reglas SG-instancias
#Entrada
#Entrada ssh
resource "aws_vpc_security_group_ingress_rule" "ingress_to_ssh_instancias" {
  security_group_id = aws_security_group.aws_my_security_group_efs_instancias_14
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4 = ["0.0.0.0/0"]
}

#salida
#salida efs
resource "aws_vpc_security_group_egress_rule" "egress_efs_instancias" {
  security_group_id = aws_security_group.aws_my_security_group_efs_instancias_14.id
  ip_protocol = "tcp"
  from_port   = 2049
  to_port     = 2049
  #Destino
  referenced_security_group_id = aws_security_group.aws_my_security_group_efs_14.id
}
#salida all traffic internet
resource "aws_vpc_security_group_egress_rule" "egress_all_traffic" {
  security_group_id = aws_security_group.aws_my_security_group_efs_instancias_14.id
  ip_protocol = "-1"
  #Destino
  cidr_ipv4 = "0.0.0.0/0"
}

#Reglas SG-EFS
#Entrada
#entrada efs
resource "aws_vpc_security_group_ingress_rule" "ingress_to_efs" {
  security_group_id = aws_security_group.aws_my_security_group_efs_14.id
  ip_protocol = "tcp"
  from_port   = 2049
  to_port     = 2049
  #Origen
  referenced_security_group_id = aws_security_group.aws_my_security_group_efs_instancias_14.id
}


#declaracion de los recursos de AWS
/*
resource "aws_instance" "mi_instancia_efs" {
  ami           = var.ami_id         //AMI de Amazon Linux 2
  instance_type = var.Tipo_instancia //tipo de instancia

  security_groups = [aws_security_group.aws_my_security_group_efs_instancias.name] //grupos de seguridad para la instancia

  key_name = var.nombre_llave //nombre del par de claves para acceder a la instancia

  tags = {
    Name = "MiInstanciaEFS_Terraform - ${count.index + 1}"
  }

  vpc_security_group_ids = [aws_security_group.aws_my_security_group_efs_instancias.id] //ID del grupo de seguridad para la instancia

  count = var.cantidad_instancias //cantidad de instancias a crear  
}
*/