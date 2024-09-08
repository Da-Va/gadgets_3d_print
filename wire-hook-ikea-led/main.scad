$fn = 90;

M = 100;

LED_STRIP_T = 6;
GAP = 5;

BASE_T = 1;
BASE_H = LED_STRIP_T;
BASE_W = BASE_H;

module hook() {
    cube([BASE_T, BASE_W, BASE_H]);
    translate([BASE_H/2,0, BASE_H/2])rotate([-90,0,0])
        difference() {
            cylinder(d=BASE_H, h = BASE_W);
            cylinder(d=BASE_H-2*BASE_T, h = BASE_W);
            translate([-M/2,0,0])cube(M);
        }
    translate([BASE_H-BASE_T/2,0,BASE_H/2])rotate([-90,0,0])
        cylinder(d=BASE_T, h = BASE_W);
}


hook();