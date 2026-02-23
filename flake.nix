{
    description = "super cookie NixOS config!";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { self, nixpkgs, ... } @ inputs: {
        nixosConfigurations.cookie = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./boot/boot.nix
                ./configuration.nix
            ];
        };
    };
}
