$fn = 90;
EPS = 0.1;

module rounded_prism(w, h, l) {
    d = h;
    w_ = w - d;
    h_ = h;
    l_ = l;
    cube([w_, h_, l_]);
    translate([0, d/2, 0]) {
        cylinder(d=d, h=l);
        translate([w_ ,0,0])
            cylinder(d=d, h=l);
    }
}

module sleeve(w, h, l, t) {

    translate([h/2, -h/2, 0]) {
        difference() {
            translate([0, -t, 0])
                rounded_prism(w + 2*t, h + 2*t, l);
            translate([0, 0, -EPS])
                rounded_prism(w, h, l+2*EPS);
        }

        connector_w = 2;
        translate([w-h/2, h/2-connector_w/2, 0])
            #cube([10,connector_w,1]);
    }
}


module main() {
    for(i = [0:3-1]) 
        translate([20*i, 0,0])
        sleeve(10, 5, 20, 1);
}

main();