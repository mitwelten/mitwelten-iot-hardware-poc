$fn = 360;

r = 30;
d = 2 *r;

/*
difference() {
    linear_extrude(30 + 5) union() {
        difference() {
            union() {
                circle(r);
                translate([-d, 0]) square([d, r]);
            }
            circle(r-5);
            translate([-d, -d]) square([2 * d, d]);
        }
        translate([-d, -d]) square([r + 5, d]);
        translate([r - 5, -d]) square([5, d]);
    }
    translate([-30 - 15 + 5/2, 30 + 1, 15 + 2.5]) rotate([90, 0, 0]) cylinder(30 + 62, 10, 10);
}
*/

/*
// pole hole
translate([0, 0, 0]) rotate([90, 0, 0]) difference() {
    union() {
        cylinder(28, 14, 14);
        translate([0, -14, 0]) cube([14, 28, 28]);
    }
    translate([0, 0, -1]) cylinder(28 + 2, 10, 10);
}

// pot clamp
translate([14 + 16, 0, -14]) rotate([0, 0, 0]) difference() {
    union() {
        cylinder(28, 20, 20);
    }
    translate([0, 0, -1]) cylinder(28 + 2, 16, 16);
    translate([-28, -28, -1]) cube([2 * 28, 28, 28 + 2]);
}
*/

difference() {
    union() {
        translate([-14, 0, 0]) rotate([0, 90, 0]) cylinder(28, 10, 10);
        translate([-14, -8, 10]) rotate([0, 90, 0]) cube([20, 8, 28]);
        translate([-14, -(14 + 8), 24 + 5]) rotate([0, 90, 0]) cube([34 + 5, 14, 28]);
        translate([0, -10 + 2, 24 + 5]) rotate([90, 0, 0]) cylinder(14, 14, 14);
    }
    translate([0, 0, 24 + 5]) rotate([90, 0, 0]) cylinder(28, 10, 10);
    translate([2.5, -23, -1]) rotate([0, 0, 90]) cube([34, 5, 2]);
    translate([2.5, -23, 15 + -1]) rotate([0, 0, 90]) cube([34, 5, 2]);
}