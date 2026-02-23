{ config, pkgs, ... }:

{
    boot = {
        loader.grub = {
            enable = true;
            device = "nodev";
            useOSProber = true;
            efiSupport = true;
            gfxmodeEfi = "1920x1080";
            splashImage = ./splash.png;
            theme = ./grub-theme;
            configurationLimit = 60;
        };

    	loader.efi.canTouchEfiVariables = true;
    	loader.efi.efiSysMountPoint = "/boot";

        plymouth = {
            enable = true;
            themePackages = [
                (pkgs.stdenv.mkDerivation rec {
                    pname = "frieren";
                    version = "1.0";

                    src = ./plymouth-theme;

                    dontBuild = true;
                    installPhase = ''
                        runHook preInstall
                        mkdir -p $out/share/plymouth/themes/${pname}
                        cp -r * $out/share/plymouth/themes/${pname}
                        find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;
                        runHook postInstall
                    '';
                })
            ];
            theme = "frieren";
        };

    	consoleLogLevel = 3;
        initrd.verbose = false;
        initrd.systemd.enable = true;
    	kernelPackages = pkgs.linuxPackages_latest;
    	kernelParams = [ 
            "splash"
            "quiet" 
            "loglevel=3"
            "systemd.show_status=auto"
        ];
    };
}
