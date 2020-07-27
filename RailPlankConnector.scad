include <roundedcube.scad>
include <cyl_head_bolt.scad>;
include <materials.scad>;

w = 25;
h = 60;
dikte = 15;

m6Diameter = 11.7;
m6s = 10; // See https://amesweb.info/Fasteners/Nut/Metric-Hex-Nut-Sizes-Dimensions-Chart.aspx
m6Hoogte = 5.5;
m4Diameter = m6Diameter / 6 * 4;
m4s = 7; // See https://amesweb.info/Fasteners/Nut/Metric-Hex-Nut-Sizes-Dimensions-Chart.aspx
m4Hoogte = 4;
fn=180;

wandDikte = 9;
mountHandleDikte = 5;

module m4MoerGat() {
    rotate([0,0,0]) {
    union() {
        translate([0,0,-2])
            cylinder(d=5, h=w+4, $fn=fn);
        translate([0,0,m4Hoogte])
            nutcatch_parallel("M4", l=m4Hoogte+0.1);
        }
    }
}

module m6MoerGat(metMoer) {
    rotate([0,90,0]) {
        union() {
            translate([0,0,-2])
                cylinder(d=7, h=w+4, $fn=fn);
            if (metMoer) {
                translate([0,0,w*0.4]) {
                    union() {
                        cylinder(d=m6Diameter, h=m6Hoogte, $fn=6);
                        translate([-2-dikte/2,-m6s/2,0])
                            cube([2+dikte/2, m6s, m6Hoogte]);
                    }
                }
            }
        }
    }
}

module mountHandle() {
    sx = mountHandleDikte;
    sy = 20;
    difference() {
        cube([sx,sy,dikte]);
        translate([-2, sy/2, dikte/2])
        rotate([0,90,0])
            cylinder(d=5, h=sx+4, $fn=fn);
    }
}

module connector(handles) {
    m6Ofs = 12;
    m4XOfs = 5;
    m4YOfs = 5;
    difference() {
        union() {
            cube([w, h, dikte]);
            if (handles) {
                translate([w-mountHandleDikte-wandDikte,h,0]) mountHandle();
                translate([w-wandDikte,0,0]) rotate([0,0,180]) mountHandle();
            }
        }
        translate([0,m6Ofs,dikte/2]) m6MoerGat(handles);
        translate([0,h-m6Ofs,dikte/2]) m6MoerGat(handles);
        translate([m4XOfs,m4YOfs,0]) m4MoerGat();
        translate([m4XOfs,h-m4YOfs,0]) m4MoerGat();
        translate([w/2+m4XOfs,h/2,0]) m4MoerGat();
    }
}

//mountHandle();
rotate([0,0,90]) {
    rotate([0,-90,0])
    connector(true);
    translate([w*4,h,0]) 
    rotate([0,-90,180])
    connector(false);
}
//m6MoerGat(true);