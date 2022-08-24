$fn = 36;

d = 3.5;
ri = (d + 0.2)/2;
r = ri + 3;
h = 18;

r2 = 2.5;
ri2 =1.5;

difference() {
    hull() {
        translate([-r, ri, 0]) cube([h, r - ri, h]);
        cylinder(h, r, r);
    }
    translate([0, 0, -1]) cylinder(h + 2, ri, ri);
    translate([r, h/2, h/2]) rotate([90, 0, 0]) union() {
        translate([0, 0, h/2]) cylinder(h/2 + 1, r2, r2);
        cylinder(h + 2, ri2, ri2);
    }
}