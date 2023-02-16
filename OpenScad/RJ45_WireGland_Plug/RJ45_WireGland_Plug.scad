// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 72;

d_rj45 = 6.4; //6;
r = d_rj45 / 2;
dz = -2; //0;

difference() {
  union() {
    cylinder(2, 11, 11);
    cylinder(19.4 + dz, 9, 9);
    translate([0, 0, 19.4 + dz]) sphere(9);
  }
  # translate([0, 0, -5]) cylinder(40, r, r);
  # translate([-6, -4.5, 10 + dz]) cube([12, 9, 20]);
   translate([-12, -12, 22 + dz]) cube([24, 24, 10]);
   translate([0, -12, -1]) cube([12, 24, 32]);
}