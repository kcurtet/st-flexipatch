{
  description = "Flake utils demo";

  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        packages = {
          st = pkgs.stdenv.mkDerivation {
            name = "st";
            src = ./.;
            nativeBuildInputs = [ pkgs.pkg-config ];
            buildInputs = with pkgs; with xorg; [ libX11 libXft imlib2 fontconfig freetype libsixel ];
          };
        };
        apps = {
          st = flake-utils.lib.mkApp { drv = self.packages.${system}.st; };
        };
      }
    );
}
