// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=72;

s = 76;
r = (s/2) - (1.5 + 4);
d = 0.2;

rotate([0, 0, deg]) {
  difference() {
    union() {
      // disk
      translate([0, 0, -1]) cylinder(1, r + 1.5, r + 1.5);
    
      // sphere
      translate([0, 0, 0]) sphere(r - d);
    }
    
    // box
    translate([-r, -r, -r - 1]) cube([2 * r, 2 * r, r]);
    
    // holes
    translate([0, 0, -2]) cylinder(r + 3, 1, 1);

    rotate([0, 0, 0]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 45]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 90]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 135]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 180]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 225]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 270]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 315]) translate([r/4, 0, -2]) cylinder(r + 3, 1, 1);

    rotate([0, 0, 0]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 45]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 90]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 135]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 180]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 225]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 270]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 315]) translate([r/2, 0, -2]) cylinder(r + 3, 1, 1);

    rotate([0, 0, 0]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 45]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 90]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 135]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 180]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 225]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 270]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
    rotate([0, 0, 315]) translate([3 * r/4, 0, -2]) cylinder(r + 3, 1, 1);
  }
}