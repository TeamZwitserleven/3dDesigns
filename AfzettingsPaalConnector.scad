paalDiamBuiten = 40;
paalDiamBinnen = 34;
height = 60;

balkH = 32;
balkD = 16;

fn=180;

module paalHouder() {
    union() {
        cylinder(d=paalDiamBuiten*2, h=2, $fn=3);
        translate([0,0,2]) {
            difference() {
                cylinder(d=paalDiamBuiten*2, h=height-2, $fn=3);
                cylinder(d=paalDiamBuiten, h=height-2);
            }
            difference() {
                cylinder(d1=paalDiamBinnen, d2=paalDiamBinnen-1, h=height-2);
                cylinder(d=paalDiamBinnen-5, h=height-2);
            }
        }
    }
}

module zijbalk() {
    w = 100;//paalDiamBuiten*2;
    wall = 4;
    e = paalDiamBuiten/(sqrt(3)/3);
    translate([-(paalDiamBuiten/2+(balkD+wall*2)),-(e/2+(w+wall-e)),0]) {
        difference() {
            cube([balkD+wall*2, w+wall, balkH+wall]);
            translate([wall,0,0]) 
                cube([balkD, w, balkH]);
        }
    }
}

module bodemKruis() {
    w = paalDiamBuiten * 2;
    h = 4;
    paalHouder();
}

bodemKruis();
zijbalk();
rotate([0,0,120])
    zijbalk();
rotate([0,0,240])
    zijbalk();
