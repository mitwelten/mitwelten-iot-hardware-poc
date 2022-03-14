// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 36;

d = 3;
h = 24;
r = 7.5;
w = 81;
wi = w - 2 * r;

difference() {
    hull() {
        translate([0, 0, 0]) cylinder(h, r + d, r + d);
        translate([0, wi, 0]) cylinder(h, r + d, r + d);
        translate([wi, wi, 0]) cylinder(h, r + d, r + d);
        translate([wi, 0, 0]) cylinder(h, r + d, r + d);
        translate([-16, 12 + (wi / 2), 8]) rotate([90, 0, 0]) cylinder(h=24, r=8);
    }
    hull() {
        translate([0, 0, -1]) cylinder(h + 2, r, r);
        translate([0, wi, -1]) cylinder(h + 2, r, r);
        translate([wi, wi, -1]) cylinder(h + 2, r, r);
        translate([wi, 0, -1]) cylinder(h + 2, r, r);
    }
    translate([-r - 12, -r, 4 + 1.5]) cube([5, 81, 2]);
}