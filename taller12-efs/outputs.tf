//Imprimir en consola como salida al ejecutar el script, propiedades fijas o información que no se tiene conocimiento al momento de la ejecución del script, como por ejemplo el ID de un recurso creado por Terraform

output "id_instancias" {
  description = "The ID of the EC2 instances created"
  value       = aws_instance.mi_instancia_efs[*].id
}

output "cantidad_instancias" {
  description = "The number of EC2 instances created"
  value       = length(aws_instance.mi_instancia_efs)
}

output "ip_publica_instancias" {
  description = "The public IP addresses of the EC2 instances created"
  value       = aws_instance.mi_instancia_efs[*].public_ip
}

output "zonas_disponibilidad" {
  description = "The availability zones of the EC2 instances created"
  value       = aws_instance.mi_instancia_efs[*].availability_zone
}
