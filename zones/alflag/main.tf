data "cloudflare_zone" "main" {
  name = var.zone
}

resource "cloudflare_record" "issues" {
  zone_id         = data.cloudflare_zone.main.id
  name            = "issues"
  value           = "alflag.youtrack.cloud"
  type            = "CNAME"
  ttl             = "3600"
  proxied         = false
  allow_overwrite = true
}

resource "cloudflare_record" "txt_spf" {
  zone_id         = data.cloudflare_zone.main.id
  name            = "@"
  value           = "v=spf1 include:_spf.mx.cloudflare.net ~all"
  type            = "TXT"
  allow_overwrite = true
}

resource "cloudflare_record" "txt_dmarc" {
  zone_id = data.cloudflare_zone.main.id
  name    = "_dmarc"
  value   = "v=DMARC1; p=none; rua=mailto:${var.email}"
  type    = "TXT"
}

resource "cloudflare_record" "txt_dkim" {
  zone_id = data.cloudflare_zone.main.id
  name    = "api._domainkey"
  value   = "k=rsa;t=s;p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCbmGbQMzYeMvxwtNQoXN0waGYaciuKx8mtMh5czguT4EZlJXuCt6V+l56mmt3t68FEX5JJ0q4ijG71BGoFRkl87uJi7LrQt1ZZmZCvrEII0YO4mp8sDLXC8g1aUAoi8TJgxq2MJqCaMyj5kAm3Fdy2tzftPCV/lbdiJqmBnWKjtwIDAQAB"
  type    = "TXT"
}