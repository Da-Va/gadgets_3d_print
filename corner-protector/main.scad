$fn = 90;

R = 10;
SPHERE_OFFSET = R/2/sqrt(3);
WALL_THICKNESS = 0.01;

CUT_OFFSET = 11;
// CUT_OFFSET = 7;

M = 50;

// #cube(2*R);
difference() {
    translate(SPHERE_OFFSET*[1,1,1]) {
        hull() {
            sphere(r=R);
            for(i=[0:2])
                rotate(i*120, [1,1,1])
                    translate([-SPHERE_OFFSET,-WALL_THICKNESS-SPHERE_OFFSET,-SPHERE_OFFSET]){
                        C = sqrt(2)*(R+sqrt(2)*SPHERE_OFFSET);
                        linear_extrude(WALL_THICKNESS)
                            polygon([[0,C],[C,0],[0,0]]);
                        // cube([C, C, WALL_THICKNESS]);
                    }
            }
    }

    cube(2*R);
    rotate([-atan2(sqrt(2), 1), 0, -45])
        translate([0,0,M/2+CUT_OFFSET])
            cube(M, center=true);
}