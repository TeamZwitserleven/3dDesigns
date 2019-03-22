width = 58;
gripOuter = 50;
gripInner = 44;
gripThickness = 4;
gripSize = 20;
tableTopThickness = 20;
tableGripDepth = 30;
tableGripThinkness = 3;

module kopplaGrip() {
    w1 = (width - gripOuter)/2;
    w2 = (width - gripInner)/2;
    bp = tableGripThinkness;
    t = (gripThickness / 2;
    cube([width, gripSize, bp]);
    translate([0, 0, bp])
        cube([w1, gripSize, t]);
    translate([0, 0, bp+t])
        cube([w2, gripSize, t*0.9]);
    translate([width-w1, 0, bp])
        cube([w1, gripSize, t]);
    translate([width-w2, 0, bp+t])
        cube([w2, gripSize, t*0.9]);
}

module tableGrip() {
    size = (tableGripThinkness*2)+tableTopThickness;
    difference() {
        union() {
            cube([size, gripSize, tableGripThinkness]);
            translate([0,0,tableGripThinkness])
                cube([tableGripThinkness, gripSize, tableGripThinkness+tableGripDepth]);
            translate([tableTopThickness+tableGripThinkness,0,tableGripThinkness])
                cube([tableGripThinkness, gripSize, tableGripThinkness+tableGripDepth]);
        }
        translate([tableTopThickness+tableGripThinkness,gripSize/2,tableGripThinkness+(tableGripDepth/2)])
            rotate([0,90,0])
                cylinder(r=5/2, h=tableGripThinkness, $fn=32);
    }
}

module combinedGrip() {
    translate([-width,0,0])
        kopplaGrip();
    tableGrip();
}

rotate([90,0,0])
    combinedGrip();