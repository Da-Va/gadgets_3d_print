$fn = 90;

r1 = 19/2;
r2 = 21.2/2;
h1 = 2.74;
h2 = 4.17;

side = (h1/2 + (h2 - h1)) * sqrt(2);

L = 100;

module nato_rail() {
    hull() for(s=[1,-1])
        translate([s*r2,0,0]) rotate([0,45-180,0])
            cube([side,L,side]);
    
}


nato_rail();