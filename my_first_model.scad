$fn=90;

pp_len = 2.5;

difference() {
    union() {
        // ball 1
        sphere();

        //ball 2
        translate([1,0,0]){
            sphere();
        }

        // shaft
        translate([0.5,0.5,0]){
            cylinder(r=0.5, h=pp_len);
            sphere(r=0.5);
            translate([0,0,pp_len]){
                sphere(r=0.5);
            }
        }
    }

    translate([0,5+0.8,0]) {
        cube(10, true);
    }
}