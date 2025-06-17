{
  description = "Docker image with SSH server";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.default = 
      let
        pkgs = import nixpkgs {
          system = "x86_64-linux";
        };

          sshKey = ./id_ed25519.pub;
          sshDir = pkgs.runCommand "ssh-dir" {} ''
            mkdir -p $out/.ssh
            cp ${sshKey} $out/.ssh/authorized_keys
            chmod 700 $out/.ssh
            chmod 600 $out/.ssh/authorized_keys
          '';
          sshHostKeys = pkgs.runCommand "ssh-host-keys" {
            nativeBuildInputs = [ pkgs.openssh ];
          } ''
            mkdir -p $out/etc/ssh
            ssh-keygen -A -f $out
            chmod 700 $out/etc/ssh/ssh_host_ed25519_key
            chmod 700 $out/etc/ssh -R
          '';

      in
        pkgs.dockerTools.buildImage {
          name = "parfait";
          tag = "latest";

          config = {
            Cmd = [ "bash"  ];
            ExposedPorts = {
              "22/tcp" = {};
            };
          };

          copyToRoot = with pkgs; [
            bash
            coreutils
            openssh
            shadow # for useradd/chpasswd
            utillinux

            sshDir
            sshHostKeys
          ];
        };
  };
}
