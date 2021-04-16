// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

layer = 0; // 0-1

//linear_extrude(2 * 4)
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
  translate([77 - 69, 77 - (77 - 44)]) {
    square([69, 77 - 44]);
  }
  if (layer > 0) {
    translate([77 - 58, 0]) {
      square([58, 44]);
    }
  }
}