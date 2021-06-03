// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

// lens cover, acrylic
module cover(ring) {
    difference() {
        circle(d=20);
        if (ring == true) {
            circle(d=12);
        }
    }
}

module cover2(ring) {
    difference() {
        circle(d=34);
        if (ring == true) {
            circle(d=24);
        }
    }
}

//cover(false);
//translate([20 + 2, 0]) cover(true);
//translate([-(20 + 2), 0]) cover(true);
//translate([0, 20 + 2]) {
//    difference() {
//        cover(true);
//        translate([-12/2, 0]) square([12, 12]);
//    }
//}

// bottom cam
//cover2(false);
//translate([34 + 2, 0]) cover2(true);
//translate([-(34/2 + 20/2 + 2), 0]) cover(true);

layer = 0;
w = 95;

translate([0, 0]) { 
    difference() {
        translate([6, 6]) hull() {
            translate([0, 0]) circle(6);
            translate([w - 2 * 6, 0]) circle(6);
            translate([0, w - 2 * 6]) circle(6);
            translate([w - 2 * 6, w - 2 * 6]) circle(6);
        }
//        translate([13.5, 13.5]) circle(d=2.5);
//        translate([13.5, w - 13.5]) circle(d=2.5);
//        translate([w - 13.5, 13.5]) circle(d=2.5);
//        translate([w - 13.5, w - 13.5]) circle(d=2.5);
        // cam
        translate([w - 13.5 - 24.1 - 4 - 1, w - 13.5 - 25.2 - 1]) square([24.1, 25.2]);
        //translate([7 + 2, 4]) square([57, 90]); // pi
        // chip
        translate([7 + 2 + 18, 4 + 18]) square([57 - 2 * 18, 90 - 2 * 18]);
//        translate([7, 22]) square([2, 5]);
//        translate([66, 22]) square([2, 5]);
        if (layer == 0) {
            translate([0, 0]) square([8, 8]);
            translate([w - 8, 0]) square([8, 8]);
            translate([w - 8, w - 8]) square([8, 8]);
            translate([0, w - 8]) square([8, 8]);
        }
        if (layer == 1) {
            translate([w - 4, w - 13.5 - 4 - 1 - 18]) square([4, 18]);    
        }
        // pi
        translate([8, 0]) square([57, 45]);
    }
    if (layer ==  1) {
        translate([w - 13.5 - 24.1 - 4 - 1, w - 13.5 - 25.2 - 1]) square([4, 4]);
        translate([w - 13.5 - 24.1 - 4 - 1, w - 13.5 - 4 - 1]) square([4, 4]);
        translate([w - 13.5 - 8 - 1, w - 13.5 - 25.2 - 1]) square([4, 2]);
        translate([w - 13.5 - 8 - 1, w - 13.5 - 2 - 1]) square([4, 2]);
    }
}