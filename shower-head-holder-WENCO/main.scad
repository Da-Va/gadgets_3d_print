$fn = 90;

EPS=0.01;
M = 100;

MATING_D = 21;

HEAD_D = 20;
HEAD_d = 15;
HOSE_D = 13;
HEAD_H = 30;
CLAW_THICKNESS = 4;
CLAW_Z_OFFSET = -5;
CLAW_ANGLE = 35;

module base() {
    rotate([0, -90,0]) {
        %cylinder(d=MATING_D, h=4);
        translate([0, 0, 4])
            %cylinder(d=62, h=11);
    }
}

module head() {
    %CLAW_TRANSFORM() {
        translate([0,0,EPS])
            cylinder(d1=HEAD_d, d2=HEAD_D, h=HEAD_H);
        translate([0,0,HEAD_H])
            cylinder(d=HEAD_D, h=150);
    }
}

module CLAW_TRANSFORM() {
    translate([20, 0, CLAW_Z_OFFSET])
        rotate([0, CLAW_ANGLE, 0])
            children();
}

module cut() {
    CLAW_TRANSFORM() {
        translate([0,0,EPS])
            cylinder(d1=HEAD_d, d2=HEAD_D, h=HEAD_H);
        cylinder(d=HEAD_d, h=3*HEAD_H, center=true);
        translate([HEAD_D/2, 0,0]) 
            cube([HOSE_D ,HOSE_D,3*HEAD_H], center=true);
    }
    
    translate([0,0,M/2 + cos(CLAW_ANGLE)*HEAD_H + CLAW_Z_OFFSET]) 
        cube(M, center=true);
    translate([0,0,-M/2 - cos(45)*MATING_D/2]) 
        cube(M, center=true);
}

module joint_cut() {
    rotate([0, 90, 0]) {
        hull() for(i=[0:1]) {
            translate([i*10,0,-EPS]) 
                cylinder(d=7, h=6);
        }
        hull() for(i=[0:1]) {
            translate([i*10,0,3]) 
                cylinder(d=10, h=3);
        }
    }
}

module hook() {
    difference() {
        hull(){
            rotate([0, 90,0])
                cylinder(d=MATING_D);
                
            CLAW_TRANSFORM()
                cylinder(d1=HEAD_d+CLAW_THICKNESS, d2=HEAD_D+CLAW_THICKNESS, h=HEAD_H);
        }
        cut();
        joint_cut();
    }
}

base();
hook();
head();