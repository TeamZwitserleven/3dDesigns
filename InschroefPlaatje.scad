lengte = 40;
breedte = 18;
plaatDikte = 3;
verhoging = 3;
lengteVerhoging = 10;
gatDiameter = 8;
boorDiameter = 5;
borderRadius = 5;
fn=180;

module schroefGat() {
    union() {
        cylinder(d=boorDiameter, h=plaatDikte+verhoging, $fn=fn);
        cylinder(r1=boorDiameter*0.8, r2=boorDiameter/3, h=verhoging, $fn=fn);
    }
}

module plaat() {
    difference() {
        minkowski() {
            cube([lengte-2*borderRadius,breedte-2*borderRadius,(plaatDikte+verhoging)/2]);
            translate([borderRadius,borderRadius,0]) cylinder(r=borderRadius, h=(plaatDikte+verhoging)/2, $fn=fn);
        }
        translate([lengteVerhoging,0,plaatDikte]) cube([lengte-(lengteVerhoging*2),breedte,verhoging]);
        translate([lengte/2,breedte/2,0]) cylinder(d=gatDiameter, h=plaatDikte+verhoging, $fn=fn);
    }
}

module all() {
    difference() {
        plaat();
        translate([breedte/4,breedte/2,0]) schroefGat();
        translate([lengte-breedte/4,breedte/2,0]) schroefGat();
    }
}

all();
//schroefGat();