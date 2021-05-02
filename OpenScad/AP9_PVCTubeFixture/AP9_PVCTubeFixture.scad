// CC BY-SA, FHNW (University of Applied Sciences and Arts Northwestern Switzerland)

$fn = 360;

module ring() {
    difference() {
        circle(d = 31.811);
        circle(d = 15.911);
    }
}

linear_extrude(4) {
union() {
    ring();
    translate([3.47 + -96.96/2, -11.5]) circle(3.47);
    translate([3.47 + -96.96/2, -37.51]) circle(3.47);
    polygon([[-31.811/2, 0], [-1.130 + 3.47 + -96.96/2, -11.5 - 0.185 + 3.47], [3.47 + -96.96/2, -31.811/2], [0, -31.811/2]]);
    translate([-96.96/2, -37.51]) square([8.05, 26]);
    translate([3.47 + -96.96/2, -37.51 - 3.47]) square([8.05 - 3.47, 8.05 - 3.47]);
    difference() {
        translate([-54.30, -33]) circle(16);
        translate([-31.98 + -80.919/2, -49]) square([32, 32]);
    }
    translate([-3.47 + 96.96/2, -11.5]) circle(3.47);
    translate([-3.47 + 96.96/2, -37.51]) circle(3.47);
    polygon([[31.811/2, 0], [-3.47 + 1.130 + 96.96/2, -11.5 - 0.185 + 3.47], [-3.47 + 96.96/2, -31.811/2], [0, -31.811/2]]);
    translate([96.96/2 - 8.05, -37.51]) square([8.05, 26]);
    translate([96.96/2 - 8.05, -37.51 - 3.47]) square([8.05 - 3.47, 8.05 - 3.47]);
    difference() {
        translate([54.30, -33]) circle(16);
        translate([-0.02 + 80.919/2, -49]) square([32, 32]);
    }
}
//translate([-20, -34]) ring();
//translate([20, -34]) ring();
}

translate([0, 0, 4]) linear_extrude(4) {
    ring();
}