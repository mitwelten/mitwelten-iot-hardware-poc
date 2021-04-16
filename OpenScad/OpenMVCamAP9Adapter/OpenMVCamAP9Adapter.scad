// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

layer = 0; // 0-3

difference() {
  hull() {
    translate([6, 6]) {
      square([77 - 2 * 6, 77 - 2 * 6]);
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
  color("red") {
    if (layer >= 0) {
      translate([44, 77 - 15 - 12]) {
        square([16, 12]);
      }
      translate([26, 77 - 40 - 3]) {
        square([3, 3]);
      }
    }
    if (layer >= 1) {
      translate([21, 77 - 45 - 3]) {
        square([35, 45]);
      }
      translate([25, 77 - 45 - 3 - 6]) {
        square([6, 6]);
      }
    }
    if (layer >= 2) {
      translate([(77 - 69) / 2, 3]) {
        square([69, 55 - 2 * 3]);
      }
    }
    if (layer >= 3) {
      translate([(77 - 69) / 2, 0]) {
        square([69, 55]);
      }
    }
  }
}