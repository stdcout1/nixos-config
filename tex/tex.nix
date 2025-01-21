# im not a power user so this suffices 
with import <nixpkgs> {};
pkgs.mkShell {
    packages = with pkgs; [
        (texliveMedium.withPackages (ps: with ps; [ listings xcolor tcolorbox pgf environ ]))
        texstudio
    ];
    #usefull for spell check in texmaker need to manually set tough
    shellHook = ''
        mkdir ./dictionaries
        curl https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_CA.dic > ./dictionaries/en_CA.dic
        curl https://cgit.freedesktop.org/libreoffice/dictionaries/plain/en/en_CA.aff > ./dictionaries/en_CA.aff
        texstudio
    '';
}

