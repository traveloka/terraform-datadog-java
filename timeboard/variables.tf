variable "product_domain" {
  type        = "string"
  description = "The name of the product domain which this Java belongs to"
}

variable "cluster" {
  type        = "string"
  description = "The name of the cluster which this Java belongs to"
}

variable "garbage_collector" {
  type        = "string"
  description = "The GC algorithm which this Java uses"
}
