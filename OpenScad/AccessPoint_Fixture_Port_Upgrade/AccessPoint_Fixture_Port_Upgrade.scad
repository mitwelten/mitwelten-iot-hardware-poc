$fn = 360;

module mid_disk_double() {
    !projection() 
    difference() {
        cylinder(8, 125, 125);
        //cylinder(8, 158, 158);
        translate([-(22 + 22 + 40) / 2, - 44 / 2, -1]) cube([22 + 22 + 40, 44, 8 + 2]);
        // poe holes
        translate([5 + (-100 / 2), (44 / 2) + 8 + 7, -1]) cube([90, 19 + 24, 8 + 2]);
        // finger holes
        translate([-120 + 20, -22 -8, -1]) cube([30, 8, 8 + 2]);
        translate([120 - 20 - 30, -22 -8, -1]) cube([30, 8, 8 + 2]);
        translate([-120 + 20, 22, -1]) cube([30, 8, 8 + 2]);
        translate([120 - 20 - 30, 22, -1]) cube([30, 8, 8 + 2]);
        rotate(180) {
            // rj45 hole
            translate([-70, 60, -1]) cylinder(8 + 2, 10, 10);
            // multiplug hole
            translate([-54/2, -2 + 22 + 8 + 35, -1]) cube([54, 43, 8 + 2]);
            // zip holes
            translate([-40, -2 + 65, 0]) cube([5, 2, 8 + 2]);
            translate([40 - 5, -2 + 65, 0]) cube([5, 2, 8 + 2]);
            translate([-40, -2 + 40 + 65, 0]) cube([5, 2, 8 + 2]);
            translate([40 - 5, -2 + 40 + 65, 0]) cube([5, 2, 8 + 2]);
        }
    }    
}

mid_disk_double();