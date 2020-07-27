fn = 32;
inzetW = 84;
inzetH = 84;
inzetDikte = 5;
frontW = 102;
frontH = 102;
frontDikte = 3;

displayW = 71;
displayH = 24;
displayPcbW = 80;
displayPcbH = 35;

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
            translate([frontW-(gatX),gatY,0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([frontW-(gatX),(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
            translate([gatX,(frontH-(gatY)),0])
                cylinder(d=schroefD, h=dz, $fn=fn);
        }
    }
}

module displayGat() {
    cube([displayW, displayH, frontDikte]);
}

module displayMount() {
    schroefD = 2.5;
    x = schroefD + 2;
    y = schroefD + 2;
    z = 3;
    difference() {
        union() {
            translate([0,0,0])
                cube([x, y, z]);
            translate([displayPcbW-x,0,0])
                cube([x, y, z]);
            translate([displayPcbW-x,displayPcbH-y,0])
                cube([x, y, z]);
            translate([0,displayPcbH-y,0])
                cube([x, y, z]);
        }
        translate([x/2,y/2,0])
        union() {
            translate([0,0,0])
                cylinder(d=schroefD, h=z, $fn=fn);
            translate([displayPcbW-x,0,0])
                cylinder(d=schroefD, h=z, $fn=fn);
            translate([displayPcbW-x,displayPcbH-y,0])
                cylinder(d=schroefD, h=z, $fn=fn);
            translate([0,displayPcbH-y,0])
                cylinder(d=schroefD, h=z, $fn=fn);
        }
    }
}

module all() {
    displayDist = 5;
    displayGap = (frontH - (displayDist + (displayPcbH * 2))) / 2;
    displayHD = (displayPcbH - displayH) / 2;
    difference() {
        union() {
            front();
            translate([(frontW - displayPcbW) / 2, (displayGap), frontDikte])
                displayMount();
            translate([(frontW - displayPcbW) / 2, (frontH - displayPcbH) - (displayGap), frontDikte])
                displayMount();
        }
        translate([(frontW - displayW) / 2, (displayGap + displayHD), 0])
            displayGat();
        translate([(frontW - displayW) / 2, (frontH - displayH) - (displayGap + displayHD), 0])
            displayGat();
    }
}

all();