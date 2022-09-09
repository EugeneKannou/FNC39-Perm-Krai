terraform {
  required_providers {
    vcd = {
      source = "vmware/vcd"
      version = "3.7.0"
    }
  }
}

provider "vcd" {
  url                  = var.vcd_url
  user                 = var.vcd_login
  password             = var.vcd_pass
  org                  = var.vcd_org
  vdc                  = var.vcd_vdc
  auth_type            = "integrated"
}

locals {
  catalog = "cml2-catalog"
}

resource "vcd_catalog" "cml2-catalog" {
  org = var.vcd_org

  name             = local.catalog
  description      = "catalog for vApps"
  delete_recursive = "true"
  delete_force     = "true"
}

resource "vcd_catalog_item" "cml2-vApps" {
  org     = var.vcd_org
  catalog = local.catalog

  name                 = "cml2"
  description          = "Cisco Modeling Labs 2"
  ova_path             = "../output-cml2/cml2.ova"
  upload_piece_size    = 10
  show_upload_progress = true

  metadata = {
    license = "public"
    version = "v1"
  }
  catalog_item_metadata = {
    environment = "production"
  }
}