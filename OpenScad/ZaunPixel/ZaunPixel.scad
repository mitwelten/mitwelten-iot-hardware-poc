// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=360;

s = 76;
r = (s/2) - 4;
a = 14;
d = 1;
deg = 0;

//difference() {
//  translate([-s/2, -s/2, 0]) cube([s, s, 1]);
//  translate([0, 0, -1]) cylinder(3, r + d, r + d);
//}

rotate([0, 0, deg]) union() {
  color("blue") {
    translate([0, 0, -1]) cylinder(1, r + 2, r + 2);
    translate([0, 0, 0]) cylinder(1, r, r);
  }
  translate([5, 0, 0]) color("white") {
    translate([0, 0, 1]) linear_extrude(1) polygon([[0, 1.6*a], [1.6*a, 0], [0, -1.6*a]]);
    translate([-2*a, -a, 1]) cube([2*a, 2*a, 1]);
  }
}
