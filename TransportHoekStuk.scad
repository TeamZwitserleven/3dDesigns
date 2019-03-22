lengte = 50;
hoogte = 30;
dikte = 3;
boorDiameter = 7;
m6Diameter = 11.7;
m6Hoogte = 6;
zijkantRadius=m6Diameter;//4;
holderDikte=5;
boutLengte=36;
boutDiameter=6;
toonBouten=false;
holderX1 = (lengte/5.5);
holderX2 = lengte - holderX1;
holderY = hoogte/2;
fn=180;

module moerHouder(randFactor=1.6) {
    difference() {
        cylinder(d=m6Diameter*randFactor, h=m6Hoogte, $fn=fn);
        cylinder(d=m6Diameter, h=m6Hoogte, $fn=6);
    }
}

module zijkant() {
    gatX = hoogte*0.75;
    gatY = hoogte*0.75;
    union() {
        difference() {
            union() {
                translate([gatX,gatY,0]) cylinder(r=zijkantRadius*0.8, h=dikte, $fn=fn);
                //cube([hoogte,hoogte,dikte]);
                cube([hoogte-zijkantRadius,hoogte-zijkantRadius,dikte]);
                cube([hoogte,hoogte-zijkantRadius,dikte]);
                cube([hoogte-zijkantRadius,hoogte,dikte]);
            }
            translate([gatX,gatY,0]) cylinder(d=boorDiameter, h=dikte, center=false, $fn=fn);
        }
        if (toonBouten) {
            color([1,0.5,0]) translate([gatX,gatY,0]) cylinder(d=boutDiameter, h=boutLengte, center=false, $fn=fn);
        }
        translate([gatX,gatY,dikte]) moerHouder();
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
            translate([gatX,gatY,0]) cylinder(d=boorDiameter, h=dikte, center=false, $fn=fn);
        }
        if (toonBouten) {
            color([1,0.5,0]) translate([gatX,gatY,0]) cylinder(d=boutDiameter, h=boutLengte, center=false, $fn=fn);
        }
        translate([gatX,gatY,dikte]) moerHouder();
    }
}

module voorkant() {
    union() {
        translate([lengte,0,hoogte]) mirror([0,1,0]) rotate([90,180,0]) bovenkant();
        translate([holderX1,-holderDikte/2,holderY]) 
            rotate([-90,0,0]) cylinder(d=boorDiameter, h=holderDikte, center=true, $fn=fn);
        translate([holderX2,-holderDikte/2,holderY]) 
            rotate([-90,0,0]) cylinder(d=boorDiameter, h=holderDikte, center=true, $fn=fn);
    }
}

module boormal() {
    difference() {
        difference() {
            bovenkant();
            translate([0,0,dikte/2]) cube([lengte, hoogte, hoogte]);
        }
        translate([holderX1,holderY,holderDikte/2]) 
            cylinder(d=boorDiameter, h=holderDikte, center=true, $fn=fn);
        translate([holderX2,holderY,holderDikte/2]) 
            cylinder(d=boorDiameter, h=holderDikte, center=true, $fn=fn);
    }
}

module moerHouderAfdekplaat(randFactor=1.6) {
    d = (m6Diameter*randFactor)+0.5;
    difference() {
        cylinder(d=d*1.2, h=2, $fn=fn);
        cylinder(d=boorDiameter, h=m6Hoogte, $fn=fn);
        translate([0,0,1]) cylinder(d=d, h=1.5, $fn=fn);
        translate([-d, d/3-1, 0]) cube([d*2,d,d]);
    }
}

module all() {
    union() {
        zijkantLinks();
        bovenkant();
        voorkant();
        zijkantRechts();
    }
    translate([lengte+10,0,0]) boormal();
    translate([-m6Diameter*2,0,0]) moerHouderAfdekplaat();
}

moerHouderAfdekplaat();
//all();