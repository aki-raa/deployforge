variable "network_name" {
  description = "Docker network name"
  type        = string
  default     = "deployforge-net"
}

variable "app_container_name" {
  description = "Application container name"
  type        = string
  default     = "deployforge-app"
}

variable "app_image" {
  description = "Application Docker image"
  type        = string
  default     = "deployforge-app"
}

variable "app_internal_port" {
  description = "Application container port"
  type        = number
  default     = 8080
}

variable "app_external_port" {
  description = "Application host port"
  type        = number
  default     = 8090
}

variable "target_container_name" {
  description = "Ansible target container name"
  type        = string
  default     = "deployforge-ansible-target"
}

variable "target_image" {
  description = "Ansible target Docker image"
  type        = string
  default     = "deployforge-ansible-target"
}

variable "ssh_external_port" {
  description = "SSH host port"
  type        = number
  default     = 2222
}

variable "nginx_external_port" {
  description = "Nginx host port"
  type        = number
  default     = 8081
}
