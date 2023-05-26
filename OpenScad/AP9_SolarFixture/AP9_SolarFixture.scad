// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 36;

module round_rect(w, h, r, d) {
    hull() {
        translate([r, r, 0]) cylinder(d, r, r);
        translate([r + w - 2 * r, r, 0]) cylinder(d, r, r);
        translate([r + w - 2 * r, r + h - 2 * r, 0]) cylinder(d, r, r);
        translate([r, r + h - 2 * r, 0]) cylinder(d, r, r);
    }
}

d = 3; // material thickness
r = 10; // corner radius
off = 4;// + 4; // offset

module solar_panel() {
    color("#444444") round_rect(136, 112, r, 2.7);
    color("#444444") hull() {
        translate([(136 - 30) / 2, (112 - 30) / 2, -1]) round_rect(30, 30, 2, 1);
        translate([(136 - 15) / 2, (112 - 15) / 2, - 5]) round_rect(15, 15, 2, 2.7);
    }
}

module side_panel() {
    w = 112;
    h = 112;
    difference() {
        hull() {
            translate([r + 14, r + 14, 0]) cylinder(d, r, r);
//#            translate([r, r + 42, 0]) cylinder(d, r, r);
            translate([r + w - 2 * r, r + h - 2 * r, 0]) cylinder(d, r, r);
            translate([r + 14, r + h - 2 * r, 0]) cylinder(d, r, r);

//#            translate([r + w - 2 * r, r + h - 2 * r, 0]) cylinder(d, r, r);
//#            translate([r, r + h - 2 * r, ]) cylinder(d, r, r);
        }
        translate([-30 - d, 112 - 27.5 + d, 0]) {
            translate([h - 5 * d, -d, 0]) cube([3 * d, d , d]);
            translate([h - 11 * d, -d, 0]) cube([3 * d, d , d]);
            translate([h - 17 * d, -d, 0]) cube([3 * d, d , d]);
        }
        translate([25, 30.5 - d, 0]) {
            translate([-d, 3 * d, 0]) cube([d, 3 * d, d]);
            translate([-d, 9 * d, 0]) cube([d, 3 * d, d]);
            translate([-d, 15 * d, 0]) cube([d, 3 * d, d]);
        }
#            translate([38, 71.5, 0]) cube([6, 2, 20 * d]);

    }
}

//!projection() side_panel();

module box() {
    color("#dddddd") translate([2, 2, 0]) {
        translate([-2, -2, 27.5]) round_rect(85, 85, 6, 11);
        round_rect(82, 82, 6, 27.5);
    }
}

module mid_panel() {
    w = 112 - 2 * off;
    x = (112 - 2 * off - 85) / 2;
    difference() {
        union() {
            round_rect(w, 84.5 - 27.5, 1, d);
            translate([-d, 3 * d, 0]) cube([d, 3 * d, d]);
            translate([-d, 9 * d, 0]) cube([d, 3 * d, d]);
            translate([-d, 15 * d, 0]) cube([d, 3 * d, d]);
            translate([w, 3 * d, 0]) cube([d, 3 * d, d]);
            translate([w, 9 * d, 0]) cube([d, 3 * d, d]);
            translate([w, 15 * d, 0]) cube([d, 3 * d, d]);
        }
        translate([(w - 86) / 2, 84.5 - 27.5 - 12, 0]) round_rect(86, 11 + 4, 2, 27.5);
        //#translate([(w - 85) / 2, 84.5 - 27.5 - 11, 0]) round_rect(85, (84.5 - 27.5) - (11 + 4), 4, 27.5);
        translate([(w - 86) / 2, x, 0]) round_rect(86, (84.5 - 27.5) - (11) - 2 * x, 4, 27.5);
    }
}

//!projection() mid_panel();

module back_panel() {
    w = 112 - 2 * off;
    h = 112 - 2 * off;
    r2 = 1;
    difference() {
        union() {
            hull() {
                translate([r, r, 0]) cylinder(d, r, r);
                translate([r + w - 2 * r, r, 0]) cylinder(d, r, r);
                translate([r2 + w - 2 * r2, r2 + h - 2 * r2, 0]) cylinder(d, r2, r2);
                translate([r2, r2 + h - 2 * r2, 0]) cylinder(d, r2, r2);
            }
            translate([-d, h - 5 * d, 0]) cube([d, 3 * d, d]);
            translate([-d, h - 11 * d, 0]) cube([d, 3 * d, d]);
            translate([-d, h - 17 * d, 0]) cube([d, 3 * d, d]);

            translate([w, h - 5 * d, 0]) cube([d, 3 * d, d]);
            translate([w, h - 11 * d, 0]) cube([d, 3 * d, d]);
            translate([w, h - 17 * d, 0]) cube([d, 3 * d, d]);
        }
        translate([(112 - 2 * off - 85) / 2, (112 - 2 * off - 85) / 2, -1]) box();
    }
}

//!projection() back_panel();

rotate([0, 270, 0]) translate([0, 0, 4]) side_panel();
! projection()
rotate([0, 90, 0])
difference() {
translate([112 - 2 * off + d, 0, 0]) rotate([0, 270, 0]) side_panel();
translate([-12 - off, r, 7.5]) rotate([45, 0, 0]) translate([0, 136 - 112 - d, 0]) solar_panel();
}
translate([0, 0, -25]) {
    translate([0, 112 - 27.5 + d, 0]) rotate([90, 0, 0]) /* ! projection() */ back_panel();
    translate([(112 - 2 * off - 85) / 2, 112, (112 - 2 * off - 85) / 2]) rotate([90, 0, 0]) box();
}
translate([0, 27.5, 25 -d]) mid_panel();
