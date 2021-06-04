// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

// lens cover, acrylic
module cover2(ring) {
    difference() {
        circle(d=34);
        if (ring == true) {
            circle(d=24);
        }
    }
}

cover2(false);
translate([40, 0]) cover2(true);