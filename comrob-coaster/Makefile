all : inlay.stl coaster.stl

inlay.stl : main.scad
	openscad -D PART_INSERT=true main.scad -o $@

coaster.stl : main.scad
	openscad -D PART_BODY=true main.scad -o $@
	
