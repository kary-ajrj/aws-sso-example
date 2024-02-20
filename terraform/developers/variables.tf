variable "dev_target_id" {
  type    = list(string)
  default = [""]
}

variable "read_target_id" {
  type    = list(string)
  default = [""]
}

variable "dev_user_information" {
  type = list(object({
    email      = string
    first_name = string
    last_name  = string
  }))
}
