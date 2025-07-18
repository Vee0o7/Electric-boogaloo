{...}:
{
  services.hypridle = {
    enable = false;
    settings = {
      general =  {
        lock_cmd = "uwsm app -- hyprlock";
      };
      listener = [
        { # screen off after 5 mins
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        { # lock after 10 mins
          timeout = 600;
          on-timeout = "uwsm app -- hyprlock";
        }
        { # suspend after 20 mins
          timeout = 1200;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
