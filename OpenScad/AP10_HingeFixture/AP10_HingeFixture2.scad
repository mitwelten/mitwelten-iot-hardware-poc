// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

d = 3;
h = 12; // // 24 // 30?
r = 9;
wi = 100 - 2 * r;

difference() {
    hull() {
        translate([0, 0, 0]) cylinder(h, r + d, r + d);
        translate([0, wi, 0]) cylinder(h, r + d, r + d);
        translate([wi, wi, 0]) cylinder(h, r + d, r + d);
        translate([wi, 0, 0]) cylinder(h, r + d, r + d);
        translate([-24, 12 + (wi / 2), 12]) rotate([90, 0, 0]) cylinder(h=24, r=12);
        translate([-12, 15, 15]) rotate([0, 90, 0]) cylinder(5, 15, 15);
        translate([-12, wi - 15, 15]) rotate([0, 90, 0]) cylinder(5, 15, 15);
    }
   # hull() {
        translate([0, 0, -1]) cylinder(20 + h + 2, r, r);
        translate([0, wi, -1]) cylinder(20 + h + 2, r, r);
        translate([wi, wi, -1]) cylinder(20 + h + 2, r, r);
        translate([wi, 0, -1]) cylinder(20 + h + 2, r, r);
    }
    translate([-24 -12, -12 + (wi/2), -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + (wi/2) + 8, -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + (wi/2) + 16, -1]) cube([24, 4, 24 + 2]);
    translate([-24, -12 + (wi/2) - 4, 12]) rotate([90, 0, 0]) cylinder(h=24, r=4);
    translate([-24, wi + 1, 12]) rotate([90, 0, 0]) cylinder(h=(wi/2 - 12 + 1), r=4.1, $fn=6);
    translate([-24, wi + 1, 12]) rotate([90, 0, 0]) cylinder(h=81, r=2);
#    translate([-40, 13, 15]) rotate([0, 90, 0]) cylinder(60, 10, 10);
#    translate([-40, wi - 13, 15]) rotate([0, 90, 0]) cylinder(60, 10, 10);
}