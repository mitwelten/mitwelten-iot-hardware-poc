// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

// Prepend !projection() to isolate, make flat for DXF, SVG export

$fn = 360;

module side() {
    rotate([90, 0, 0]) {
    //!projection()
        difference() {
            cube([22 + 22 + 40, 128, 8]);
            // screw holes
            translate([(22 / 2), 22, -1]) cylinder(8 + 2, 2, 2);
            translate([(22 + 22 + 40) - (22 / 2), 22, -1]) cylinder(8 + 2, 2, 2);
            translate([(22 / 2), 128 - 22, -1]) cylinder(8 + 2, 2, 2);
            translate([(22 + 22 + 40) - (22 / 2), 128 - 22, -1]) cylinder(8 + 2, 2, 2);
        }
    }
}

module panel() {
    rotate([90, 0, 0]) {
        //!projection()
        difference() {
            union() {
                cube([240, 310 + 8, 8]);
                // fingers
                translate([20, -8, 0]) cube([30, 8, 8]);
                translate([240 - 20 - 30, -8, 0]) cube([30, 8, 8]);
                translate([20, 310 + 8, 0]) cube([30, 8, 8]);
                translate([240 - 20 - 30, 310 + 8, 0]) cube([30, 8, 8]);
            }
            translate([40, 40, -1]) cube([38, 120, 8 + 2]);
            translate([240 + - 38 - 40, 40, -1]) cube([38, 120, 8 + 2]);
            translate([(240 - 100) / 2, -1, -1]) cube([100, 8 + 1, 8 + 2]);
            // screw holes
            translate([(240 - 84) / 2, 0, 0]) {
                translate([(22 / 2), 22, -1]) cylinder(8 + 2, 2, 2);
                translate([(22 + 22 + 40) - (22 / 2), 22, -1]) cylinder(8 + 2, 2, 2);
                translate([(22 / 2), 160 + (22 / 2), -1]) cylinder(8 + 2, 2, 2);
                translate([(22 + 22 + 40) - (22 / 2), 160 + (22 / 2), -1]) cylinder(8 + 2, 2, 2);
                translate([(22 / 2), 310 + 8 - (22/2), -1]) cylinder(8 + 2, 2, 2);
                translate([(22 + 22 + 40) - (22 / 2), 310 + 8 - (22/2), -1]) cylinder(8 + 2, 2, 2);
            }
        }
    }
}

module poe_adapter() {
    translate([0, 0, 80 + 105]) color("red") cube([60, 38, 25]);
    translate([0, 0, 80]) color("black") cube([60, 38, 105]);
    translate([0, 0, 0]) color("red") cube([60, 38, 80]);
}

module poe_switch() {
    color("black") rotate([90, 0, 0]) cube([100, 100, 26]);
}

module wifi_router() {
    color("black") rotate([90, 0, 0]) {
        translate([0, 0, 0]) cube([35, 165, 35]);
        translate([175 - 35, 0, 0]) cube([35, 165, 35]);
        translate([0, 165, 0]) cube([175, 125, 35]);
    }
}

module barrel() {
    color("#0000ff66")
    // middle ring
    translate([0, 0, 160]) {
            difference() {
                translate([0, 0, 1]) {
                    cylinder(180, 160, 160);
                }
                cylinder(182, 158, 158);
            }
    }    
}

module base_disk() {
    //!projection() 
    difference() {
        cylinder(8, 125, 125);
        // screw holes
        translate([(22 + 40)/2, 0, -1]) cylinder(8 + 2, 2, 2);
        translate([-(22 + 40)/2, 0, -1]) cylinder(8 + 2, 2, 2);
        // finger holes
        translate([-120 + 20, -22 -8, -1]) cube([30, 8, 8 + 2]);
        translate([120 - 20 - 30, -22 -8, -1]) cube([30, 8, 8 + 2]);
        translate([-120 + 20, 22, -1]) cube([30, 8, 8 + 2]);
        translate([120 - 20 - 30, 22, -1]) cube([30, 8, 8 + 2]);
    }
}

module small_disk() {
    //!projection() 
    difference() {
        cylinder(8, 52, 52);
        translate([0, 0, -1]) cylinder(8 + 2, 20, 20);
        translate([(22 + 40)/2, 0, -1]) cylinder(8 + 2, 2, 2);
        translate([-(22 + 40)/2, 0, -1]) cylinder(8 + 2, 2, 2);
    }
}

module mid_disk() {
    //!projection() 
    difference() {
        cylinder(8, 125, 125);
        //cylinder(8, 158, 158);
        translate([-(22 + 22 + 40) / 2, - 44 / 2, -1]) cube([22 + 22 + 40, 44, 8 + 2]);
        // multiplug hole
        translate([-54/2, 22 + 8 + 35, -1]) cube([54, 43, 8 + 2]);
        // poe holes
        //translate([5 + (220 / 2) - 100, (44 / 2) + 8 + 7, -1]) cube([90, 19, 8 + 2]);
        //translate([5 + -(220 / 2), (44 / 2) + 8 + 7, -1]) cube([90, 19, 8 + 2]);
        translate([5 + (-100 / 2), (44 / 2) + 8 + 7, -1]) cube([90, 19, 8 + 2]);
        // finger holes
        translate([-120 + 20, -22 -8, -1]) cube([30, 8, 8 + 2]);
        translate([120 - 20 - 30, -22 -8, -1]) cube([30, 8, 8 + 2]);
        translate([-120 + 20, 22, -1]) cube([30, 8, 8 + 2]);
        translate([120 - 20 - 30, 22, -1]) cube([30, 8, 8 + 2]);
    }    
}

module mid_ring() {
    //!projection()
    difference() {
        cylinder(8, 158, 158);
        translate([0, 0, -1]) cylinder(8 + 2, 125, 125);
        translate([-158, 0, -1]) cube([2 * 158, 158, 8 + 2]);
    }
}

translate([0, 0, -26]) base_disk();
translate([0, 0, -10]) small_disk();
translate([0, 0, 500 + 2 * 8 + 10]) small_disk();
translate([0, 0, 310 + 2 * 8 + 10]) mid_disk();
translate([0, 0, 310 + 2 * 8 + 28]) mid_ring();
translate([0, 0, 310 + 2 * 8 + 46]) rotate(180) mid_ring();
translate([20, -44/2, 2 * 8]) cube([22, 44, 500]);
translate([-20 - 22, -44/2, 2 * 8]) cube([22, 44, 500]);
translate([-120, -22, 8]) panel();
translate([-120, 22 + 8, 8]) panel();

translate([-(22 + 22 + 40) / 2, 44/2 + 8, 500 - (190 - 8) + 2 * 8]) side();
translate([-(22 + 22 + 40) / 2, -44/2, 500 - (190 - 8) + 2 * 8]) side();
//translate([(220 / 2) - 100, (44 / 2) + 8 + 26, 310 - (100) + 2 * 8]) poe_switch();
//translate([-(220 / 2), (44 / 2) + 8 + 26, 310 - (100) + 2 * 8]) poe_switch();
translate([-100/2, (44 / 2) + 8 + 26, 310 - (100) + 2 * 8]) poe_switch();
translate([(22 + 22 + 40) / 2, -28/2, 310 - (25 + 105 + 80) + 2 * 8]) poe_adapter();
translate([-60 -(22 + 22 + 40) / 2, -28/2, 310 - (25 + 105 + 80) + 2 * 8]) poe_adapter();
translate([-175 / 2, -8 - (44 / 2), (310 + 2 * 8) - (125 + 165)]) wifi_router();
barrel();
