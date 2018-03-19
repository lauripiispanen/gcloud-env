resource "google_compute_global_forwarding_rule" "commits_top" {
  name       = "commits-top-default-rule"
  target     = "${google_compute_target_http_proxy.commits_top.self_link}"
  port_range = "80"
}

resource "google_compute_target_http_proxy" "commits_top" {
  name             = "commits-top-proxy"
  url_map          = "${google_compute_url_map.commits_top.self_link}"
}

resource "google_compute_url_map" "commits_top" {
  name        = "commits-top-url-map"
  default_service = "${google_compute_backend_bucket.commits_top.self_link}"

  host_rule {
    hosts        = ["commits.top"]
    path_matcher = "everything"
  }

  path_matcher {
    name            = "everything"
    default_service = "${google_compute_backend_bucket.commits_top.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_bucket.commits_top.self_link}"
    }
  }
}

resource "google_compute_backend_bucket" "commits_top" {
  name        = "commits-top-static-backend-bucket"
  bucket_name = "${google_storage_bucket.commits_top.name}"
  enable_cdn  = true
}

resource "google_storage_bucket" "commits_top" {
  name     = "commits-top-static"
  location = "EU"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}
