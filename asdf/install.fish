#!/usr/bin/env fish

set -g ASDF_VERSION "v0.16.3"
set -g ASDF_URL "https://github.com/asdf-vm/asdf/releases/download/$ASDF_VERSION"

function download_asdf
    set -l os (uname | tr '[:upper:]' '[:lower:]')
    set -l arch (uname -m)
    switch $arch
        case "x86_64"
            set arch "amd64"
        case "arm64" "aarch64"
            set arch "arm64"
        case "*"
            echo "Unsupported architecture: $arch"
            return 1
    end

    set -l file "asdf-$ASDF_VERSION-$os-$arch.tar.gz"
    set -l url "$ASDF_URL/$file"
    set -l temp_dir (mktemp -d)
    set -l dest "$HOME/.local/bin/asdf"

    echo "Downloading asdf from $url"
    curl -L $url -o $temp_dir/$file
    tar -xzf $temp_dir/$file -C $HOME/.local/bin
    rm -r $temp_dir
    chmod +x $dest
end

function setup_asdf
    set -l asdf_data_dir "$HOME/.asdf"
    set -l asdf_shims "$asdf_data_dir/shims"

    if not test -d $asdf_data_dir
        mkdir -p $asdf_data_dir
    end

    fish_add_path -am $asdf_shims

    if not set -q ASDF_DATA_DIR
        set -x ASDF_DATA_DIR $asdf_data_dir
    end

    echo "Regenerating shims"
    asdf reshim
end

download_asdf
setup_asdf

for plugin in nodejs lua golang terraform python rust pipx
    if not test -d ~/.asdf/plugins/$plugin
        asdf plugin add $plugin
        asdf install $plugin latest
        asdf set $plugin latest
    end
end
