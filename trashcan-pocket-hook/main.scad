$fn = 90;

EPS = 0.10;
LAYER_HEIGHT = 0.2;
ADHESION_PAD = true;

L = 34;
W = 20;
THICKNESS = 2.0;

HOOK_T = 3.3;
HOOK_L = 3.9*HOOK_T;
HOOK_H = 1.5*HOOK_T;
HOOK_Q = 1.55;

module T_cylinder(q=1) {
    rotate([-90, 0,0])
        cylinder(d=HOOK_T, h=q*W);
}

translate([0,0,-THICKNESS])
    cube([L, W, THICKNESS]);
difference() {
    cube([HOOK_Q*HOOK_T, W, HOOK_H]);
    translate([HOOK_Q*HOOK_T,-W, HOOK_T/2])
        T_cylinder(q=3);
}
hull() {
    translate([HOOK_T/2,0, HOOK_H])
        T_cylinder();
    translate([HOOK_L,0, HOOK_H])
        T_cylinder();
}

if(ADHESION_PAD)
        translate([L+3, 0, -THICKNESS/2])
            #rotate([-90, 0,0])
                cylinder(r=3, h=LAYER_HEIGHT);
    // difference() {
    //     translate([L, 0,1])
    //         rotate([-90])
    //             cylinder(r=3, h=LAYER_HEIGHT);
    //     translate([0,-EPS,-THICKNESS])
    //         cube([L+EPS, W, THICKNESS+EPS]);
    // }