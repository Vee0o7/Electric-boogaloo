{config, lib, ...}:
{
  config.var = {
    keyboardLayout = "gb";
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
