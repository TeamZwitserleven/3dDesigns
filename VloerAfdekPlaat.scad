gatDiameter = 18;
plaatDiameter = gatDiameter*2;
kabelDiameter = 6.5;
gatHoogte = 20;
plaatHoogte = 2;
nudgeDiameter = 5;
nudgeOffset = plaatDiameter/2 - nudgeDiameter;
fn = 36;

module plaat() {
    difference() {
        union() {
            cylinder(d=plaatDiameter, h=plaatHoogte, $fn=fn);
            translate([0,0,-gatHoogte]) {
                cylinder(d=gatDiameter, h=gatHoogte, $fn=fn);
                sphere(d=gatDiameter, $fn=fn);
            }
        }
        translate([0,0,-gatHoogte*2]) 
            cylinder(d=kabelDiameter, h=plaatHoogte*2+gatHoogte*2+1, $fn=fn);
    }
}

module nudge() {
/*    translate([-nudgeDiameter/2,-nudgeDiameter/2,0])
        cube([nudgeDiameter,nudgeDiameter,plaatHoogte]);*/
    cylinder(d=nudgeDiameter, h=plaatHoogte, $fn=6);
}

module halvePlaat() {
    difference() {
        union() {
            intersection() {
                plaat();
                translate([-plaatDiameter/2,0,-gatHoogte*2]) 
                    cube([plaatDiameter, plaatDiameter, plaatHoogte*2+gatHoogte*2+1]);
            }
            translate([nudgeOffset,0,0])
                nudge();
        }
        translate([-nudgeOffset,0,0])
            nudge();
    }
}

module all() {
    rotate([180,0,0])
    translate([0,0,-plaatHoogte]) {
        translate([0,0.5,0]) 
            halvePlaat();
        rotate([0,0,180])
            halvePlaat();
    }
}

all();