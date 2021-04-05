// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

r_hole = 68/2; // depends on tool
r_pole = 40/2;
r_220v = 9/2;
r_rj45 = 7/2;
d = 20; // depends on pvc
s = 0.9; // or 0.8?

linear_extrude(8) {
    difference() {
        circle(r_hole + 10);
        circle(r_pole + 2 * r_220v);
    }
}
linear_extrude(d) {
    difference() {
        circle(r_hole);
        circle(r_pole);
        rotate(0) translate([r_pole + r_220v, 0]) circle(r_220v);
        rotate(0) translate([r_pole - r_220v, - s * r_220v]) square([2 * r_220v, 2 * s * r_220v]);
        rotate(72) translate([r_pole + r_rj45, 0]) circle(r_rj45);
        rotate(72) translate([r_pole - r_rj45, - s * r_rj45]) square([2 * r_rj45, 2 * s * r_rj45]);
        rotate(2 * 72) translate([r_pole + r_rj45, 0]) circle(r_rj45);
        rotate(2 * 72) translate([r_pole - r_rj45, - s * r_rj45]) square([2 * r_rj45, 2 * s * r_rj45]);
        rotate(3 * 72) translate([r_pole + r_rj45, 0]) circle(r_rj45);
        rotate(3 * 72) translate([r_pole - r_rj45, - s * r_rj45]) square([2 * r_rj45, 2 * s * r_rj45]);
        rotate(4 * 72) translate([r_pole + r_rj45, 0]) circle(r_rj45);
        rotate(4 * 72) translate([r_pole - r_rj45, - s * r_rj45]) square([2 * r_rj45, 2 * s * r_rj45]);
    }
}