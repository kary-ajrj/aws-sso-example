variable "target_id" {
  type    = string
  default = ""
}

variable "admin_user_information" {
  type = list(object({
    email      = string
    first_name = string
    last_name  = string
  }))
}
