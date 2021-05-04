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

cover2(false);
translate([34 + 2, 0]) cover2(true);
translate([-(34/2 + 20/2 + 2), 0]) cover(true);
