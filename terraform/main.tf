// terraform/main.tf
provider "cloudflare" {
    email = var.cloudflare_email
    api_key = var.cloudflare_api_key
}

resource "cloudflare_zone" "imdbottom" {
    zone = var.domain
}

resource "cloudflare_record" "www" {
    zone_id = cloudflare_zone.imdbottom.id
    name    = "www"
    value   = "your_pages_project.pages.dev"
    type    = "CNAME"
    proxied = true
}

resource "cloudflare_worker_script" "imdbottom" {
    name = "imdbottom-worker"
    content = file("../src/worker.js")
}

resource "cloudflare_worker_route" "
