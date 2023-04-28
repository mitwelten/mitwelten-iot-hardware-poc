// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn=36;

// box size
w=94.7;
h=3;

// cam size
a = 24.1;
b = 25.2;

// cam screw hole
rc = .7;

// pi zero size
c = 30;
d = 65;

// pi zero pos
px = 33 - 1 - 3;
py = w - d - 3;

// pi zero screw size
rp = .95;

module base() {
    e=4;
    w2=w-2*e;
    difference() {
        translate([e, e, 0]) hull() {
            translate([0, 0, 0]) cylinder(h, e, e);
            translate([w2, 0, 0]) cylinder(h, e, e);
            translate([0, w2, 0]) cylinder(h, e, e);
            translate([w2, w2, 0]) cylinder(h, e, e);
        }
        // ABB IP55 corner cutouts >>
    #    translate([0, 0, 0]) cube([8, 8, 3]);
    #    translate([w2, 0, 0]) cube([8, 8, 3]);
    #    translate([w2, w2, 0]) cube([8, 8, 3]);
    #    translate([0, w2, 0]) cube([8, 8, 3]);
        // <<
    }
}

!projection() 
difference() {
    union() {
        difference() {
            base();

            // screw holes
//            translate([w/2 - 67/2, w - 5, -1]) cylinder(h + 2, 1, 1);
//            translate([w/2, w - 5, -1]) cylinder(h + 2, 1, 1);
//            translate([w/2 + 67/2, w - 5, -1]) cylinder(h + 2, 1, 1);
//            translate([w/2 - 67/2, 5, -1]) cylinder(h + 2, 1, 1);
//            translate([w/2, 5, -1]) cylinder(h + 2, 1, 1);
//            translate([w/2 + 67/2, 5, -1]) cylinder(h + 2, 1, 1);

            // rj45 hole
            translate([0, 0, -1]) cube([33, 82, h + 2]);

            // pi screw holes
            //translate([w - px - c, w - py - d, -1]) cube([c, d, h + 2]);
            translate([w - px - c + 3.5, w - py - d + 3.5, -1]) cylinder(h + 2, rp, rp);
            translate([w - px - 3.5, w - py - d + 3.5, -1]) cylinder(h + 2, rp, rp);
            translate([w - px - c + 3.5, w - py - 3.5, -1]) cylinder(h + 2, rp, rp);
            translate([w - px - 3.5, w - py - 3.5, -1]) cylinder(h + 2, rp, rp);

            // cam hole
            translate([w - 18.5 - a, w - 14.5 - b, -1]) cube([a, b, h + 2]);
        }

        // rj45 lock
        translate([0, 82 - 8, 0]) cube([4, 8, h]);

        // cam lock
        translate([w - 18.5 - a, w - 14.5 - b, 0]) cube([4, 4, h]);
        translate([w - 18.5 - a + 13, w - 14.5 - b, 0]) cube([4, 4, h]);
        translate([w - 18.5 - a, w - 14.5 - 4, 0]) cube([4, 4, h]);
        translate([w - 18.5 - a + 13, w - 14.5 - 4, 0]) cube([4, 4, h]);
        translate([w - 18.5 - a, w - 14.5 - 4, 0]) cube([4, 4, h]);
        translate([w - 18.5 - 4, w - 14.5 - b, 0]) cube([4, 2, h]);
        translate([w - 18.5 - 4, w - 14.5 - 2, 0]) cube([4, 2, h]);
    }
    // cam screw holes
    translate([w - 18.5 - a + 2, w - 14.5 - b + 2, -1]) cylinder(h + 2, rc, rc);
    translate([w - 18.5 - a + 13 + 2, w - 14.5 - b + 2, -1]) cylinder(h + 2, rc, rc);
    translate([w - 18.5 - a + 2, w - 14.5 - 4 + 2, -1]) cylinder(h + 2, rc, rc);
    translate([w - 18.5 - a + 13 + 2, w - 14.5 - 4 + 2, -1]) cylinder(h + 2, rc, rc);
}
