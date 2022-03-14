// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

d = 3;
h = 24;
r = 7.5;
w = 81;
wi = w - 2 * r;

module overhang(a, w) {
  s = sqrt(2);
  translate([-a, 0, 0]) difference() {
    cube([a, w, a]);
    translate([0, -0.01, a]) rotate([0, 45, 0]) cube([s * a, 1.02 * w, a]);
  }
}

difference() {
    hull() {
        translate([0, 0, 0]) cylinder(h, r + d, r + d);
        translate([0, wi, 0]) cylinder(h, r + d, r + d);
        translate([wi, wi, 0]) cylinder(h, r + d, r + d);
        translate([wi, 0, 0]) cylinder(h, r + d, r + d);
        translate([-r - 8,  0, 0]) cube([8, 10, h/2]);
        translate([-r + 81,  0, 0]) cube([8, 10, h/2]);
    }
    hull() {
        translate([0, 0, -1]) cylinder(h + 2, r, r);
        translate([0, wi, -1]) cylinder(h + 2, r, r);
        translate([wi, wi, -1]) cylinder(h + 2, r, r);
        translate([wi, 0, -1]) cylinder(h + 2, r, r);
    }
    // zip tie holes
    translate([-r -5, 2.5, -1]) cube([2, 5, h + 2]);
    translate([-r -10 - 5 + 4, 0, 12]) cube([10, 10, 5.201]);
    translate([-r - 1, 0, 12 + 5.2]) overhang(6, 10);

    translate([-r + 3 + 81, 2.5, -1]) cube([2, 5, h + 2]);
    translate([-r + 1 + 81, 0, 12]) cube([10, 10, 5.201]);
    translate([-r + 1 + 81, 10, 12 + 5.2]) rotate([0, 0, 180]) overhang(6, 10);
}