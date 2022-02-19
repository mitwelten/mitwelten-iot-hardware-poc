// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 36;

layer = 3; // 0-3
r = .1;

module layer3d(layer) {
difference() {
  hull() {
    translate([6, 6]) {
      translate([0, 0]) {
        circle(6);
      }
      translate([77 - 2 * 6, 0]) {
        circle(6);
      }
      translate([77 - 2 * 6, 77 - 2 * 6]) {
        circle(6);
      }
      translate([0, 77 - 2 * 6]) {
        circle(6);
      }
    }
  }
    if (layer >= 0) {
      translate([44, 77.5 - 15 - 12]) {
        square([16.5, 12]);
      }
      translate([26, 77 - 40 - 3]) {
        square([3, 3]);
      }
    }
    if (layer >= 1) {
      translate([20.5, 77 - 45 - 3]) {
        square([36, 45]);
      }
      translate([25 - 0.5, 77 - 45 - 3 - 6]) {
        square([7, 6]);
      }
      translate([20.5 + 36 - 5 - 8.5, 77 - 45 - 3 - 2.5]) {
        square([9, 2.5]);
      }
    }
    if (layer >= 2) {
      translate([(77 - 68) / 2, 0]) {
        square([68, 56]);
      }
    }
  }
}

difference() {
  union() {
    translate([0, 0, 0]) linear_extrude(4) layer3d(0);
    translate([0, 0, 4]) linear_extrude(8) layer3d(1);
    translate([0, 0, 12]) linear_extrude(8) layer3d(2);
  }
  translate([24, 12, -1]) cylinder(8, 10, 10);
  translate([24, 12, -1 + 8]) cylinder(4, 10, 8);
  translate([24, 12, -1 + 12]) cylinder(2, 8, 8);
  translate([77 - 24, 12, -1]) cylinder(8, 10, 10);
  translate([77 - 24, 12, -1 + 8]) cylinder(4, 10, 8);
  translate([77 - 24, 12, -1 + 12]) cylinder(2, 8, 8);
}