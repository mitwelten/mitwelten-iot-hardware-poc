// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 36; //360;

//difference() {
color("#bfa522") {
    // backpane
    translate([-120, 190, 20]) {
        cube([240, 500 - 190, 8]);
    }
    // lower front pole
    translate([-22, 0, 20]) {
        cube([44, 190 - 8, 22]);
    }
    // back pole
    translate([-22, 0, -42]) {
        cube([44, 500, 22]);
    }
    // barrel cover
    translate([0, -8, 0]) {
        rotate([90, 0, 0]) {
            cylinder(8, 125, 125);
        }
    }
    // lowest disc
    translate([0, 0, 0]) {
        rotate([90, 0, 0]) {
            cylinder(8, 50, 50);
        }
    }
    // lower disc
    difference() {
        translate([0, 190]) {
            rotate([90, 0, 0]) {
                cylinder(8, 125, 125);
            }
        }
        // poe hole
        translate([8 + 22, 190 - 9, -25 + 20]) {
            cube([80, 9, 25]);
        }
    }
    // highest disc
    translate([0, 500]) {
        rotate([90, 0, 0]) {
            cylinder(8, 125, 125);
        }
    }
}
color("gray") {
    // pole
    translate([0, 501]) {
        rotate([90, 0, 0]) {
            //cylinder(1200, 20, 20);
            cylinder(550, 20, 20);
        }
    }
    // splint
    translate([-60, 2, 0]) {
        rotate([0, 90, 0]) {
            cylinder(120, 2, 2);
        }
    }
}
//}
color("black") {
    // multiplug
    translate([-(95/2), 190, -45 - 20 - 22]) {
        cube([95, 45, 45]);
        translate([37, -45, 0]) {
                cube([20, 45, 45]);
        }
    }
    // poe switch
    translate([20, 190, -25 + 20]) {
        cube([100, 100, 25]);
    }
    translate([-(175/2), 190, 20 + 8]) {
        // wifi router
        cube([175, 125, 35]);
        // antenna
        translate([0, 126]) {
            cube([35, 165, 35]);
        }
        // antenna
        translate([175 - 35, 126]) {
            cube([35, 165, 35]);
        }
    }
}
color("red") {
    // wifi power plug w/ adapter
    translate([-100 + 50, 190 + 26, -46 - 20 - 22]) {
        rotate([0, 0, 45]) {
            cube([30, 47, 60]);
            translate([15, 23.5, 60]) {
                cylinder(20, 6, 6);
            }
            translate([-5, 23.5, 60 + 20]) {
                rotate([90, 0, 0]) {
                    rotate_extrude(angle = 90) {
                        translate([20, 0, 0]) {
                            circle(3);
                        }
                    }
                }
            }
        }
    }
    // poe power plug
    translate([-100 + 120, 190 + 26 + 20, -46 - 20 - 22]) {
        rotate([0, 0, -45]) {
            cube([30, 45, 47]);
        }
        rotate([90, 0, 45]) {
            translate([35, 22.5, -20]) {
                cylinder(20, 6, 6);
            }
        }
    }
    // poe power adapter
    translate([-38 - 22, 190 + 90, -60 + 20]) {
        cube([38, 105, 60]);
        rotate([90, 0, 0]) {
            translate([20, 45, 0]) {
                cylinder(20, 6, 6);
                cylinder(70, 3, 3);
            }
            translate([20, 30, -105 - 50]) {
                cylinder(50, 10, 10);
            }
            translate([0, 30, -105 - 50]) {
                rotate([90, 90, 0]) {
                    rotate_extrude(angle = 90) {
                        translate([20, 0, 0]) {
                            circle(6);
                        }
                    }
                }
            }
        }
    }
    // wifi power port
    translate([-40, 190 + 125, 20 + 8 + 16.8]) {
        rotate([90, 0, 180]) {
            cylinder(70, 3, 3);
            cylinder(20, 6, 6);
        }
    }
    // poe power port
    translate([100, 290, 20 - 12]) {
        rotate([90, 0, 180]) {
            cylinder(50, 3, 3);
            cylinder(20, 6, 6);
        }
    }
    
    // multiplug 220V power
    translate([-(95/2), 190, -45 - 20 - 22]) {
        translate([37, -45 -45, 0]) {
                cube([20, 45, 45]);
        }
        translate([37 + 10, -45 -45 - 20, 22.5]) {
            rotate([90, 0, 180]) {
                cylinder(20, 6, 6);
            }
        }
    }
}
color("orange") {
    // wifi to lan port
    translate([-35 + 10, 190 + 125, 20 + 8 + 16.8]) {
        rotate([90, 0, 180]) {
            cylinder(70, 3, 3);
            cylinder(40, 6, 6);
        }
    }
    // lan to wifi port
    translate([40, 190, 20 - 12]) {
        rotate([90, 0, 0]) {
            cylinder(70, 3, 3);
            cylinder(40, 6, 6);
        }
    }
    // poe lan port
    translate([55, 190, 20 - 12]) {
        rotate([90, 0, 0]) {
            cylinder(70, 3, 3);
            cylinder(40, 6, 6);
        }
    }
    // poe lan port
    translate([70, 190, 20 - 12]) {
        rotate([90, 0, 0]) {
            cylinder(70, 3, 3);
            cylinder(40, 6, 6);
        }
    }
    // poe lan port
    translate([85, 190, 20 - 12]) {
        rotate([90, 0, 0]) {
            cylinder(70, 3, 3);
            cylinder(40, 6, 6);
        }
    }
    // poe lan port
    translate([100, 190, 20 - 12]) {
        rotate([90, 0, 0]) {
            cylinder(70, 3, 3);
            cylinder(40, 6, 6);
        }
    }
}
translate([0, 0, 0]) {
color("#0000ff66") {
    // lower ring
    translate([0, 160]) {
        rotate([90, 0, 0]) {
            difference() {
                translate([0, 0, 1]) {
                    cylinder(160, 160, 125);
                }
                cylinder(162, 158, 123);
            }
        }
    }
    // middle ring
    translate([0, 340]) {
        rotate([90, 0, 0]) {
            difference() {
                translate([0, 0, 1]) {
                    cylinder(180, 160, 160);
                }
                cylinder(182, 158, 158);
            }
        }
    }
    // higher ring
    translate([0, 500]) {
        rotate([90, 0, 0]) {
            difference() {
                translate([0, 0, 1]) {
                    cylinder(160, 125, 160);
                }
                cylinder(162, 123, 158);
            }
        }
    }
}
}
