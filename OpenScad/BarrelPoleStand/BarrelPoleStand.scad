$fn = 360;

module leg(h, w_hi, w_lo, s_hi, s_lo, d) {
    linear_extrude(d) {
        difference() {
            hull() {
                //polygon([[0,0], [470, 0], [470, 235], [0, 200]]);
                r = 20;
                translate([0, 0]) square([r, r]);
                translate([h - r, 0 + r]) circle(r);
                translate([h - r, w_lo - r]) circle(r);
                translate([0 + r, w_hi - r]) circle(r);
            }
            // upper cuts
            translate([0, 0]) { square([d, s_hi]); }
            translate([0, 2 * s_hi]) { square([d, s_hi]); }
            // lower cut
            translate([h/2, 0]) { square([d, s_lo]); }
        }
    }    
}

module ring(r_inner, r_outer, d) {
    linear_extrude(d) {
        difference() {
            circle(r_inner);
            circle(r_outer);
        }
    }
}

v = 0; // barrel stand
//v = 1; // pole stand
r_pole = 20;
r_barrel = 125;
r_hi_disc = r_barrel + 110;
r_lo_disc = r_barrel + 110;
h_leg = 470;
w_hi_leg = 200;
w_lo_leg = 235;

d = 27;
s_hi = (r_hi_disc - r_barrel) / 3;
s_lo = (r_lo_disc - r_barrel) / 2;

//projection(cut=false) // for 2D exports
translate([0, 500/2, 0]) {
// rings
translate([20 + r_hi_disc, 0]) {
    difference() {
        ring(r_hi_disc, v == 0 ? r_barrel : r_pole, d);
        rotate([0, 0, 0]) translate([r_barrel + s_hi, -d/2, -1]) cube([s_hi, d, d + 2]);
        rotate([0, 0, 90]) translate([r_barrel + s_hi, -d/2, -1]) cube([s_hi, d, d + 2]);
        rotate([0, 0, 180]) translate([r_barrel + s_hi, -d/2, -1]) cube([s_hi, d, d + 2]);
        rotate([0, 0, 270]) translate([r_barrel + s_hi, -d/2, -1]) cube([s_hi, d, d + 2]);
        if (v == 0) {
            rotate([0, 0, 45]) translate([r_barrel - 10, -75/2, -1]) cube([5 + 10, 75, d + 2]);
            rotate([0, 0, 225]) translate([r_barrel - 10, -75/2, -1]) cube([5 + 10, 75, d + 2]);
        }
    }
}
translate([20 + 2 * r_hi_disc + 20 + r_lo_disc, 0, 0]) {
    difference() {
        ring(r_lo_disc, v == 0 ? r_barrel : r_pole, d);
        rotate([0, 0, 0]) translate([r_barrel + s_lo, -d/2, -1]) cube([s_lo, d, d + 2]);
        rotate([0, 0, 90]) translate([r_barrel + s_lo, -d/2, -1]) cube([s_lo, d, d + 2]);
        rotate([0, 0, 180]) translate([r_barrel + s_lo, -d/2, -1]) cube([s_lo, d, d + 2]);
        rotate([0, 0, 270]) translate([r_barrel + s_lo, -d/2, -1]) cube([s_lo, d, d + 2]);
    }
}

// legs
translate([20 + 2 * r_hi_disc + 20 + 2 * r_lo_disc + 20, -235, 0]) {
//translate([20 + 2 * r_hi_disc + 20 + 2 * r_lo_disc + 20, r_barrel, 0]) {
    leg(h_leg, w_hi_leg, w_lo_leg, s_hi, s_lo, d);
}
translate([20 + 2 * r_hi_disc + 20 + 2 * r_lo_disc + 20 + h_leg, w_lo_leg, 0]) {
    rotate([0, 0, 180]) {
//translate([20 + 2 * r_hi_disc + 20 + 2 * r_lo_disc + 20, -r_barrel, d]) {
//    rotate([180, 0, 0]) {
        leg(h_leg, w_hi_leg, w_lo_leg, s_hi, s_lo, d);
    }
}
translate([20 + 2 * r_hi_disc + 20 + 2 * r_lo_disc + 20 + h_leg + 20, -235, 0]) {
    leg(h_leg, w_hi_leg, w_lo_leg, s_hi, s_lo, d);
}
translate([20 + 2 * r_hi_disc + 20 + 2 * r_lo_disc + 20 + h_leg + 20 + h_leg, 235, 0]) {
    rotate([0, 0, 180]) {
        leg(h_leg, w_hi_leg, w_lo_leg, s_hi, s_lo, d);
    }
}

// plank
color("#ffff0066") {
    translate([0, -250, 0.1]) {
        //cube([2000, 500, d - 0.2]);
    }
}
}