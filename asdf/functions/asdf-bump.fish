function asdf-bump -d "bump all asdf tools to latest version"
    for line in (asdf current)
        set -l tool_name (echo $line | cut -d " " -f 1)[1]
        set latest_version (asdf latest $tool_name)

        if test $status -eq 0
            asdf install $tool_name latest
            asdf set --home $tool_name (asdf latest $tool_name)
        end
    end
end
