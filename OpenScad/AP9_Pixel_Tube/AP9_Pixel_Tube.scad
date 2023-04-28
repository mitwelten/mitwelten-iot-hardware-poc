// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 144;

difference() {
  union() {
    cylinder(1, 26 + 2, 26 + 2);
    translate([0, 0, 2]) cylinder(1, 26.5, 26.5);
    translate([0, 0, 2]) sphere(26);
  }
  translate([0, 0, 3]) sphere(25);
  translate([-26, -26, 8]) cube([52, 52, 26]);
  translate([-26, -26, -26]) cube([52, 52, 26]);
}