// -------------------------------------------------------------------------
//
// OPIZ box
//
// Box for the Orange Pi Zero (OPiZ) with the Allwinner H2 chipset.
//
// -------------------------------------------------------------------------
//
// Copyright (c) 2018 by Marq Kole
//
// -------------------------------------------------------------------------
// Version: 1.0
// Date: 05-02-2018
// -------------------------------------------------------------------------

// -------------------------------------------------------------------------
// Board-specific sizes
// -------------------------------------------------------------------------

l_opizb             =  48.2;    // length of the OPiZ board
w_opizb             =  46.2;    // width of the OPiZ board
t_opizb             =   1.7;    // thickness of the OPiZ board

// -------------------------------------------------------------------------
// Box-specific sizes
// -------------------------------------------------------------------------

l_opizbox           =  53.8;    // length of the OPiZ box
w_opizbox           =  51.8;    // width of the OPiZ box

r_oc_box            =   3.0;    // outside corner radius
r_ic_box            =   6.0;    // inside corner radius (used for the riser
                                // only)
t_wall              =   1.5;    // thickness of the outside wall

t_bottom            =   1.5;    // thickness of the bottom plate
t_bottom_riser      =   1.5;//2.7;    // thickness of the riser on the bottom
                                // including the bottom plate
h_bottom            =   8.0;    // height of the bottom part of the box

t_top               = t_bottom; // thickness of the top plate

h_top               =  17.4;    // height of the top part of the box

d_bolt_hole         =   2.0;    // diameter of the bolt hole
d_bolt_head         =   2.2;    // diameter of the bolt head
h_cs_hole           =   0;    // depth of the countersunk hole

r_tab               =   8.0;    // radius of the tabs
t_tab               =   4.0;    // thickness of the tabs
d_screw             =   3.5;    // diameter of the screw hole in the tabs

// the cutout for the SD card is on the back (short) side of the bottom
// part of the box
w_sdc               =  12.7;    // width of the cutout for the SD card
h_sdc               =   3.4;    // height of the cutout for the SD card

e2e_sdc             =  15.5;    // distance of SD card cutout side to the
                                // edge of the box

// the cutout for the micro-USB port is on the back (short) side of the top
// part of the box
w_uusb              =   8.0;    // width of the cutout for the micro-USB
                                // port
h_uusb              =   3.6;    // height of the cutout for the micro-USB
                                // port

e2e_uusb            =   8.8;    // distance of micro-USB cutout side to the
                                // edge of the box

// the cutout for the type-A USB port is on front (short) side of the top
// part of the box
w_usba              =   6.2;    // width of the cutout for the USB type-A
                                // port
h_usba              =  15.6;    // height of the cutout for the USB type-A
                                // port

e2e_usba            =   8.8;    // distance of USB type-A cutout side to
                                // the edge of the box

// the cutout for the Ethernet port is on front (short) side of the top
// part of the box
w_ether             =  16.1;    // width of the cutout for the Ethernet
                                // port
h_ether             =  14.9;    // height of the cutout for the Ethernet
                                // port

d_pillar            =   4.6;    // depth of the pillar between the Ethernet
                                // and the USB type-A cutouts

t_xtrab             =   0.9;    // extra thickness for the OPiZ board in
                                // the top part

d_vent              =   1.5;    // diameter of the vent holes in the top
                                // plate
h2h_vent            =   5.0;    // hole-to-hole center distance of the
                                // vent holes in the top plate

d_antenna           =   5.0;    // diameter of the wifi antenna
h_ant_sleeve        =   6.0;    // height of the antenna sleeve

w_gpio = 36; // width of gpio connector

// -------------------------------------------------------------------------
// Derived box-specific sizes
// -------------------------------------------------------------------------

l_opizbox_c2c       = l_opizbox - 2*r_ic_box; // center-to-center distance
                                // between the bolt holes on the long side.
w_opizbox_c2c       = w_opizbox - 2*r_ic_box; // center-to-center distance
                                // between the bolt holes on the wide side.

w_pillar            = w_opizbox/2 - w_ether/2 - e2e_usba - w_usba; // width
                                // of the pillar between the Ethernet and
                                // the USB type-A cutouts

// -------------------------------------------------------------------------
// Selectors
// -------------------------------------------------------------------------

sel_screw_tabs      =   1;      // attach tabs with countersunk screw holes
                                // to the sides of the bottom part of the
                                // box.

// -------------------------------------------------------------------------
// Library modules
// -------------------------------------------------------------------------

// Fitting factors (needed by library modules)
$fn                 = 120;      // number of straight edges in a full circle
eps                 =   0.05;   // overlap distance to prevent non-manifold
                                // structures and modules
d_fit               =   0.15;   // fitting distance

// -------------------------------------------------------------------------

// The module _mix(*) returns the union of the object passed as argument
// and its mirror image. The argument object is mirrored in YZ-plane.

module _mix(
  v = [1, 0, 0] // mirror vector
) {
    children();
    mirror(v) children();
}

// The module _miy(*) returns the union of the object passed as argument
// and its mirror image. The argument object is mirrored in XZ-plane.

module _miy(
  v = [0, 1, 0] // mirror vector
) {
    children();
    mirror(v) children();
}

// -------------------------------------------------------------------------
// OPiZ box generic items
// -------------------------------------------------------------------------

module opiz_box_bottom_risers() {
    intersection() {
        _miy()
            _mix()
                union() {
                    translate([l_opizbox_c2c/2, w_opizbox_c2c/2, 0])
                        cylinder(r = r_ic_box, h = t_bottom_riser);
                    translate([l_opizbox_c2c/2 - r_ic_box, w_opizbox_c2c/2, 0])
                        cube([r_ic_box*2, r_ic_box, t_bottom_riser]);
                    translate([l_opizbox_c2c/2, w_opizbox_c2c/2 - r_ic_box, 0])
                        cube([r_ic_box, r_ic_box*2, t_bottom_riser]);
                    translate([l_opizbox_c2c/2 - r_oc_box, w_opizbox_c2c/2, 0])
                        cube([r_oc_box*3, r_ic_box, h_bottom]);
                    translate([l_opizbox_c2c/2, w_opizbox_c2c/2 - r_oc_box, 0])
                        cube([r_ic_box, r_oc_box*3, h_bottom]);
                    translate([l_opizbox_c2c/2, w_opizbox_c2c/2, 0])
                        cylinder(r = r_oc_box, h = h_bottom);
                } // union
        hull()
            _miy()
                _mix()
                    translate([l_opizbox/2 - r_oc_box, w_opizbox/2 - r_oc_box, 0])
                        cylinder(r = r_oc_box, h = h_bottom);
    } // difference
}

module opiz_screw_tabs() {
    difference() {
        translate([-r_tab, 0, t_tab/2])
            union() {
                //cube([2*r_tab, 6*r_tab, t_tab], center = true);
                //rotate([0, 0, 45])
                //    cube([sqrt(18)*r_tab, sqrt(18)*r_tab, t_tab], center = true);
//                rotate([0, 0, 45])
                    cube([sqrt(18)*r_tab, 2*r_tab, t_tab], center=true);
                translate([2*r_tab, 0, 0])
                    cylinder(r = r_tab, h = t_tab, center = true);
            } // union
        translate([r_tab, 0, t_tab/2])
            union() {
                _miy()
                    translate([0, 2*r_tab, 0])
                        cylinder(r = r_tab, h = t_tab + 2*eps, center = true);
                cylinder(r1 = 0, r2 = t_tab + eps, h = t_tab + 2*eps, center = true);
                cylinder(r = d_screw/2 + d_fit, h = t_tab + 2*eps, center = true);
                translate([-3*r_tab, 0, 0])
                    cube([4*r_tab, 6*r_tab + 2*eps, t_tab + 2*eps], center = true);
            } // union
    } // difference
} // module

module opiz_box_bottom() {
    difference() {
        union() {
            difference() {
                hull() {
                    _miy()
                        _mix()
                            translate([l_opizbox/2 - r_oc_box, w_opizbox/2 - r_oc_box, 0])
                                cylinder(r = r_oc_box, h = h_bottom);
                } // hull
                translate([0, 0, t_bottom])
                    hull() {
                        _miy()
                            _mix()
                                translate([l_opizbox/2 - r_oc_box, w_opizbox/2 - r_oc_box, 0])
                                    cylinder(r = r_oc_box - t_wall, h = h_bottom - t_bottom + eps);
                    } // hull
            } // difference
            opiz_box_bottom_risers();
            if (sel_screw_tabs == 1) {
                rotate([0, 0, 90])
                    union() {
                        translate([w_opizbox/2 - eps + 20, 0, 0])
                            opiz_screw_tabs();
                        translate([w_opizbox/2 - eps, -r_tab, 0])
                            cube([20 + eps, r_tab*2, t_tab]);
                        mirror() translate([w_opizbox/2 - eps, 0, 0])
                            opiz_screw_tabs();
                    }
            } // if
        } // union
        _miy()
            _mix()
                translate([l_opizbox_c2c/2, w_opizbox_c2c/2, -eps]) {
                    cylinder(r = d_bolt_hole/2 + d_fit, h = h_bottom + 2*eps);
                    cylinder(r = d_bolt_head/2 + d_fit, h = h_cs_hole + eps);
                } // translate
        translate([l_opizbox/2 - t_wall/2, w_opizbox/2 - e2e_sdc - w_sdc/2, h_bottom - h_sdc/2 + eps/2])
            cube([t_wall + 2*eps, w_sdc, h_sdc + eps], center = true);
        translate([0, 0, h_bottom - t_opizb/2 - d_fit/2 + eps/2])
            cube([l_opizb + 2*d_fit, w_opizb + 2*d_fit, t_opizb + d_fit + eps], center = true);
        translate([(-l_opizbox/2)+((l_opizbox-w_gpio)/2), w_opizbox/2-t_wall-1, h_bottom-2])
            cube([w_gpio, 3, 10]);
    } // difference
} // module

module opiz_box_top() {
    difference() {
        union() {
            difference() {
                hull() {
                    _miy()
                        _mix()
                            translate([l_opizbox/2 - r_oc_box, w_opizbox/2 - r_oc_box, 0])
                                cylinder(r = r_oc_box, h = h_top);
                } // hull
                translate([0, 0, t_top])
                    hull() {
                        _miy()
                            _mix()
                                translate([l_opizbox/2 - r_oc_box, w_opizbox/2 - r_oc_box, 0])
                                    cylinder(r = r_oc_box - t_wall, h = h_top - t_top + eps);
                    } // hull
            } // difference
            _miy()
                _mix()
                    translate([l_opizbox_c2c/2, w_opizbox_c2c/2, eps])
                        cylinder(r = r_oc_box, h = h_top - eps);
            translate([-(l_opizbox/2 - d_pillar/2), w_ether/2 + w_pillar/2, h_top/2])
                cube([d_pillar, w_pillar, h_top], center = true);
            cylinder(r = d_antenna/2 + t_wall, h = h_ant_sleeve);
        } // union
        _miy()
            _mix()
                translate([l_opizbox_c2c/2, w_opizbox_c2c/2, t_top])
                    cylinder(r = d_bolt_hole/2, h = h_top - t_top + eps);
        translate([l_opizbox/2 - t_wall/2, w_opizbox/2 - e2e_uusb - w_uusb/2, h_top - h_uusb/2 + eps/2])
            cube([t_wall + 2*eps, w_uusb, h_uusb + eps], center = true);
        translate([-(l_opizbox/2 - t_wall/2), w_opizbox/2 - e2e_usba - w_usba/2, h_top - h_usba/2 + eps/2])
            cube([t_wall + 2*eps, w_usba, h_usba + eps], center = true);
        translate([-(l_opizbox/2 - t_wall/2), 0, h_top - h_ether/2 + eps/2])
            cube([t_wall + 2*eps, w_ether, h_ether + eps], center = true);
        translate([0, 0, h_top - t_xtrab/2 + eps/2])
            cube([l_opizb + 2*d_fit, w_opizb + 2*d_fit, t_xtrab + eps], center = true);
        for (i = [-4:4], j = [-4:4])
            if (abs(i) + abs(j) < 8)
                translate([i*h2h_vent, j*h2h_vent, -eps])
                    cylinder(r = d_vent/2, h = t_top + 2*eps);
        translate([0, 0, -eps])
            cylinder(r = d_antenna/2 + d_fit, h = h_ant_sleeve + 2*eps);
    } // difference
}


// -------------------------------------------------------------------------
// Final objects
// -------------------------------------------------------------------------

//translate([0.6*l_opizb, 0, 0])
rotate([0,0,90])
    opiz_box_bottom();
//*translate([-0.6*l_opizb, 0, 0])
//    opiz_box_top();


// -------------------------------------------------------------------------
// Combined result
// -------------------------------------------------------------------------

// Comment out this section when generating the STL

/*translate([0, 2*w_opizb, 0]) {
    color("lightblue", 0.5)
        translate([0, 0, h_top + h_bottom])
            rotate([180, 0, 0])
                opiz_box_top();
    color("lightgrey", 0.5)
        translate([0, 0, 0])
            opiz_box_bottom();
}
*/