bw = 60; // Board width
bh = 94; // Board height
spdw = 53; // Small pin delta width (center to center)
spdh = 73; // Small pin delta height (center to center)
spoh = 3; // Small pin delta (in height direction) from board edge 
spow = (bw-spdw)/2; // Small pin offset Y from board edge 
h = 4; // Height of plate
ph = 25; // Pin height
pr = 4; // Large pin radius
pbr = pr*1.7; // Large pin base radius
pow = pbr/2; // Offset from board to  large pin center
poh = pbr/2; // Offset from board to  large pin center
spr = 2.6; // Small pin radius
sph = 12;//3; // Small pin height
xbs = 2; // Extra board size
beam = spr*2;
antd = 5; // antenne diameter
antl = 22; // antenna length

fmw = bw+xbs*2; // frame mount width
fmh = 154; // frame mount height
fmwofs = (fmw - bw) / 2 - xbs;
fmhofs = (fmh - bh) *0.40;
fmgap = 2;
fmgapofs = 2;

module pin_with_hole(posx, posy,goUp, ph=ph) {
  difference() {
    r = pbr;
    r1 = pr;
    r2 = r1*0.6;
    union() {
      translate([posx, posy, 0])
        cylinder(r=r, h, $fs=.3);
      if (goUp) {
        translate([posx, posy, h])
          cylinder(r=r1, ph, $fs=.3);
        translate([posx ,posy, ph+h], $fs=.3)
          cylinder(r=r2, h, $fs=.3);
        translate([posx ,posy, ph+h*2], $fs=.3)
          sphere(r=r2, $fs=.3);
      } else {
        translate([posx ,posy, h], $fs=.3)
          cylinder(r=r1, h*1.5, $fs=.3);        
        translate([posx ,posy, h*2.5], $fs=.3)
          sphere(r=r1, $fs=.3);
      }
    }
    // Create hole for upper pin to fit in
    translate([posx, posy, 0])
      cylinder(r=r2+0.2, h*2, $fs=.3);
  }
}

module small_pin(posx, posy) {
  difference() {
  translate([posx, posy, 0])
    cylinder(r=spr, h+sph, $fs=.3);
  translate([posx, posy, 0])
    cylinder(r=1.1, h+sph+5, $fs=.3);
  }
}

module frame() {
  translate([-xbs,-(xbs),0]) {
    translate([0,0,0])
      cube([beam+xbs, bh+xbs*2, h]);
    translate([bw+xbs*2-(beam+xbs),0,0])
      cube([beam+xbs, bh+xbs*2, h]);
    translate([0,0,0])
      cube([bw+xbs*2, beam+xbs, h]);
    translate([0,bh+xbs*2-(beam+xbs),0])
      cube([bw+xbs*2, beam+xbs, h]);
  }
}

module frameMountEdge(d, eh, gaph) {
  difference() {
    union() {
      cube([fmw, d, eh]);
      cube([fmw, d*2, h]);
    }
    translate([0,fmgapofs,0])
      cube([fmw, fmgap, gaph]);
    translate([fmw/4,0,h])
      cube(fmw/2,d*2,eh-h);
    translate([fmw/2, d*1.2, 0])
      cylinder(r=1.6, h, $fs=.3);
  }
}

module frameMount() {
  d = beam+xbs;
  gaph = 10;
  eh = gaph+3;
  translate([-(xbs+fmwofs),-(xbs+fmhofs),0]) {
    translate([0,d,0])
      cube([d, fmh-d*2, h]);
    translate([fmw-(d),d,0])
      cube([d, fmh-d*2, h]);
    translate([0,0,0])
      frameMountEdge(d, eh, gaph);
    translate([fmw,fmh,0])
      rotate([0,0,180])
      frameMountEdge(d, eh, gaph);
  }
}

module cluster() {
    rotate([0,0,-90]) {
        union() {
          difference() {
            union() {
              // Outside frame
              frame();
              // Frame mount
              frameMount();
              // Crossbar
              translate([-xbs,spoh+spdh-((beam+xbs)/2),0])
                cube([bw+xbs*2, beam+xbs, h]);
              // Small PCB pins
              small_pin(spow, spoh);
              small_pin(spow, spoh+spdh);
              small_pin(spow+spdw, spoh);
              small_pin(spow+spdw, spoh+spdh);
            }
          }
          // Antenna holder
          translate([-1*(xbs+h+antd), bw*0.7, 0])
            union() {
              translate([0,0,0])
                cube([h/2, antl, h*1.5]);
              translate([h/2,0,0])
                cube([antd, antl, h/3]);
              translate([h/2+antd,0,0])
                cube([h/2, antl, h*1.5]);
            }

        }
    }
}

cluster();
