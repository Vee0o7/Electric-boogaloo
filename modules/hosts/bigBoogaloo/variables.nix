{config, lib, ...}:
{
  config.var = {
    keyboardLayout = "us";
  };

  options = {
    var = lib.mkOption {
      type = lib.types.attrs;
      default = {};
    };
  };
}
