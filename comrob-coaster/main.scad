$fn = 90;

// LOGO_FILE_NAME = "podtacek.svg";
// LOGO_FILE_NAME = "podtacek-clean-logo.svg";
LOGO_FILE_NAME = "podtacek-clean-logo-clean-text.svg";
// LOGO_FILE_NAME = "podtacek-technika-stencil-font.svg";
PART_BODY = false;
PART_INSERT = false;

EPS = 0.1;

H = 3;
D = 100;

LAYER_HEIGHT = 0.2;

INSERT_DEPTH = 2 * LAYER_HEIGHT;


module crl_logo(h, trim=false) {
    linear_extrude(h, convexity=10)
        import(LOGO_FILE_NAME, center=true);

    if(trim)
        difference() {
            cylinder(h = 10, d=2*D);
            cylinder(h = 40, d=D-EPS, center=true);
        }
}


module coaster_body() {
    difference() {
        cylinder(h = H, d = D);
        translate(v = [0,0, H - INSERT_DEPTH])
            crl_logo(2*INSERT_DEPTH, trim=true);
    }
}

module  coaster_insert() {
    translate([0, 0, H - INSERT_DEPTH]) {
        crl_logo(h = INSERT_DEPTH);
    }
}

module perimeter_modifier() {
    difference() {
        translate(v = [0,0, H - LAYER_HEIGHT]) 
        cylinder(h = 1, d=D);
        cylinder(h = 20, d=D-6, center=true);
    }
}

color(c = "#FFFFFF")
    if(!PART_INSERT) coaster_body();
color(c = "#0063bdff")
    if(!PART_BODY) coaster_insert();

// perimeter_modifier();
