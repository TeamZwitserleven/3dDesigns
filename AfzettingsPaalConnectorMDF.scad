include <cyl_head_bolt.scad>;
include <materials.scad>;

paalDiamBuiten = 40.5;
paalDiamBinnen = 34-0.5;
height = 60;

balkH = 32;
balkD = 16;

mdfThickness = 12;
nutHeight = 20;
threadOuterRad = (paalDiamBuiten)/2+10;
threadLead = 4;

fn=180;

module paalHouder(h, tl, voetD) {
    union() {
        cylinder(d=voetD, h=3, $fn=8);
        translate([0,0,3]) {
            difference() {
                union() {
                    cylinder(d=paalDiamBuiten+7, h=h-3);
                    thread(orad=threadOuterRad, tl=tl, p=threadLead);
                }
                cylinder(d=paalDiamBuiten, h=h-3);
            }
            difference() {
                cylinder(d1=paalDiamBinnen, d2=paalDiamBinnen-1, h=(h-3)/2);
                cylinder(d=paalDiamBinnen-5, h=(h-3)/2);
            }
        }
    }
}

module voet() {
    difference() {
        paalHouder(h=height, tl=nutHeight+mdfThickness, voetD=paalDiamBuiten*2);
        translate([0,paalDiamBuiten,height-10])
            rotate([90,0,0])
                cylinder(d=6, h=paalDiamBuiten*2);
    }
}

module moer() {
    lead = threadLead;
    orad = threadOuterRad+0.5;
    irad = orad - lead;
    voetD = paalDiamBuiten*2;

    //e = _calc_HexInscToSubscRadius(nutkey/2);
	translate([0,0,nutHeight/2]) {
		difference() {
            union() {
            	translate([0,0,-nutHeight/2])
                    cylinder(d=voetD, h=3, $fn=8);
                cylinder(d=threadOuterRad*2+10, h=nutHeight, $fn=8, center=true);
            }
			cylinder(r=irad, h=nutHeight+0.1, center=true);
            union() {
				translate([0,0,-nutHeight/2]) thread(orad, nutHeight, lead);
				translate([0,0,-nutHeight/2]) cylinder(r1=orad, r2=irad, h=lead, center=true);
				translate([0,0,nutHeight/2]) cylinder(r2=orad, r1=irad, h=lead, center=true);
			}
		}
    }

   /* difference() {
        cylinder(d=threadOuterRad*2+10, h=nutHeight);
        thread(orad=threadOuterRad, tl=nutHeight, p=threadLead);
    }*/
}

translate([-100,0,0])
    paalHouder(h=20, tl=0, voetD=paalDiamBuiten+10);
translate([100,0,0])
    moer();
voet();
