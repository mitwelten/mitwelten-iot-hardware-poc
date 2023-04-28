// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

h0 = 32;
d0 = 15.911;
r1 = 12; // 16
d1 = 2 * r1;

module finger() {
    difference() {
        union() {
            circle(r1);
            translate([0, -r1]) square([d1, d1]);
        }
        circle(2);
    }
}

module finger_holes() {
    translate([r1, r1]) square([4, d1]);
    translate([r1 + 8, r1]) square([4, d1]);
    translate([r1 + 16, r1]) square([4, d1]);
}

module corner() {
    difference() {
        square([11.5, 11.5]);
        circle(r=11.5);
    }
}

// fingers
translate([r1, 64]) {
    translate([0, 0]) finger();
    translate([0, 0 + d1 + 4]) finger();
    translate([0, 0 + 2 * (d1 + 4)]) finger();
}

// base
difference() {
    square([2 * d1, 2 * d1]);
    finger_holes();
}

wx = 112;
wy = 136;

// pane
translate([2 * d1 + 4, 0]) difference() {
    square([wx, wy]);
    translate([(wx - 2 * d1)/2, (wy - 2 * d1)/2]) {
        finger_holes();
    }
    // panel holes
    translate([7.4, 7.4]) circle(r=2);
    translate([wx - 7.4, 7.4]) circle(r=2);
    translate([wx - 7.4, wy - 7.4]) circle(r=2);
    translate([7.4, wy - 7.4]) circle(r=2);
    // cutout
    translate([0, wy / 2]) circle(r=(wx - 2 * d1)/2);
    translate([wx, wy / 2]) circle(r=(wx - 2 * d1)/2);
    translate([wx / 2, 0]) circle(r=(wx - 2 * d1)/2);
    translate([wx / 2, wy]) circle(r=(wx - 2 * d1)/2);
    // corners
    translate([wx - 11.5, wy - 11.5]) rotate([0, 0, 0]) corner();
    translate([11.5, wy - 11.5]) rotate([0, 0, 90]) corner();
    translate([11.5, 11.5]) rotate([0, 0, 180]) corner();
    translate([wx - 11.5, 11.5]) rotate([0, 0, 270]) corner();
}
