$fn = 360;
//$fn = 100;

r_220v = 9 / 2;
r_rj45 = 7 / 2;
r_bend = 30;
r_hole = 68 / 2;
r_pole = 39 / 2; // 40? 
d = r_220v + 4;

module wire(r) {
    translate([0, r_bend + r_pole + ((r_hole - r_pole) / 2), r_bend + d]) {
        translate([0, -r_bend, -1]) cylinder(10, r, r);
//        translate([-r + 0.6, -r_bend - 3 * r, -1]) cube([2 * r - 1.2, 3 * r, 10]);
        rotate([180, 90])
        rotate_extrude(angle=90) {
            translate([r_bend, 0]) circle(r);
        }
    }
}

module wire_rj45() {
    wire(r_rj45);
}

module wire_220v() {
    wire(r_220v);
}

//union() {
//difference() {
// >>
//    union() {
//        translate([0, 0, 8]) cylinder(30 + 8, r_hole, r_hole);
//        cylinder(30, 52, 52);
//    }
//    cylinder(60, r_pole + 1, r_pole + 1);
//    translate([0, 0, -1]) cylinder(9 + 1, r_hole + r_bend, r_hole + r_bend);
// <<
//    union() {
    difference() {
        rotate_extrude(angle=360) {
            translate([r_pole, 0, 0]) {
                difference() {      
                    union() {
                        color("blue") square([r_hole - r_pole, r_bend + d]);
                        color("red") square([52 - r_pole, 4 * d + (r_220v)]);
                    }
                    translate([r_bend + d, r_bend + d]) {
                        difference() {
                            circle(r_bend);
//                            circle(r_bend + r_220v / 2);
//                            circle(r_bend - r_220v / 2);
                        }
                    }
                }
            }
        }
        rotate(0) wire_220v();
        rotate(72) wire_rj45();
        rotate(2 * 72) wire_rj45();
        rotate(3 * 72) wire_rj45();
        rotate(4 * 72) wire_rj45();
//        translate([0, 0, 8.15]) cylinder(1, 52 + 1, 52 + 1);
        //#cylinder(60, r_pole + 1, r_pole + 1);
    }
//}