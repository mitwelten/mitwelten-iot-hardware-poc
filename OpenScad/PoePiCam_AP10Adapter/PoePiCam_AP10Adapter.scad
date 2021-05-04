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

translate([0, 0]) { 
    difference() {
        translate([6, 6]) hull() {
            translate([0, 0]) circle(6);
            translate([94 - 2 * 6, 0]) circle(6);
            translate([0, 94 - 2 * 6]) circle(6);
            translate([94 - 2 * 6, 94 - 2 * 6]) circle(6);
        }
        translate([13.5, 13.5]) circle(d=2.5);
        translate([13.5, 94 - 13.5]) circle(d=2.5);
        translate([94 - 13.5, 13.5]) circle(d=2.5);
        translate([94 - 13.5, 94 - 13.5]) circle(d=2.5);
        translate([94 - 13.5 - 24 - 4, 94 - 13.5 - 25.1]) square([24, 25.1]);
        //translate([7 + 2, 4]) square([57, 90]); // pi
        translate([7 + 2 + 18, 4 + 18]) square([57 - 2 * 18, 90 - 2 * 18]);
        translate([7, 22]) square([2, 5]);
        translate([66, 22]) square([2, 5]);
    }
}