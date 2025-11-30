data "cloudflare_zone" "main" {
  zone_id = var.zone_id
}

resource "cloudflare_dns_record" "mx" {
  for_each = {
    aspmx0 = {
      content  = "aspmx.l.google.com"
      priority = 1
    }
    aspmx1 = {
      content  = "alt1.aspmx.l.google.com"
      priority = 5
    }
    aspmx2 = {
      content  = "alt2.aspmx.l.google.com"
      priority = 5
    }
    aspmx3 = {
      content  = "alt3.aspmx.l.google.com"
      priority = 10
    }
    aspmx4 = {
      content  = "alt4.aspmx.l.google.com"
      priority = 10
    }
  }

  zone_id  = data.cloudflare_zone.main.id
  name     = "@"
  content  = each.value.content
  priority = each.value.priority
  type     = "MX"
  ttl      = "60"
}

resource "cloudflare_dns_record" "txt" {
  for_each = {
    google_site_verification = {
      name    = "@"
      content = "google-site-verification=sz8B-3deGXTfQdseWHSPXF8NNyHGOAt4VhTfvC0EHqk"
    }
    dmarc = {
      name    = "_dmarc"
      content = "v=DMARC1; p=none; rua=mailto:9ea9b323aff54a4ba884e5a9f7027622@dmarc-reports.cloudflare.net"
    }
  }

  zone_id = data.cloudflare_zone.main.id
  name    = each.value.name
  content = each.value.content
  type    = "TXT"
  ttl     = "60"
}
