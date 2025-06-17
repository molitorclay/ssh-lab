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
    nativeBuildInputs = [ pkgsLinux.openssh ];
  } ''
    mkdir -p $out/etc/ssh
    ssh-keygen -A -f $out
    chmod 700 $out/etc/ssh/ssh_host_ed25519_key
    chmod 700 $out/etc/ssh/* -R


    echo "sshd:x:1000:1000:sshd user:/var/empty:/bin/false" > $out/etc/passwd
    echo "sshd:x:1000:" > $out/etc/group
  '';
in

pkgs.dockerTools.buildImage {
  name = "parfait";
  copyToRoot = with pkgsLinux; [
    openssh
    bashInteractive
    coreutils
    sl
    asciiquarium
    sshDir
    sshHostSetup
  ];

  config = {
    Cmd = [ "bash" ];
  };
}
