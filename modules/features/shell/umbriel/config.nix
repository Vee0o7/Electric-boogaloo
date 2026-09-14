{
  self,
  inputs,
  ...
}: {
  flake.nixosModules.umbriel = {
    imports = [inputs.umbriel.nixosModules.default];
    programs.umbriel.enable = true;
  };
  flake.homeModules.umbriel = {config, ...}: {
    imports = [self.homeModules.umbrielKeybinds inputs.umbriel.homeModules.default];
    programs.umbriel = {
      enable = true;
      settings = {
        general.autostart = ["noctalia"];
        layout = {
          mode = "scrolling";
          gap = 4;
        };
        input = {
          keyboard.layout = config.var.keyboardLayout;
          touchpad = {
            natural_scroll = false;
            disable_while_typing = true;
          };
        };
      };
    };
  };
}
