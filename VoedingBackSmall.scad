fn = 32;
inzetW = 84;
inzetH = 84;
inzetDikte = 5;
frontW = 102;
frontH = 102;
frontDikte = 3;
bd = 2;

powerW = 48;
powerH = 28;

fanW = 41;
fanH = 41;

module front() {
    schroefD = 3;
    dx = (frontW - inzetW) / 2;
    dy = (frontH - inzetH) / 2;
    dz = (frontDikte);
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
            translate([frontW-(gatX),gatY,0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([frontW-(gatX),(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([gatX,(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
        }
    }
}

module powerGat() {
    union() {
        cube([powerW, powerH, frontDikte]);
        translate([-1, -1, 1.5])
            cube([powerW+2, powerH+2, frontDikte-1.5]);
    }
}

module fanGat() {
    gatOfs = 4;
    gatD = 3;
    barD = 3;
    union() {
        difference() {
            translate([fanW/2, fanH/2, 0])
                cylinder(d=fanW, h=frontDikte, $fn=fn);
            translate([0, (fanH - barD) / 2, 0])
                cube([fanW, barD, frontDikte]);
            translate([(fanW - barD) / 2, 0, 0])
                cube([barD, fanH, frontDikte]);
        }
        translate([-1, -1, frontDikte])
            cube([fanW+2, fanH+2, inzetDikte]);
        translate([gatOfs, gatOfs, 0])
            cylinder(d=gatD, h=frontDikte, $fn=fn);
        translate([gatOfs, fanH - gatOfs, 0])
            cylinder(d=gatD, h=frontDikte, $fn=fn);
        translate([fanW - gatOfs, fanH - gatOfs, 0])
            cylinder(d=gatD, h=frontDikte, $fn=fn);
        translate([fanW - gatOfs, gatOfs, 0])
            cylinder(d=gatD, h=frontDikte, $fn=fn);
    }
}

module all() {
    fanY = frontH - (((frontH - inzetH) / 2) + bd + fanH + 2);
    difference() {
        union() {
            front();
        }
        translate([(frontW - powerW) / 2, ((frontH - inzetH) / 2) + bd + 2, 0])
            powerGat();
        translate([(frontW / 2) - fanW, fanY, 0])
            fanGat();
        translate([(frontW / 2) + 0, fanY, 0])
            fanGat();
    }
}

//fanGat();
all();