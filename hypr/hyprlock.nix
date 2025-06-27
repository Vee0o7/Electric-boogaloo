{

# GENERAL
general = {
  disable_loading_bar = true;
  hide_cursor = true;
};

# TIME
# label = {
#   text = "$TIME";
#   color = "rgb(b4befe)";
#   font_size = 90;
#   position = "0, 150";
#   halign = "center";
#   valign = "center";
# };

# DATE
label = {
  text = "cmd[update:43200000] date +'%A %d %B %Y'";
  color = "rgb(b4befe)";
  font_size = 25;
  position = "0, 50";
  halign = "center";
  valign = "center";
};



# INPUT FIELD
input-field = {
  size = "300, 60";
  outline_thickness = 3;
  dots_size = 0.2;
  dots_spacing = 0.2;
  dots_center = true;
  fade_on_empty = false;
  hide_input = false;
  fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
  position = "0, -47";
  halign = "center";
  valign = "center";
};
}
