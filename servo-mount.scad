lengte = 40;
breedte = 18;
plaatDikte = 3;
lengteVerhoging = 10;
gatDiameter = 8;
boorDiameter = 4;
borderRadius = 3;
fn=180;

servoHuisL = 22.9;
servoHuisB = 12.7;
servoHuisH = 8;
servoHuisWand = 3;
draadGatH = servoHuisH + 14;
servoWingL = 6;

module schroefGat() {
    union() {
        cylinder(d=boorDiameter, h=plaatDikte, $fn=fn);
        //cylinder(r1=boorDiameter*0.8, r2=boorDiameter/3, h=plaatDikte/2, $fn=fn);
    }
}

module roundedcube(l,b,h,r=borderRadius) {
    minkowski() {
        cube([l-2*r,b-2*r,h/2]);
        translate([r,r,0]) cylinder(r=r, h=h/2, $fn=fn);
    }
}

module plaat() {
    union() {
        roundedcube(lengte,breedte,plaatDikte,borderRadius);
        translate([(lengte - (servoHuisWand*2+servoHuisB))/2,0,plaatDikte]) {
            difference() {
                union() {
                    difference() {
                        cube([servoHuisWand*2+servoHuisB, servoHuisH, servoHuisWand+servoWingL+servoHuisL]);
                        translate([servoHuisWand, 0, servoWingL])
                            cube([servoHuisB, servoHuisH, servoHuisL]);
                        translate([servoHuisWand*2, 0, servoWingL+servoHuisWand])
                            cube([servoHuisB-servoHuisWand*2, servoHuisH, servoHuisL]);
                    }
                    translate([0,0,-plaatDikte])
                        roundedcube(servoHuisWand*2+servoHuisB, draadGatH+5, plaatDikte);
                }
                translate([servoHuisWand+servoHuisB/2, 0, servoWingL-3])
                    rotate([-90,0,0])
                        cylinder(r=1.2, h=servoHuisH, $fn=fn);
                translate([servoHuisWand+servoHuisB/2,draadGatH,-plaatDikte])
                    cylinder(r=0.7, h=plaatDikte+5, $fn=fn);
                }
        }
    }
}

module all() {
    difference() {
        plaat();
        translate([breedte/4,breedte/2,0]) schroefGat();
        translate([lengte-breedte/4,breedte/2,0]) schroefGat();
    }
}

rotate([90,0,0]) all();
//schroefGat();