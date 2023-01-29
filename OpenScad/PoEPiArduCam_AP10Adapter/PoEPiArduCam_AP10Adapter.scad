// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=36;

module pi3() {
    union() {
      pcb_w = 56;
      pcb_h = 85;

      // usb
      usb_w = 52;
      usb_dh = 2;
      usb_z = 18;
      translate([(pcb_w - usb_w) / 2, 0, 0]) cube([usb_w, usb_dh, usb_z]);

      translate([0, usb_dh, 0]) {
        // pcb + airspace
        translate([0, 0, 0]) cube([pcb_w, pcb_h, usb_z]);

        // screw holes
        scw_w = 49;
        scw_h = 58;
        scw_l = 10;
        scw_r = .95;
        translate([3.5, 23.5, -scw_l]) cylinder(usb_z + scw_l, scw_r, scw_r);
        translate([3.5 + scw_w, 23.5, -scw_l]) cylinder(usb_z + scw_l, scw_r, scw_r);
        translate([3.5 + scw_w, 23.5 + scw_h, -scw_l]) cylinder(usb_z + scw_l, scw_r, scw_r);
        translate([3.5, 23.5 + scw_h, -scw_l]) cylinder(usb_z + scw_l, scw_r, scw_r);
        // rj45
        translate([10, 0, 7]) rotate([0, 90, -90]) cylinder(30, 3, 3);
        // sd + airspace
        sd_w = 12;
        sd_dh = 3;
        translate([(pcb_w - sd_w) / 2, pcb_h - 16 + 3, -2]) cube([12, 16, 18 + 2]);
      }
    }
}

module base(w, z) {
  // box size
  e = 4;
  w2 = w - 2 * e;
  difference() {
    translate([e, e, 0]) hull() {
      translate([0, 0, 0]) cylinder(z, e, e);
      translate([w2, 0, 0]) cylinder(z, e, e);
      translate([0, w2, 0]) cylinder(z, e, e);
      translate([w2, w2, 0]) cylinder(z, e, e);
    }
    // screw holes
    translate([w/2 - 67/2, w - 5, -1]) cylinder(z + 2, 1, 1);
    //translate([w/2, w - 5, -1]) cylinder(z + 2, 1, 1);
    translate([w/2 + 67/2, w - 5, -1]) cylinder(z + 2, 1, 1);
    translate([w/2 - 67/2, 5, -1]) cylinder(z + 2, 1, 1);
    //translate([w/2, 5, -1]) cylinder(z + 2, 1, 1);
    translate([w/2 + 67/2, 5, -1]) cylinder(z + 2, 1, 1);
  }
}

module pi_cam_v2_cutout() {
  cam_w = 24.1;
  cam_h = 25.2;
  cam_z = 9;
  rc = .7;
  // cam + airspace
  //#translate([0, 0, 0]) cube([cam_w, cam_h, cam_z]);
  // cam holes
  translate([4, 0, 0]) cube([13 - 4, cam_h, cam_z]);
  translate([13 + 4, 0, 0]) cube([cam_w - 13 - 4, cam_h, cam_z]);
  translate([0, 4, 0]) cube([4 + 1, cam_h - 2 * 4, cam_z]);
  translate([13 - 1, 4, 0]) cube([4 + 2, cam_h - 2 * 4, cam_z]);
  // screw holes
  translate([2, 2, -1]) cylinder(cam_z + 2, rc, rc);
  translate([13 + 2, 2, -1]) cylinder(cam_z + 2, rc, rc);
  translate([2, cam_h - 4 + 2, -1]) cylinder(cam_z + 2, rc, rc);
  translate([13 + 2, cam_h - 4 + 2, -1]) cylinder(cam_z + 2, rc, rc);
}

!projection() 
difference() {
  ap10_inner_w = 94.8;
  base_z = 3;
  base(ap10_inner_w, base_z);
 translate([ap10_inner_w - 18.5 - 24.1, ap10_inner_w - 14.5 - 25.2, -5]) pi_cam_v2_cutout();
# translate([8, 1, base_z + 3]) pi3();
}
