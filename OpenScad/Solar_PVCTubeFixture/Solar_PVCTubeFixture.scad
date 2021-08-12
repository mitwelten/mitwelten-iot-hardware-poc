// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

di = 15.911;

difference() {
    union() {
        difference() {
            cylinder(h=32 + 16, r=32/2);
            translate([0, 0, -4]) cylinder(h=32, r=di/2);
        }
        translate([0, 16, 32 + 16]) rotate([90, 0, 0]) cylinder(h=32, r=32/2);
    }
    translate([0, 16 + 1, 32 + 16]) rotate([90, 0, 0]) cylinder(h=32 + 2, r=2);
    translate([-16, -16 + 8 - 2, 32]) cube([32, 4, 32]);
    translate([-16, -16 + 16 - 2, 32]) cube([32, 4, 32]);
    translate([-16, -16 + 24 - 2, 32]) cube([32, 4, 32]);
}