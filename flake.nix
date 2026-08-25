{
  description = "cvault - Qt C++ Password Manager";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = { self, nixpkgs }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      nixpkgsFor = forAllSystems (system: import nixpkgs { inherit system; });
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.stdenv.mkDerivation {
            pname = "cvault";
            version = "0.0.1";
            src = ./.;

            nativeBuildInputs = with pkgs; [
              cmake
              qt6.wrapQtAppsHook
            ];

            buildInputs = with pkgs; [
              qt6.qtbase
            ];
          };
        });

      devShells = forAllSystems (system:
        let
          pkgs = nixpkgsFor.${system};
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              git
              neovim
              cmake
              gnumake
              gcc
              qt6.qtbase
              qt6.qttools
            ];

            shellHook = ''
              PROJECT_ROOT=$PWD
              export PROMPT_COMMAND='
                REL_DIR="''${PWD#$PROJECT_ROOT}"
                if [ "$REL_DIR" = "$PWD" ]; then
                  # Если вышли за пределы проекта, показываем полный путь
                  DISPLAY_DIR="$PWD"
                else
                  DISPLAY_DIR="~''${REL_DIR}"
                fi
                PS1="\n\[\e[1;32m\]devshell\[\e[0m\] \[\e[1;34m\]''${DISPLAY_DIR}\[\e[0m\]\n$ "
              '
            '';
          };
        });
    };
}