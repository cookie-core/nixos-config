{
  description = "NixOS configuration with zapret-discord-youtube";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    minegrub-theme.url = "github:Lxtharia/minegrub-theme";
  };

  outputs = { self, nixpkgs, ... } @ inputs: {
    nixosConfigurations.cookie = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix

        inputs.zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general(ALT10)";
            listGeneral = [ "youtube.com" "youtu.be" ];
            listExclude = [ "chatgpt.com" ];
            ipsetAll = [ "192.168.1.0/24" "10.0.0.1" ];
            ipsetExclude = [ "203.0.113.0/24" ];
          };
        }
        
        # inputs.minegrub-theme.nixosModules.default
      ];
    };
  };
}
