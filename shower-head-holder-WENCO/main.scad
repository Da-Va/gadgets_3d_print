$fn = 90;

EPS=0.01;

MATING_D = 21;

HEAD_D = 20;
HEAD_d = 15;
HEAD_H = 30;
CLAW_THICKNESS = 4;

module base() {
    rotate([0, -90,0]) {
        %cylinder(d=MATING_D, h=4);
        translate([0, 0, 4])
            %cylinder(d=62, h=11);
    }
}

module hook() {
    difference() {
        hull(){
            rotate([0, 90,0])
                cylinder(d=MATING_D);
                
            translate([20, 0, -5])
                rotate([0, 35, 0])
                    cylinder(d1=HEAD_d+CLAW_THICKNESS, d2=HEAD_D+CLAW_THICKNESS, h=HEAD_H);
        }
        translate([20, 0, -5])
            rotate([0, 35, 0]) {
                translate([0,0,EPS])
                    cylinder(d1=HEAD_d, d2=HEAD_D, h=HEAD_H);
                cylinder(d=HEAD_d, h=3*HEAD_H, center=true);
            }
    }
}

base();
hook();