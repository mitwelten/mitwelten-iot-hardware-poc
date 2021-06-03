// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;
helper = 1;

difference() {
    union() {
        translate([-14, 0, 0]) rotate([0, 90, 0]) cylinder(28, 10, 10);
        translate([-14, -8, 10]) rotate([0, 90, 0]) cube([20, 8, 28]);
        translate([-14, -(14 + 8), 24 + 5]) rotate([0, 90, 0]) cube([34 + 5, 14, 28]);
        translate([-14, -24.2, -11.25]) rotate([3, 0, 0]) cube([28, 26, 10]);
        translate([0, -10 + 2, 24 + 5]) rotate([90, 0, 0]) cylinder(14, 14, 14);
        if (helper == 1) {
            translate([- 10 -14, -22, -10]) rotate([0, 0, 0]) cube([28 + 20, -10 + 26, 10]);
        }
    }
    translate([0, 0, 24 + 5]) rotate([90, 0, 0]) cylinder(28, 10, 10);
    translate([-14 - 1, -18, 5]) rotate([0, 0, 0]) cube([28 + 2, 5, 2]);
    translate([-14 - 1, -(14 + 8) - 14, 24]) rotate([0, 90, 0]) cube([34 + 5, 14, 28 + 2]);
    translate([2.5, -23, -1]) rotate([0, 0, 90]) cube([34, 5, 2]);
    translate([2.5, -23, 15 + -1]) rotate([0, 0, 90]) cube([34, 5, 2]);
    if (helper == 1) {
          translate([-17, -15.5, -11]) cylinder(22, 2.5, 2.5);
          translate([+17, -15.5, -11]) cylinder(22, 2.5, 2.5);
          translate([0, -23 + 1 + 40, 0]) rotate([90, 0, 0]) cylinder(40, 2.5, 2.5);
    }
}