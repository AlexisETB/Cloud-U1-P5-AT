//conjunto de variables a ser ingresados por el ussuario que ejecute el Script


//region donde se desplegará los recursos
variable "region" {
  description = "The AWS region"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
  default     = "ami-0c230065b91270bc6" //AMI de Amazon Linux 2
}

variable "Tipo_instancia" {
  description = "The instance type for the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "nombre_llave" {
  description = "The name of the key pair to use for the EC2 instance"
  type        = string
  default     = "mi-primera-llaves-at"
}

variable "cantidad_instancias" {
  description = "The number of EC2 instances to create"
  type        = number
  default     = 2
}
