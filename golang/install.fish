#!/usr/bin/env fish

if command -q go
    set -Ux GO111MODULE on
    set -Ux GOPATH (asdf where golang)/packages
    set -Ux GOROOT (asdf where golang)/go
    fish_add_path -pm (go env GOPATH)/bin
end
