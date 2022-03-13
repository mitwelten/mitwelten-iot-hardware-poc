// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=360;

s = 76;
r = (s/2) - (1.5 + 4);
a = 13.8;
d = 0.2;
deg = 0;

// cover
difference() {
  translate([-s/2, -s/2, 0]) cube([s, s, 1.5]);
  translate([0, 0, -1]) cylinder(3, r + d, r + d);
}

rotate([0, 0, deg]) {
  difference() {
    union() {
      // disk
      color("orange") {
        translate([0, 0, -1]) cylinder(1, r + 1.5, r + 1.5);
        translate([0, 0, 0]) cylinder(1.5, r, r);
      }
      // arrow
      translate([5, 0, 0]) color("black") {
        translate([0, 0, 1.5]) linear_extrude(1) polygon([[0, 1.6*a], [1.6*a, 0], [0, -1.6*a]]);
        translate([-2*a, -a, 1.5]) cube([2*a, 2*a, 1]);
      }
    }
    // servo spindle hole
    translate([0, 0, -1.1]) cylinder(3.1, 1.9, 1.9, $fn = 16);
  }
}