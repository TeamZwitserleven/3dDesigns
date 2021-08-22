//
// Parametric Cable Hook / Hanger
// by Andy Gock, 2012-12-23
//
// Print at around 3 to 20 % infill depending on how strong you like it
//
// Inspired by charlespax Cable Hanger http://www.thingiverse.com/thing:5383
// but wanted a parametric OpenSCAD version of a similar functioning hook.
//

// general parameters
height          = 40.0;
width           = 10.0;
inside_diameter = 20.0;
thickness       = 4.0;
cutout_angle    = 100.0; // degrees of open area of the hook loop, lower is smaller gap in hook

screw_hole_offset = 8; // offset from absolute top

// sizes below are for a 8 gauge countersunk wood screw
screw_hole           = 4.1;
countersink_diameter = 8.2;
countersink_enable   = 1; // set to 1 to enable countersink, set to 0 for just a straight hole

// for internal use, thiis is how much to oversize an object which is
// used to subtract from other objects to avoid the aligned surfaces problem
// no need to change this
diff_fudge = 1.0;

// make the cable hook
cable_hook();

// cable hook module
// note: origin is at the centre of the main circular / cylindrical sections
module cable_hook(height=height, inside_diameter=inside_diameter, thickness=thickness, screw_hole=screw_hole, screw_hole_offset=screw_hole_offset, countersink_diameter=countersink_diameter, countersink_enable=countersink_enable) {

	bar_length = height - thickness/2 - inside_diameter/2 - thickness;

	countersink_height = (countersink_diameter - screw_hole)/2;
		
	$fn = 128;

	difference() {

		union() {

			difference() {
				// outside cylinder
				cylinder(r=(inside_diameter+2*thickness)/2, h=width);

				// inside cylinder
				translate([0,0,-diff_fudge])
					cylinder(r=inside_diameter/2, h=width+2*diff_fudge);
				
				// cutout cylinders to make the hook opening
				translate([0,0,-diff_fudge]) {
					linear_extrude(height=width+2*diff_fudge) {
						polygon(points=[ [0,0], [-cos(cutout_angle)*20,sin(cutout_angle)*20], [20,20], [-20,20], [-20,0] ]);
					}
				}
			}
			
			// flat bar at back of hook
			translate([-inside_diameter/2-thickness,0,0])
				cube(size=[thickness,bar_length,width]);

			// round corner on end of flat bar
			translate([-inside_diameter/2-thickness/2,bar_length,0])
				cylinder(r=thickness/2, h=width);

			// round corner on end of hook
			translate([-cos(cutout_angle)*(inside_diameter/2 + thickness/2), sin(cutout_angle)*(inside_diameter/2 + thickness/2),0])
				cylinder(r=thickness/2, h=width);

		}
	
		// screw hole
		translate([-inside_diameter/2-thickness-diff_fudge,bar_length+thickness/2-screw_hole_offset,width/2])
			rotate([0,90,0])
				cylinder(r=screw_hole/2,h=thickness+2*diff_fudge);

		if (countersink_enable == 1) {
			// countersink
			translate([-inside_diameter/2-countersink_height, bar_length+thickness/2-screw_hole_offset, width/2])
				rotate([0,90,0])
					cylinder(r1=screw_hole/2, r2=countersink_diameter/2+diff_fudge, h=countersink_height+diff_fudge);
		}
	}
}
