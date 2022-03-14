// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=36;

s = 76;
r = (s/2) - (1.5 + 4);
ri = 12;
h = 32;
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
//  translate([-r + 2 + ri, 0, 0]) cylinder(h, ri, ri);
//  translate([-(-r + 2 + ri), 0, 0]) cylinder(h, ri, ri);
  cylinder(2, 6, 6);
  translate([-1.5, 77/4, 0]) cube([3, 77/4, 2]);
//  translate([0, -77/4, 0]) cylinder(2, 6, 6);
  // board + adapter
  translate([-3.5 + 77/2, -51/2, 0]) cube([3.5, 51, 2]);
#  translate([-31 + 77/2, -12.5, 2]) cube([31, 51, 21]);
#  translate([-12 + 77/2, -12.5, 2 + 21]) cube([12, 51, 6]);
  // antenna
#  translate([17.5, -34.5, 2]) cube([21, 22, 10]);
#  translate([-31.5, -33.5, 2 + 1 + 4.5]) rotate([0, 90, 0]) cylinder(50, 4.5, 4.5);
  // battery
//  translate([-8 - 19.6/2, -77/2, h - 19.6/2 + 4]) rotate([0, 90, 90]) cylinder(77, 19.6/2, 19.6/2);
#  translate([-8 - 19.6/2, -77/2, h - 19.6/2 - .5]) rotate([0, 90, 90]) cylinder(77, 19.6/2, 19.6/2);
 translate([-8 - 19.6, -77/2, h - 19.6/2 - .5]) cube([19.6, 77, 19.6]);
}