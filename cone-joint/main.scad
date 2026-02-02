$fn = 100;
EPS = 0.01;

HEIGHT = 20;

D1 = 20;
d2 = 10;

WALL_THICKNESS = 3 * 0.3 ;

difference() {
    union(){
        cylinder(d1=D1, d2=d2, h=HEIGHT);
        translate([-D1*1.5/2, -WALL_THICKNESS/2, 0])
            cube([D1*1.5, WALL_THICKNESS, HEIGHT]);
    }
    minkowski() {
        cylinder(d1=D1-2*WALL_THICKNESS, d2=d2-2*WALL_THICKNESS, h=HEIGHT);
        sphere(r=EPS);
    }
}

