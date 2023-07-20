function pubkey
    set PUBKEY ~/.ssh/id_ed25519.pub
    switch (uname)
    case Darwin
        more $PUBKEY | pbcopy
		    and echo (set_color brblue)'-> Public key copied to clipboard'
    case Linux
        xclip -selection clipboard -i < $PUBKEY
    end
end
