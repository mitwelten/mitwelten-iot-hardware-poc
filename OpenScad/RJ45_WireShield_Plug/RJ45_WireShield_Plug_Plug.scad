// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

d = 18;
d2 = 6;
difference() {
    union() {
        cylinder(1.5 * d, d/2, d/2);
 #       cylinder(0.2 * d, 1.2 * d/2, 1.2 * d/2);
    }
    translate([d/2-d2/2, 0, -1]) #cylinder(1.5 * d + 2, d2/2, d2/2);
    translate([d/2-d2/2, -d2/2, -1]) cube([d2, d2, 1.5 * d + 2]);
}