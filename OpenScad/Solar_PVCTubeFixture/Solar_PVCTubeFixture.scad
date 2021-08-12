// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

h0 = 32;
d0 = 15.911;
r1 = 12; // 16
d1 = 2 * r1;

difference() {
    union() {
        difference() {
            cylinder(h=h0 + 16, r=r1);
            translate([0, 0, -4]) cylinder(h=32, r=d0/2);
        }
        translate([0, r1, h0 + r1]) rotate([90, 0, 0]) cylinder(h=d1, r=r1);
    }
    translate([0, r1 + 1, h0 + r1]) rotate([90, 0, 0]) cylinder(h=d1 + 2, r=2);
    translate([-r1, -r1 + 0, h0]) cube([d1, 4, d1]);
    translate([-r1, -r1 + 8, h0]) cube([d1, 4, d1]);
    translate([-r1, -r1 + 16, h0]) cube([d1, 4, d1]);
    translate([-r1, -r1 + 24, h0]) cube([d1, 4, d1]);
}