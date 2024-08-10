$fn = 90;

M = 100;

KEY_WIDTH = 2.5;
KEY_D = 25;
KEY_COMB_H = 11;
KEY_L = KEY_D + 30;

HANDLE_R = 8;
HANDLE_FACE_OFFSET = 1.5;

SPRING_STROKE = 6;
SPRING_THICKNESS = 1;
SPRING_WIDTH = 5;
SPRING_N=8;

module key() {
    translate([0,0,-KEY_WIDTH/2]) {
        cylinder(d=KEY_D, h=KEY_WIDTH);
        translate([-KEY_COMB_H/2, 0,0])
            cube([KEY_COMB_H, KEY_L, KEY_WIDTH]);
    }
}

module spring(stroke,thickenss,height,width,N) {
    gap_w = stroke/N;
    d = 2*thickenss+gap_w;
    for(i=[0:N]) {
        o = i==0 || i==N ? 0 : d;
        translate([i*(thickenss+gap_w), o/2,0])
            cube([thickenss, width-o, height]);
    }
    for(i=[1:N]) {
        q = i%2;
        translate([i*(thickenss+gap_w)-gap_w/2, q*(width-d)+d/2,0])
        rotate([0,0,q*180])
            difference() {
                cylinder(d=d, h=height);
                cylinder(d=gap_w,h=height);
                translate([-M/2,0,0]) cube(M);
            }
    }
}

module m3_bolt() {
    h = -HANDLE_R+HANDLE_FACE_OFFSET;
    translate([0,0,h]) {
        cylinder(d=3,h=2*-h);    
        cylinder(d=6,h=3.5);
        translate([0,0,-2*h]) mirror([0,0,1])
            cylinder(d=6.5,h=2.4, $fn=6);
    }
}

module spring_module() {
    translate([-SPRING_WIDTH/2, KEY_D/2+SPRING_STROKE,KEY_WIDTH/2])
    rotate([0,0,-90])
        spring(
            stroke=SPRING_STROKE,
            thickenss=SPRING_THICKNESS,
            height = HANDLE_R - HANDLE_FACE_OFFSET-KEY_WIDTH/2,
            width = SPRING_WIDTH,
            N=SPRING_N
        );

}

module spring_clearance() {
    l = SPRING_STROKE + SPRING_N*SPRING_THICKNESS;
    spring_clearance = 0.2;
    translate([
        -SPRING_WIDTH/2-spring_clearance,
        KEY_D/2+SPRING_STROKE-l,
        KEY_WIDTH/2]
    ) cube([
            SPRING_WIDTH+2*spring_clearance,
            M,
            HANDLE_R-HANDLE_FACE_OFFSET-KEY_WIDTH/2]
        );
    translate([0,1+KEY_D/2-SPRING_WIDTH,0]) rotate([0,0,45])
        cube(10);
}

module handle() {
    difference() {
        hull() {
            translate([0, KEY_D/2, 0]) rotate([90, 0,0])
                cylinder(r=HANDLE_R, h = 1);
            translate(KEY_D/2*[1,-0.5,0])
                sphere(HANDLE_R);
            translate(KEY_D/2*[-1,-0.5,0])
                sphere(HANDLE_R);
        }
    ////        
        key();
        offset = HANDLE_FACE_OFFSET;
        translate([0,0,(M/2+HANDLE_R-offset)]) cube(M, center=true);
        translate([0,0,-(M/2+HANDLE_R-offset)]) cube(M, center=true);
        translate(1.1*KEY_D/2*[1,-0.5,0])
            m3_bolt();
        translate(1.1*KEY_D/2*[-1,-0.5,0])
            m3_bolt();
        spring_clearance();
    } 
    spring_module();
}


////////////////////////////////////////////////////////////
%key();

difference() {
    handle();
    translate([0,0,M/2])
        cube(M,center=true);
}
intersection() {
    handle();
    translate([0,0,M/2])
        cube(M,center=true);
}