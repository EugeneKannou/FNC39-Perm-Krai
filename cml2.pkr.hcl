source "vmware-vmx" "cml2" {
  source_path      = "cml240/cml240_rev2.vmx"
  vm_name          = "cml2"
  ssh_username     = "sysadmin"
  ssh_password     = "sysadmin"
  ssh_port         = "1122"
  headless         = true
  shutdown_command = "sudo shutdown now"
  skip_compaction  = true
  vmx_data = {
    "uuid.bios"     = "56 4d a2 ef 1b 52 51 7b-6f 70 dd d0 2b fe 35 95"
    "uuid.action"   = "keep"
  }
  format          = "ova"
  ovftool_options = ["--exportFlags=mac,uuid"]
}

build {
  sources = ["source.vmware-vmx.cml2"]

  provisioner "shell" {
    script          = "fixes/sudo_passless.sh"
    execute_command = "echo sysadmin | sudo -S bash -c '{{ .Path }}'"
  }

  provisioner "shell" {
    inline = [
      "until ping -c1 mirror.yandex.ru &>/dev/null; do :; done",
      "sudo apt-get update -y",
      "sleep 10",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y cloud-init",
      "sudo cloud-init clean --logs",
    ]
  }
}
