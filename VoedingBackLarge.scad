fn = 32;
inzetW = 160;
inzetH = 84;
inzetDikte = 5;
frontW = 178;
frontH = 102;
frontDikte = 3;
bd = 2;

netwerkW = 37;
netwerkH = 25;

connectorW = 41.5;
connectorH = 8.5;
connectorZ = 10;

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

module netwerkGat() {
    w = 16;
    h = 14;
    gatDist = 27.5;
    gatOfs = 10;
    gatD = 5;
    union() {
        cube([netwerkW, netwerkH, 0.1]);
        translate([(netwerkW-w)/2, netwerkH/2, 0]) {
            translate([0,-gatOfs,0])
                cube([w, h, frontDikte]);
            translate([w/2 - gatDist/2, 0, 0])
                cylinder(d=gatD, h=frontDikte, $fn=fn);
            translate([w/2 + gatDist/2, 0, 0])
                cylinder(d=gatD, h=frontDikte, $fn=fn);
        }
    }
}

module baanConnectorGat() {
    cube([connectorW, connectorH, connectorZ]);
}

module baanConnectorMount() {
    d = 4;
    translate([-d,-d,0])
        cube([connectorW+d*2, connectorH+d*2, connectorZ]);
}

module all() {
    netwerkX1 = ((frontW - inzetW) / 2) + bd + 1;
    netwerkX2 = netwerkX1 + netwerkH + 2;
    netwerkY = ((frontH - inzetH) / 2) + bd + 1;
    connectorX = 3*(frontW / 4) - (connectorW/2);
    connectorY = ((frontH - inzetH) / 2) + bd + 1 + 10;
    difference() {
        union() {
            front();
            translate([connectorX, connectorY, 0])
                baanConnectorMount();
        }
        translate([netwerkX1, netwerkY + netwerkW, 0])
            rotate([0,0,-90])
                netwerkGat();
        translate([netwerkX2, netwerkY + netwerkW, 0])
            rotate([0,0,-90])
                netwerkGat();
        translate([connectorX, connectorY, 0])
            baanConnectorGat();
    }
}

//netwerkGat();
all();