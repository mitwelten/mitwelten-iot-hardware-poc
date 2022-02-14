// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

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
        translate([-24, 12 + (wi / 2), 12]) rotate([90, 0, 0]) cylinder(h=24, r=12);
    }
    hull() {
        translate([0, 0, -1]) cylinder(h + 2, r, r);
        translate([0, wi, -1]) cylinder(h + 2, r, r);
        translate([wi, wi, -1]) cylinder(h + 2, r, r);
        translate([wi, 0, -1]) cylinder(h + 2, r, r);
    }
    translate([-24 -12, -12 + (wi/2), -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + (wi/2) + 8, -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + (wi/2) + 16, -1]) cube([24, 4, 24 + 2]);
    translate([-24, -12 + (wi/2) + 1, 12]) rotate([90, 0, 0]) cylinder(h=24, r=4);
    translate([-24, wi + 1, 12]) rotate([90, 0, 0]) cylinder(h=(wi/2 - 12 + 1), r=4, $fn=6);
    translate([-24, wi + 1, 12]) rotate([90, 0, 0]) cylinder(h=81, r=2);
}