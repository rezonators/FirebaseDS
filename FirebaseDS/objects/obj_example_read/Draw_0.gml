// position button
x = room_width * 0.5;
y = room_height * 0.4;

// coordinates for button rectangle
var buttonX1 = x - (buttonWidth / 2);
var buttonY1 = y - (buttonHeight / 2);
var buttonX2 = buttonX1 + buttonWidth;
var buttonY2 = buttonY1 + buttonHeight;
var mouseover = point_in_rectangle(mouse_x, mouse_y, buttonX1, buttonY1, buttonX2, buttonY2);

// draw button rectangle
draw_set_alpha(1);
draw_set_color(merge_color(c_blue, c_white, mouseover ? 0.5 : 0));
draw_roundrect(buttonX1, buttonY1, buttonX2, buttonY2, false);

// draw button text
draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_text(floor(mean(buttonX1, buttonX2)), floor(mean(buttonY1, buttonY2)), "Read");

// click on button
if (mouseover) {
	if (mouse_check_button_released(mb_left)) {
		show_debug_message("Read clicked");
		
		// verify that a project id was set
		var projectID = extension_get_option_value("YYFirebaseFirestore","ProjectID");
		if (!is_string(projectID) || projectID == "") {
			show_message("No project ID set! Please edit this value in YYFirebaseFirestore");
			exit;
		}
		else {
			// read the doc: test/doc
			with (obj_control) listener_read = FirebaseFirestore("test/doc").Read();
		}
	}
}