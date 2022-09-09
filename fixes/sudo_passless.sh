#!/usr/bin/env bash
sudo sed -i '0,/%sudo[[:space:]]*ALL=(ALL:ALL)[[:space:]]*ALL/{s||%sudo ALL=(ALL) NOPASSWD: ALL|}' /etc/sudoers