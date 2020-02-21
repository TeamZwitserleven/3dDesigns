include <roundedcube.scad>

wall = 3;
outerWidth = 25;
innerWidth = outerWidth - 2*wall;
outerHeight = 60;
innerHeight = outerHeight - 2*wall;

insertWidth = 15;
insertHeight = 50;
insertWall = 2;

fn = 36;
h = 20;
space = 0.5;

module eindStuk() {
    h = 7;
    endWidth = insertWidth;
    endHeight = insertHeight + 30;
    space = 0.1;
    wx = space+2*insertWall;
    wy = space+2*insertWall;
    difference() {
        union() {
            translate([0, 0, 2])
            cube([insertWidth, insertHeight, h-2]);
            roundedcube([endWidth, endHeight, h], false, 2, "all");
            translate([wx/2, wy/2, h]) {
                union() {
                    roundedcube([insertWidth-wx, insertHeight-wy, 20], false, 1, "zmax");
                    //cube([insertWidth-wx, insertHeight-wy, 10]);
                }
            }
        }
    }
}

module binnenGeleider() {
    dx = ((innerWidth-space) - (insertWidth)) / 2;
    dy = ((innerHeight-space) - (insertHeight)) / 2;
    difference() {
        union() {
            cube([innerWidth-space, innerHeight-space, h]);
        }
        translate([dx, dy, 3]) {
            cube([insertWidth, insertHeight, h-3]);
        }
    }
}

module tussenGeleider() {
    dx = ((innerWidth-space) - (insertWidth)) / 2;
    dy = ((innerHeight-space) - (insertHeight)) / 2;
    difference() {
        union() {
            cube([innerWidth-space, innerHeight-space, h]);
        }
        translate([dx, dy, 0]) {
            cube([insertWidth, insertHeight, h]);
        }
    }
}

module buitenGeleider() {
    h = 20;
    dx = (outerWidth - (insertWidth + space)) / 2;
    dy = (outerHeight - (insertHeight + space)) / 2;
    difference() {
        union() {
            cube([outerWidth, outerHeight, 3]);
            translate([wall+space/2, wall+space/2, 0])
                cube([innerWidth-space, innerHeight-space, h]);
        }
        translate([dx, dy, 0]) {
            cube([insertWidth+space, insertHeight+space, h]);
        }
    }
}

module afdekGoot() {
    h = 15;
    dx = (outerWidth - (insertWidth)) / 2;
    dh = (outerHeight - insertHeight) / 2;
    l = 100;
    difference() {
        union() {
            cube([outerWidth, l, h]);
        }
        translate([dx, 0, dh]) {
            cube([insertWidth, l, h-dh]);
        }
    }
}


rotate([0, 0, 90])
translate([-60, 0, 0])
    eindStuk();

rotate([0, 0, 90])
translate([-30, 0, 0])
    binnenGeleider();

rotate([0, 0, 90])
translate([0, 0, 0])
    tussenGeleider();
    
rotate([0, 0, 90])
translate([30, 0, 0])
    buitenGeleider();

rotate([0, 0, 90])
translate([60, 0, 0])
    afdekGoot();
