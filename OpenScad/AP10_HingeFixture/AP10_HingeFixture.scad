$fn = 360;

module rounded_square(w, r) {
    hull() {
        translate([r, r, 0]) circle(r);
        translate([w - r, r, 0]) circle(r);
        translate([r, w - r, 0]) circle(r);
        translate([w - r, w - r, 0]) circle(r);
    }
}

module frame(h, d) {
    linear_extrude(h) {
        difference() {
            rounded_square(100 + 2 * d, 9 + d);
            translate([d, d, 0]) rounded_square(100, 9);
        }
    }
}

module hinge(d) {
    linear_extrude(d) {
        difference() {
            union() {
                translate([10, 20, 0]) circle(10);
                square(20, 20);
            }
            translate([10, 20, 0]) circle(2);
        }
    }
}

module hinge2(d) {
    translate([0, 0, 0]) hinge(d);
    translate([0, 0, 2 * d]) hinge(d);
}

module hinge3(d) {
    translate([0, 0, 0]) hinge(d);
    translate([0, 0, 2 * d]) hinge(d);
    translate([0, 0, 4 * d]) hinge(d);
}

module ap10_hinge_fixture() {
    d = 4;
    difference() {
        union() {
            frame(29, d);
            translate([22/2 + d + 10, 2, 29/2]) rotate([90, 0, 0]) cylinder(3, 24/2, 24/2);
            translate([100 + 2 * d - (22/2 + d + 10), 2, 29/2]) rotate([90, 0, 0]) cylinder(3, 24/2, 24/2);
        }
        translate([22/2 + d + 10, 3 + 4, 29/2]) rotate([90, 0, 0]) cylinder(5 + 4, 22/2, 22/2);
        translate([100 + 2 * d - (22/2 + d + 10), 3 + 4, 29/2]) rotate([90, 0, 0]) cylinder(5 + 4, 22/2, 22/2);
    }
    translate([(5 * 4/2) + (100 + 2 * d)/2, 0, 20]) rotate([180, 90, 0]) hinge3(4);
    difference() {
        translate([-(5 * 4/2) + (100 + 2 * d)/2, -4, 0]) cube([5 * 4, 4, 20]);
        translate([(100 + 2 * d)/2 - 4, -4, -1]) cylinder(20 + 2, 2, 2);
        translate([(100 + 2 * d)/2 + 4, -4, -1]) cylinder(20 + 2, 2, 2);
    }
    difference() {
        translate([-(5 * 4/2) + (100 + 2 * d)/2 - 4, -4, 0]) cube([4, 4, 20]);
        translate([-(5 * 4/2) + (100 + 2 * d)/2 - 4, -4, -1]) cylinder(20 + 2, 4, 4);
    }
    difference() {
        translate([-(5 * 4/2) + (100 + 2 * d)/2 - 4 + 24, -4, 0]) cube([4, 4, 20]);
        translate([-(5 * 4/2) + (100 + 2 * d)/2 + 24, -4, -1]) cylinder(20 + 2, 4, 4);
    }
}

module hinge_tube_fixture() {
    d = 4;
    difference() {
        translate([(100 + 2 * d)/ 2, -50, 0]) cylinder(20, 14, 14);
        translate([(100 + 2 * d)/ 2, -50, -1]) cylinder(20 + 2, 10, 10);
    }
    translate([(-3 * 4)/2 + (100 + 2 * d)/ 2, -40, 20]) rotate([0, 90, 0]) hinge2(4);
    difference() {
        translate([-(3 * 4/2) + (100 + 2 * d)/2, -40 + 2, 0]) cube([3 * 4, 4, 20]);
        translate([(100 + 2 * d)/2, -40 + 2 + 4, -1]) cylinder(20 + 2, 2, 2);
    }
}

ap10_hinge_fixture();
//hinge_tube_fixture();