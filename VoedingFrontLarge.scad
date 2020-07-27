fn = 32;
inzetW = 160;
inzetH = 84;
inzetDikte = 5;
frontW = 178;
frontH = 102;
frontDikte = 3;

voltW = 45;
voltH = 26;

module front() {
    schroefD = 3;
    dx = (frontW - inzetW) / 2;
    dy = (frontH - inzetH) / 2;
    dz = (frontDikte);
    bd = 2;
    gatX = 5;
    gatY = 5;
    difference() {
        union() {
            cube([frontW, frontH, frontDikte]);
            translate([dx, dy, dz])
                difference() {
                    cube([inzetW, inzetH, inzetDikte]);
                    translate([bd,bd,0])
                        cube([inzetW-bd*2, inzetH-bd*2, inzetDikte]);
                }
        }
        union() {
            translate([gatX,gatY,0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([frontW / 2,gatY,0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([frontW-(gatX),gatY,0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([frontW-(gatX),(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([frontW / 2,(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([gatX,(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
        }
    }
}

module voltGat() {
    union() {
        cube([voltW, voltH, frontDikte]);
        translate([-1, -1, 1.5])
            cube([voltW+2, voltH+2, frontDikte-1.5]);
    }
}

module voedingPotmeterGat() {
    d = 9;
    cylinder(d=d, h=frontDikte, $fn=fn);
}

module all() {
    voltDist = 5;
    voltX = (frontW - ((voltDist*2) + (voltW * 3))) / 2;
    voltY = frontH - (voltH + ((frontH - inzetH) / 2) + (8));
    voedingPotmeterY = frontH / 3;
    difference() {
        union() {
            front();
        }
        translate([voltX, voltY, 0])
            voltGat();
        translate([(frontW - voltW) / 2, voltY, 0])
            voltGat();
        translate([frontW - (voltX + voltW), voltY, 0])
            voltGat();
        translate([frontW - (voltX + (voltW / 2)), voedingPotmeterY, 0])
            voedingPotmeterGat();
        translate([(frontW / 2), voedingPotmeterY, 0])
            voedingPotmeterGat();
    }
}

all();