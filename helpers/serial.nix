interface: builtins.replaceStrings [ ":" "\n" ] [ "" "" ] (builtins.readFile /sys/class/net/${interface}/address)
