lengte = 80;
hoogte = 30;
dikte = 3;
boorDiameter = 7;
m6Diameter = 11;
m6Hoogte = 6;
zijkantRadius=10;

module moerHouder(randFactor=2) {
    difference() {
        cylinder(d=m6Diameter*randFactor, h=m6Hoogte, $fn=12);
        cylinder(d=m6Diameter, h=m6Hoogte, $fn=6);
    }
}

module zijkant() {
    gatX = hoogte*0.7;
    gatY = hoogte*0.7;
    union() {
        difference() {
            union() {
                translate([hoogte-zijkantRadius,hoogte-zijkantRadius,0]) cylinder(r=zijkantRadius, h=dikte);
                cube([hoogte-zijkantRadius,hoogte-zijkantRadius,dikte]);
                cube([hoogte,hoogte-zijkantRadius,dikte]);
                cube([hoogte-zijkantRadius,hoogte,dikte]);
            }
            translate([gatX,gatY,0]) cylinder(d=boorDiameter, h=dikte, center=false);
        }
        translate([gatX,gatY,dikte]) moerHouder(1.5);
    }
}

module zijkantLinks() {
    mirror() rotate([0,-90,0]) zijkant();
}

module zijkantRechts() {
    translate([lengte,0,0]) rotate([0,-90,0]) zijkant();
}

module bovenkant() {
    gatX = (lengte/2) - (boorDiameter/2);
    gatY = hoogte/2;
    union() {
        difference() {
            cube([lengte, hoogte, dikte]);
            translate([gatX,gatY,0]) cylinder(d=boorDiameter, h=dikte, center=false);
        }
        translate([gatX,gatY,dikte]) moerHouder();
    }
}

module voorkant() {
    translate([lengte,0,hoogte]) mirror([0,1,0]) rotate([90,180,0]) bovenkant();
}

module all() {
    union() {
        zijkantLinks();
        bovenkant();
        voorkant();
        zijkantRechts();
    }
}

//zijkant();
all();