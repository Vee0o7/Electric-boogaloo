{pkgs, lib, inputs, extraInputs, ...}:
{
    imports = [./hyprland.nix];
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        xwayland.enable = true;
        package = null;
        portalPackage = null;
        plugins = [
            # inputs.hyprspace.packages.${pkgs.system}.Hyprspace
            inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
        ];
    };

    # home.file = {
    #     ".config/hypr/pyprland.toml".source = (pkgs.formats.toml {}).generate "something.toml" {
    #         pyprland = {
    #             plugins = [
    #
    #             ];
    #         };
    #         scratchpads = {
    #             music = {
    #                 animation = "fromTop";
    #                 command = "ghostty --command=spotify_player";
    #                 class = "scratchpad";
    #                 size = "100% 100%";
    #                 pinned = false;
    #                 # excludes = ''"*"'';
    #                 # allow_special_workspaces = true;
    #             };
    #         };
    #     };
    # };
}
