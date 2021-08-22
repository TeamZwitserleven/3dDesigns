include <roundedcube.scad>
include <cyl_head_bolt.scad>;
include <materials.scad>;

//w = 25;
//dikte = 15;

m6Diameter = 11.7;
m6s = 10; // See https://amesweb.info/Fasteners/Nut/Metric-Hex-Nut-Sizes-Dimensions-Chart.aspx
m6Hoogte = 5.5;
m4Diameter = m6Diameter / 6 * 4;
m4s = 7; // See https://amesweb.info/Fasteners/Nut/Metric-Hex-Nut-Sizes-Dimensions-Chart.aspx
m4Hoogte = 4;
fn=180;

wandDikte = 9;
//mountHandleDikte = 5;

module m4MoerGat(h) {
    rotate([0,0,0]) {
    union() {
        translate([0,0,-2])
            cylinder(d=5, h=h+4, $fn=fn);
        translate([0,0,m4Hoogte])
            nutcatch_parallel("M4", l=m4Hoogte+0.1);
        }
    }
}

module m6MoerGat(w, dikte, metMoer, d=7, dx=7) {
    rotate([0,90,0]) {
        union() {
            translate([0,0,-2])
                resize([dx,d,w+4]) cylinder(d=d, h=w+4, $fn=fn);
            if (metMoer) {
                translate([0,0,w*0.4]) {
                    union() {
                        cylinder(d=m6Diameter, h=m6Hoogte, $fn=6);
                        translate([-2-dikte/2,-m6s/2,0])
                            cube([2+dikte/2, m6s, m6Hoogte]);
                    }
                }
            }
        }
    }
}

module mountHandle(mountHandleDikte, handleH, dikte) {
    sx = mountHandleDikte;
    sy = handleH;
    difference() {
        cube([sx,sy,dikte]);
        translate([-2, sy/2, dikte/2])
        rotate([0,90,0])
            m4MoerGat(sx);
            //cylinder(d=5, h=sx+4, $fn=fn);
    }
}

module connector(w, h, dikte, handlesSide, handlesBottom, handleH, handleW1Offset, handleW2Offset) {
    m6Ofs = 12;
    m4XOfs = 5;
    m4YOfs = 5;
    handleW1=w-(wandDikte+handleW1Offset);
    handleW2=w-(wandDikte+handleW2Offset);
    anyHandles = handlesSide || handlesBottom;
    m6d = anyHandles ? 7 : 9;
    m6dx = anyHandles ? m6d : m6d+1;
    difference() {
        union() {
            cube([w, h, dikte]);
            if (handlesSide) {
                translate([w-handleW1-(wandDikte+handleW1Offset),h,0]) 
                    mountHandle(handleW1, handleH, dikte);
                translate([0,-handleH,0]) 
                    mountHandle(handleW2, handleH, dikte);
            }
            if (handlesBottom) {
                translate([0,h,-handleH]) 
                    rotate([90,0,0])
                        mountHandle(handleW1, handleH, dikte);
                translate([0,dikte,-handleH]) 
                //translate([1+dikte,dikte,1]) 
                    rotate([90,0,0])
                        mountHandle(handleW2, handleH, dikte);
            }
        }
        translate([0,m6Ofs,dikte/2]) m6MoerGat(w, dikte, handlesSide || handlesBottom, d=m6d, dx=m6dx);
        translate([0,h-m6Ofs,dikte/2]) m6MoerGat(w, dikte, handlesSide || handlesBottom, d=m6d, dx=m6dx);
        if (!handlesBottom) {
            translate([m4XOfs,m4YOfs,0]) m4MoerGat(w);
            translate([m4XOfs,h-m4YOfs,0]) m4MoerGat(w);
            translate([w/2+m4XOfs,h/2,0]) m4MoerGat(w);
        }
    }
}

module zaagmal() {
    z = 2;
    tunnelw = 60;
    tunnelh = 100;
    br = 20;
    padding = 10;
    union() {
        difference() {
            union() {
                translate([-br,-br,0])
                minkowski() {
                translate([br,br,0]) cylinder(r=br, h=z/2);
                translate([br,br,0]) cube([tunnelh-br*2, tunnelw-br*2, z/2]);
                }
                translate([br,0,0])
                cube([tunnelh-br, tunnelw, z]);
            }
            translate([padding+5,padding,0])
                cube([tunnelh-padding*2-5, tunnelw-padding*2,z]);
            // Center markers
            translate([0,h/2,0])
                cylinder(d=2, h=z, $fn=fn);
            translate([tunnelh,h/2,0])
                cylinder(d=2, h=z, $fn=fn);
        }
        // Plank
        translate([tunnelh,0,0])
            difference() {
                cube([wandDikte, h, z]);
                translate([0,3,0])
                    cube([wandDikte, h-6, z]);
            }
        // Connector
        translate([tunnelh+wandDikte,0,0])
            cube([w, h, z]);
    }

}

module stdPair(w=25, h=60, dikte=15, handlesBottom=false, handleH=20, handleW1Offset=0, handleW2Offset=0) {
    rotate([0,0,90]) {
        rotate([0,-90,0])
            connector(w, h, dikte, !handlesBottom, handlesBottom, handleH, handleW1Offset, handleW2Offset);
        translate([w*4,h,0]) 
            rotate([0,-90,180])
                connector(w, h, dikte, false, false, handleH, handleW1Offset, handleW2Offset);
    }
}

//translate([0,0,0]) stdPair(h=60);
translate([0,0,0]) stdPair(h=77);
translate([-120,0,0]) stdPair(h=100);
//translate([200,0,0]) stdPair(h=130);

//translate([0,0,0]) stdPair(h=60, handlesBottom=true, handleH=60);

//translate([0,0,0]) stdPair(w=40, h=77, handleW1Offset=18);
//translate([200,0,0]) stdPair(w=40, h=77, handleW2Offset=18);

//stdPair(130);
//zaagmal();