// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 72;

difference() {
  union() {
    cylinder(1, 12, 12);
    cylinder(36, 10, 10);
  }
  translate([0, 0, -1]) cylinder(36 + 2, 9, 9);
}