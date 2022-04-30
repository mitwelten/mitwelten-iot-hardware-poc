$fn = 36;

e = .2;
e2 = 1;
z = 20;
h = 32;
d = 10; // deg

hull() {
  dx = e / tan(d/2);
  translate([dx, e, 0]) cylinder(z, e, e);
  translate([h - e, e, 0]) cylinder(z, e, e);
  dy = e / tan((180 - 90 - d)/2);
  translate([h - e2, h * tan(d) - dy, 0]) cylinder(z, e2, e2);
}
rotate([0, 0, d]) translate([6.48, 0, 0]) cube([10, 5, z]);
rotate([0, 0, d]) translate([6.48, 0, -2]) cube([26.02, 5, 2]);
translate([2.1, 0, -2]) cube([29.88, 6, 2]);

translate([2.1, 0, 0]) cube([10, 6, (3 * z) - 3]);

translate([0, 0, (2 * z) -3]) {
hull() {
  dx = e / tan(d/2);
  translate([dx, e, 0]) cylinder(z, e, e);
  translate([h - e, e, 0]) cylinder(z, e, e);
  dy = e / tan((180 - 90 - d)/2);
  translate([h - e2, h * tan(d) - dy, 0]) cylinder(z, e2, e2);
}
rotate([0, 0, d]) translate([6.48, 0, 0]) cube([10, 5, z]);
rotate([0, 0, d]) translate([6.48, 0, 20]) cube([26.02, 5, 2]);
translate([2.1, 0, 20]) cube([29.88, 6, 2]);
}