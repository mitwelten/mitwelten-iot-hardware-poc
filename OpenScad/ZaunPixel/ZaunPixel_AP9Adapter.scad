// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=360;

s = 76;
r = (s/2) - 4;
ri = 12;
h = 33;
hi = 29;

difference() {
  union() {
    difference() {
      translate([0, 0, 0]) cylinder(h, r, r);
      translate([0, 0, 2]) cylinder(h, r - 2, r - 2);
    }
    difference() {
      translate([-8, -8, 2]) cube([12 + 4, 24 + 4, 15 + (h - hi)]);
      translate([-6, -6, 2]) cube([12, 24, 15 + (h - hi) + 1]);
    }
    translate([-77/2, -77/2, 0]) hull() {
      translate([6, 6, 0]) {
        translate([0, 0, 0]) cylinder(2, 6, 6);
        translate([77 - 2 * 6, 0]) cylinder(2, 6, 6);
        translate([77 - 2 * 6, 77 - 2 * 6]) cylinder(2, 6, 6);
        translate([0, 77 - 2 * 6]) cylinder(2, 6, 6);
      }
    }
  }
  translate([-r + 2 + ri, 0, 0]) cylinder(h, ri, ri);
  translate([-(-r + 2 + ri), 0, 0]) cylinder(h, ri, ri);
  cylinder(2, 6, 6);
  translate([-1.5, -77/2, 0]) cube([3, 77/2, 2]);
}