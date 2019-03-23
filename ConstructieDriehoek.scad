include <cyl_head_bolt.scad>;
include <materials.scad>;

zijdeLen = 50;
gatOffset1 = 40;
gatOffset2 = 20;
height = 15;
thickness = 3;
d = 4.5;
$fn = 180;
m6Diameter = 11.7;
m6Hoogte = 6;
m4Diameter = m6Diameter / 6 * 4;
m4Hoogte = 4;
plaatDikte = 9;

module moerHouder(randFactor=1.6) {
    d=m4Diameter*randFactor;
    difference() {
        translate([-d/2,-(height)/2,-thickness])
            cube([d, height, thickness*2]);
        nutcatch_parallel("M4", l=thickness*2);
    }
}

module zijkant(m=1, mal=false) {
    offsetX1 = (m == 1) ? gatOffset1 : zijdeLen-gatOffset1;
    offsetX2 = (m == 1) ? gatOffset2 : zijdeLen-gatOffset2;
    offsetSteun = (m == 1) ? zijdeLen-thickness : 0;
    difference() {
        union() {
            cube([zijdeLen,thickness,height]);
            if (!mal) {
            translate([offsetX1,thickness,(height)/2])
                rotate([90,0,0])
                    moerHouder();
            translate([offsetX2,thickness,(height)/2])
                rotate([90,0,0])
                    moerHouder();
            translate([offsetSteun,0,0])
                cube([thickness,height*2/3,height]);
            }
        }
        translate([offsetX1,thickness*2,(height)/2])
            rotate([90,0,0])
                cylinder(d=d, h=thickness*2);
        translate([offsetX2,thickness*2,(height)/2])
            rotate([90,0,0])
                cylinder(d=d, h=thickness*2);
    }
}

module driehoek() {
    gatOffset = zijdeLen*0.35;
    difference() {
        intersection() {
            linear_extrude(height=thickness)
                polygon(points=[[0,0],[zijdeLen*1.2,0],[0,zijdeLen*1.2]], paths=[[0,1,2]],convexity=10);
            cube([zijdeLen,zijdeLen,thickness]);
        }
        translate([gatOffset,gatOffset,0])
            cylinder(d=zijdeLen*0.4, h=thickness*2);
    }
    zijkant();
    translate([0,zijdeLen,0])
        rotate([0,0,-90])
            zijkant(m=-1);
}

module boormal() {
    translate([-plaatDikte,0,0])
        cube([plaatDikte,thickness,height]);
    translate([-(plaatDikte+thickness),-plaatDikte,0])
        cube([thickness, plaatDikte+thickness, height]);

    zijkant(mal=true);
}

translate([-100,0,0]) 
    driehoek();
translate([0,0,thickness])
    rotate([-90,0,0])
        boormal();