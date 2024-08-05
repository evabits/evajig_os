let 
  config = import <evajig-config> {};
in {
  disko.devices.disk.main = {
    type = "disk";
    device = config.disk;
    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "500M";
          label = "BOOT";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
          };
        };
        swap = {
          size = "8G";
          label = "swap";
          content = {
            type = "swap";
          };
        };
        root = {
          size = "100%";
          label = "nixos";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
