$fn=360;

s = 76;
r = (s/2) - (1.5 + 4);
w = 85.2;

difference() {
    square([w, w]);
    translate([w/2, w/2]) circle(r);
}