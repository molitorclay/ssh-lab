{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

let
  sshKey = ./id_ed25519.pub;
  sshDir = pkgsLinux.runCommand "ssh-dir" {} ''
    mkdir -p $out/.ssh
    cp ${sshKey} $out/.ssh/authorized_keys
    chmod 700 $out/.ssh
    chmod 600 $out/.ssh/authorized_keys
  '';
  sshHostSetup = pkgsLinux.runCommand "ssh-host-keys" {
    nativeBuildInputs = [ 
      pkgsLinux.openssh 
      pkgsLinux.shadow
      pkgsLinux.su
    ];
  } ''
    mkdir -p $out/etc/ssh
    ssh-keygen -A -f $out
    chmod 700 $out/etc/ssh/ssh_host_ed25519_key
    chmod 700 $out/etc/ssh/* -R
  '';
in

pkgs.dockerTools.buildImage {
  name = "parfait";
  tag = "latest";
  
  copyToRoot = with pkgsLinux; [
    openssh
    bashInteractive
    coreutils
    sl
    asciiquarium
    sshDir
    sshHostSetup
    shadow
  ];

  config = {
    Cmd = ["bash"  ];
  };
  runAsRoot = ''
    
    useradd -r -M -d /var/empty/sshd -s /sbin/nologin sshd
    mkdir /var/empty/sshd -p
    chmod 700 /etc/ssh/ -R

    useradd joe -m -s /bin/bash
    mkdir -p /home/joe/.ssh
    cp .ssh/authorized_keys /home/joe/.ssh/authorized_keys 
  '';
}
