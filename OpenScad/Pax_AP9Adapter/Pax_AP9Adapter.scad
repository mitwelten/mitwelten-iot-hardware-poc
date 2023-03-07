ant_w = 12;
bat_w = 21.5;
box_w = 77;
box_z = 35;
box_r = 6;
mat_z = 3;

module base() { // TODO: cut away
  e = box_r;
  w2 = box_w - 2 * e;
  difference() {
    translate([e, e, 0]) hull() {
      translate([0, 0, 0]) cylinder(mat_z, e, e);
      translate([w2, 0, 0]) cylinder(mat_z, e, e);
      translate([0, w2, 0]) cylinder(mat_z, e, e);
      translate([w2, w2, 0]) cylinder(mat_z, e, e);
    }
  }
}

module wall() { // TODO: add fingers
  difference() {
    cube([box_w, box_z - mat_z, mat_z]);
    translate([box_w - ant_w, 0, -1]) cube([ant_w, ant_w, mat_z + 2]);
  }  
}

module bank() { // TODO: add fingers, round off
  difference() {
    cube([box_w - ant_w, bat_w, mat_z]);
    difference() {
      cube([box_r, box_r, mat_z]);
      translate([box_r, box_r, 0]) cylinder(mat_z, box_r, box_r);
    }
  }
}

module rest() { // TODO: add fingers
  cube([3 * mat_z, bat_w, mat_z]);    
}

//!projection()
base();
translate([0, bat_w + mat_z, mat_z]) rotate([90, 0, 0]) wall();
translate([3 * mat_z, 0, mat_z]) rotate([0, -90, 0]) rest();
translate([(box_w - ant_w) - (3 - 1) * mat_z, 0, mat_z]) rotate([0, -90, 0]) rest();
translate([0, 0, 4 * mat_z]) bank();
