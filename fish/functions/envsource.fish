function envsource --description 'Load environment variables from a file'
    echo "Setting Environment variable from::  ~/.env"
    set -f envfile "$argv"
    if not test -f "$envfile"
        echo "Unable to load $envfile"
        return 1
    end
    while read line
        if not string match -qr '^#|^$' "$line"
            set item (string split -m 1 '=' $line)
            set -gx $item[1] $item[2]
            if test -n "\$$item[2]"
                set -gx PATH $item[2] $PATH
            end
            #echo "Exported key $item[1] = $item[2]"
        end
    end <"$envfile"
end
