if status is-interactive
	if command -qs go
        fish_add_path -am (go env GOPATH)/bin
    end
end
