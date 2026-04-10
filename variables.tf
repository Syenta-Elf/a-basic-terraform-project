variable "image_list" {
  type = map(object({
    tag           = string
    target_port = optional(number)
    external_port = optional(number)
    env           = optional(set(string))
  }))
}