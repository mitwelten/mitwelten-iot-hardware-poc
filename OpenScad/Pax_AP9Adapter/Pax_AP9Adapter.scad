ant_w = 12;
bat_w = 21.5;
box_w = 77;
box_z = 34;
box_r = 6;
mat_z = 2.8;//3;

/*
module base() {
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
*/

module base() {
  union() {
    difference() {
      union() {
        cube([box_w - ant_w, bat_w + 3 * mat_z, mat_z]);
        translate([box_w - ant_w - 4 * mat_z, 0, 0]) cube([4 * mat_z, box_w, mat_z]);
      }    
      translate([2 * mat_z, (bat_w - 3 * mat_z) / 2, 0]) cube([mat_z, 3 * mat_z, mat_z]);
      translate([(box_w - ant_w) - (3) * mat_z, (bat_w - 3 * mat_z) / 2, 0]) cube([mat_z, 3 * mat_z, mat_z]);
      difference() {
        cube([box_r, box_r, mat_z]);
        translate([box_r, box_r, 0]) cylinder(mat_z, box_r, box_r);
      }
      translate([3 * mat_z, bat_w, 0]) cube([3 * mat_z, mat_z, mat_z]);
      translate([box_w - ant_w - (1 + 1) * 3 * mat_z, bat_w, 0]) cube([3 * mat_z, mat_z, mat_z]);
    }
  }
}

module wall() {
  union() {
    difference() {
      cube([box_w, box_z - mat_z, mat_z]);
      translate([box_w - ant_w, 0, -1]) cube([ant_w, ant_w - mat_z, mat_z + 2]);
//      translate([2 * mat_z, mat_z, 0]) cube([mat_z, mat_z, mat_z]);
//      translate([(box_w - ant_w) - (3) * mat_z, mat_z, 0]) cube([mat_z, mat_z, mat_z]);
      translate([3 * mat_z, 2 * mat_z, 0]) cube([3 * mat_z, mat_z, mat_z]);
      translate([box_w - ant_w - (1 + 1) * 3 * mat_z, 2 * mat_z, 0]) cube([3 * mat_z, mat_z, mat_z]);
      translate([0, box_z - 3 * mat_z, 0]) cube([mat_z, 2 * mat_z, mat_z]);
      translate([box_w - mat_z, box_z - 3 * mat_z, 0]) cube([mat_z, 2 * mat_z, mat_z]);
    }
    translate([3 * mat_z, -mat_z, 0]) cube([3 * mat_z, mat_z, mat_z]);
    translate([box_w - ant_w - (1 + 1) * 3 * mat_z, -mat_z, 0]) cube([3 * mat_z, mat_z, mat_z]);
  }
}

module bank() {
  union() {
    difference() {
      cube([box_w - ant_w, bat_w, mat_z]);
      translate([2 * mat_z, (bat_w - 3 * mat_z) / 2, 0]) cube([mat_z, 3 * mat_z, mat_z]);
      translate([(box_w - ant_w) - (3) * mat_z, (bat_w - 3 * mat_z) / 2, 0]) cube([mat_z, 3 * mat_z, mat_z]);
      difference() {
        cube([box_r, box_r, mat_z]);
        translate([box_r, box_r, 0]) cylinder(mat_z, box_r, box_r);
      }
    }
    translate([3 * mat_z, bat_w, 0]) cube([3 * mat_z, mat_z, mat_z]);
    translate([box_w - ant_w - (1 + 1) * 3 * mat_z, bat_w, 0]) cube([3 * mat_z, mat_z, mat_z]);
  }
}

module rest() {
  union() {
    cube([2 * mat_z, bat_w, mat_z]);
    translate([2 * mat_z, (bat_w - 3 * mat_z) / 2, 0]) cube([mat_z, 3 * mat_z, mat_z]);
    translate([-mat_z, (bat_w - 3 * mat_z) / 2, 0]) cube([mat_z, 3 * mat_z, mat_z]);
//    translate([mat_z, bat_w, 0]) cube([mat_z, mat_z, mat_z]);
  }
}

d = 2; // 2D or 3D

if (d == 2) {
  projection() {
    translate([11, 58, 0]) rotate([180, 0, 0]) bank();
    translate([-1, 32, 0]) rotate([180, 0, 0]) wall();
    translate([-2.5, 33.5, 0]) rotate([0, 0, 0]) rest();
    translate([17, 59.5, 0]) rotate([0, 0, 90]) rest();
    translate([108, 6.5, 0]) rotate([0, 0, 90]) base();
  }
} else {
  translate([0, 0, -mat_z]) base();
  translate([0, bat_w + mat_z + mat_z, mat_z]) rotate([90, 0, 0]) wall();
  translate([3 * mat_z, 0, mat_z]) rotate([0, -90, 0]) rest();
  translate([(box_w - ant_w) - (3 - 1) * mat_z, 0, mat_z]) rotate([0, -90, 0]) rest();
  translate([0, 0, 4 * mat_z]) bank();
}
