if status is-interactive
	if test -d (asdf where golang)
        set -gx GO111MODULE on
        set -gx GOROOT (asdf where golang)/go
        set -gx GOPATH (asdf where golang)/packages
        fish_add_path -am (go env GOPATH)/bin
    end
end
