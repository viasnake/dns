# variable "zone" {
#   description = "Cloudflare zone"
#   type        = string
#   default     = "mcplay.biz"
# }

variable "zone_id" {
  description = "Cloudflare zone ID"
  type        = string
  default     = "fb1a2fe77f3e5bd4af467914f59a8743"
}

variable "tcpshield" {
  description = "TCPShield backend CNAME"
  type        = string
  default     = "187f47ac9e331cf14b15afd04dec3c04.ipv4.tcpshield.com"
}
