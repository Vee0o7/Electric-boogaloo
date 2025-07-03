{pkgs,...}:
{
  programs.helix = {
    enable = true;
    # package = pkgs.evil-helix;
    settings = {
      editor = {
        line-number = "relative";
        cursor-shape = {
          insert = "bar";
        };
        completion-replace = true;
      };
      keys.normal = {
        "_" = "@I<esc>";
      };
    };
  };
}
