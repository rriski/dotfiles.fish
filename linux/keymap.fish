#!/usr/bin/env fish

# Define the path to the symbols file and the evdev.xml file
set symbols_file /usr/share/X11/xkb/symbols/fi
set evdev_file /usr/share/X11/xkb/rules/evdev.xml

# Define the new layout configuration
set layout_config 'partial alphanumeric_keys
xkb_symbols "coding" {

    include "fi(nodeadkeys)"

    name[Group1]="Finnish (coding)";

    key <AC11> { [  adiaeresis,      Adiaeresis,       asciicircum,           AE                    ] };
    key <AD11> { [  bracketleft,     braceleft,        slash,                 backslash             ] };
    key <AD12> { [  bracketright,    braceright,       tilde,                 dead_macron           ] };
    key <BKSL> { [  apostrophe,      asterisk,         bar,                   breve                 ] };
    key <AB08> { [  comma,           semicolon,        less                                         ] };
    key <AB09> { [  period,          colon,            greater,               notsign               ] };
};'

# Define the variant to be added to evdev.xml
set variant_config '<variant>
      <configItem>
        <name>coding</name>
        <description>Finnish (coding)</description>
      </configItem>
    </variant>'

# Check if the symbols file already contains the layout configuration, append if not
if not grep -q "Finnish (coding)" $symbols_file
    echo $layout_config | sudo tee -a $symbols_file
end

# Check if the evdev.xml file already contains the variant configuration, append if not with xmlstarlet
if not grep -q "<name>coding</name>" $evdev_file
    sudo xmlstarlet ed -L \
        -s "/xkbConfigRegistry/layoutList/layout[configItem/name='fi']/variantList" -t elem -n "variant" -v "" \
        --var lastVariant '$prev' \
        -s '$lastVariant' -t elem -n "configItem" -v "" \
        -s '$lastVariant/configItem' -t elem -n "name" -v "coding" \
        -s '$lastVariant/configItem' -t elem -n "description" -v "Finnish (coding)" \
        $evdev_file
end

setxkbmap -layout "fi(coding)"
