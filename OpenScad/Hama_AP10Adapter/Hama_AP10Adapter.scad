// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=36;

module round_rect(w, h, r, d) {
  w2 = w - 2 * r;
  difference() {
    translate([r, r, 0]) hull() {
      translate([0, 0, 0]) cylinder(d, r, r);
      translate([w2, 0, 0]) cylinder(d, r, r);
      translate([0, w2, 0]) cylinder(d, r, r);
      translate([w2, w2, 0]) cylinder(d, r, r);
    }    
  }
}

module base() {
  // box size
  w = 94.9; // ABB IP65
  //w = 94.7; //w = 94.9; // ABB IP55
  z = 3;
  e = 5;
  difference() {
    round_rect(w, w, e, z);
/*
    // ABB IP55 corner cutouts >>
    translate([0, 0, 0]) cube([8, 8, z]);
    translate([w2 + 2, 0, 0]) cube([8, 8, z]);
    translate([w2 + 2, w2 + 2, 0]) cube([8, 8, z]);
    translate([0, w2 + 2, 0]) cube([8, 8, z]);
    // <<
*/

    // screw holes
    translate([w/2 - 67/2, w - 5, -1]) cylinder(z + 2, 1, 1);
    //translate([w/2, w - 5, -1]) cylinder(z + 2, 1, 1);
    translate([w/2 + 67/2, w - 5, -1]) cylinder(z + 2, 1, 1);
    translate([w/2 - 67/2, 5, -1]) cylinder(z + 2, 1, 1);
    //translate([w/2, 5, -1]) cylinder(z + 2, 1, 1);
    translate([w/2 + 67/2, 5, -1]) cylinder(z + 2, 1, 1);
  }
}

module boombox_back() {
    round_rect(78.5, 78.5, 17, 3);    
}

module back_adapter() {
  difference() {
    base();
    x = (94.9 - 78.5) / 2;
    translate([x, x, 0]) boombox_back();
  }
}

module cover() {
    round_rect(104.5, 104.5, 6, 3);
}

module boombox_front() {
    round_rect(80, 80, 17, 3);    
}

module cover_adapter() {
  difference() {
    cover();
    x = (104.5 - 80) / 2;
    translate([x, x, 0]) boombox_front();
  }    
}

projection() cover_adapter();
projection() translate([110, 0, 0]) back_adapter();
