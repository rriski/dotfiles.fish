if status is-interactive
	if command -qs go
        fish_add_path -pm (go env GOPATH)/bin
    end
end
