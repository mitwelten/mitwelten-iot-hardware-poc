// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

d = 3;
h = 12;
r = 9;
wi = 100 - 2 * r;

difference() {
   union() {
       hull() {
           translate([4, 0, 0]) cylinder(24, 14, 14);
           translate([-12, -12, 0]) cube([12, 24, 24]);
        }
        translate([-24, -12, 0]) cube([12, 24, 24]);
        translate([-24, h, h]) rotate([90, 0, 0]) cylinder(h=24, r=12);
    }
    translate([4, 0, -1]) cylinder(24 + 2, 10, 10);
    translate([-24 -12, -12 - 4, -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12, -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + 8, -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + 16, -1]) cube([24, 4, 24 + 2]);
    translate([-24 -12, -12 + 24, -1]) cube([24, 4, 24 + 2]);
    translate([-24, wi/2 + 1, 12]) rotate([90, 0, 0]) cylinder(h=wi, r=2);
}