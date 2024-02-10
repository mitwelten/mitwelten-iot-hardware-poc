// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

module rounded_square(wx, wy, r, h) {
  hull() {
    translate([r, r]) {
      translate([0, 0]) {
        cylinder(h, r, r);
      }
      translate([wx - 2 * r, 0]) {
        cylinder(h, r, r);
      }
      translate([wx - 2 * r, wy - 2 * r]) {
        cylinder(h, r, r);
      }
      translate([0, wy - 2 * r]) {
        cylinder(h, r, r);
      }
    }
  }    
}

module base() {
    rounded_square(77, 77, 6, 3);
}

module feather() {
    translate([0, 0, 0]) cube([2.5, 41, 3]);
    translate([20, 0, 0]) cube([2.5, 31.5, 3]);
}

module led_ring() {
    difference() {
        cylinder(1, 30, 30);
        cylinder(1, 21.5, 21.5);
    }
}

module zip_tie() {
    cube([1.5, 3, 3]);
}

projection()
difference() {
    base();
    translate([(77 - 22.5) / 2, 6, 0]) feather();
    translate([77 / 2, 77, 0]) cylinder(3, 24.5, 24.5);
    translate([(77 + 22.5) / 2, 4, 0]) rounded_square(12, 51 - 7, 3, 3);
    translate([(77 - 60 - 3) / 2, (77 - 3) / 2, 0]) zip_tie();
    translate([(77 - 43) / 2, (77 - 3) / 2, 0]) zip_tie();
    translate([(77 + 60) / 2, (77 - 3) / 2, 0]) zip_tie();
    //translate([(77 + 40) / 2, (77 - 3) / 2, 0]) zip_tie();
}
//translate([77 / 2, 77 / 2, 4]) led_ring();
