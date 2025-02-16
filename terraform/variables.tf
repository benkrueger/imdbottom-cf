// terraform/variables.tf
variable "cloudflare_email" {
    description = "Cloudflare account email"
}

variable "cloudflare_api_key" {
    description = "Cloudflare API key"
}

variable "domain" {
    description = "Domain to deploy the site"
    default = "imdbottom.xyz"
}
