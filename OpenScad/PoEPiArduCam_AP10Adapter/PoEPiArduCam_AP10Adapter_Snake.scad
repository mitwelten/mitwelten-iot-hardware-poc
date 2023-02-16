// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 72;

r = 3.5;

module bar(x1, y1, x2, y2, r) {
    hull() {
        translate([x1, y1, 0]) cylinder(3, r, r);
        translate([x2, y2, 0]) cylinder(3, r, r);
    }
}

module screw(x, y, r) {
    translate([x, y, -1]) cylinder(3 + 2, r, r);
}

module pi_screw(x, y) {
    screw(x, y, 2.5 / 2);
}

module cam_screw(x, y) {
    screw(x, y, 0.7);    
}

module left_support() {
    difference() {
        union() {
            bar(r, r, 11.5, r, r);
            bar(r, r, r, 59 + 2.5, r);
            bar(r, 59 + 2.5, 11.5, 59 + 2.5, r);
        }
        pi_screw(11.5, r);
        pi_screw(11.5, 59 + 2.5);
    }
}

module right_support() {
    difference() {
        union() {
            bar(r, r, 11.5, r, r);
            bar(29, 28, 29, 59 + 2.5, r);
            bar(11.5, 28, 29, 28, r);
            //pi_screw(11.5, 28);

            bar(11.5, r, 11.5, 28, r);
            bar(r, 59 + 2.5, 29, 59 + 2.5, r);
        }
        pi_screw(r, r);
        pi_screw(r, 59 + 2.5);
    }
}

//module base() {
//  // box size
//  w = 94.9;
//  z = 3;
//  e = 5;
//  w2 = w - 2 * e;
//  difference() {
//    translate([e, e, 0]) hull() {
//      translate([0, 0, 0]) cylinder(z, e, e);
//      translate([w2, 0, 0]) cylinder(z, e, e);
//      translate([0, w2, 0]) cylinder(z, e, e);
//      translate([w2, w2, 0]) cylinder(z, e, e);
//    }
//  }
//}

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

module cam() {
    cam_w = 24.1;
    cam_h = 25.2;
    cam_z = 9;
    
    #translate([0, 0, -cam_z]) cube([cam_w, cam_h, cam_z]);

    # cam_screw(2, 2);
    # cam_screw(15, 2);
    # cam_screw(2, cam_h - 2);
    # cam_screw(15, cam_h - 2);
}

module cam_support() {
    cam_w = 24.1;
    cam_h = 25.2;
    cam_z = 9;
    
    //#translate([0, 0, -cam_z]) cube([cam_w, cam_h, cam_z]);

    difference() {
        union() {
            bar(15, 2, 15, -2, 2);
            bar(15, -2, 17.2, -4.2, 2);
            bar(15, cam_h - 2, 15, cam_h + 2, 2);
        }
        cam_screw(2, 2);
        cam_screw(15, 2);
        cam_screw(2, cam_h - 2);
        cam_screw(15, cam_h - 2);
    }
}

module base_layout() {
    translate([0, 23, 0]) {
        left_support();
        translate([49, 0, 0]) {
            translate([11.5 - r, 0, 0]) right_support();
            translate([2.3, 32.2, 0]) {
                cam();
                cam_support();
            }
        }
    }
    # translate([8, 1, 6]) pi3();
}

module print_layout() {
    translate([0, 0, 0]) {
        left_support();
        translate([0, 11, 0]) {
            translate([11.5 - r, 0, 0]) right_support();
            translate([2.3, 32.2, 0]) cam_support();
        }
    }   
}

module cut_layout() {
    !projection() translate([0, 0, 0]) {
        left_support();
        translate([0, 11, 0]) {
            translate([11.5 - r, 0, 0]) right_support();
            translate([2.3, 32.2, 0]) cam_support();
        }
    }   
}

//base_layout();
//cut_layout();
print_layout();