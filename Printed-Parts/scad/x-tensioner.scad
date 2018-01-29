
use <x-end.scad>

idler_screw = 4; //M4 or M3 screw
idler_width = 10.3;
idler_diameter = 15.2;
box_size = 14;

shift = 30-6-(rodX_distance())/2;
idler_pos = 30.25 - 30;

module x_tensioner(){
  difference(){
    union(){
      translate(v=[0,0,31/2]) rotate([90,0,0]) x_end_belt_hole(31, -0.35);
      translate(v=[0,shift,box_size/2]) cube(size = [18,rodX_distance()+12,box_size], center = true);
    }

    //cut for possible unperfect bridging in idler printed part
    translate(v=[0,-13.5-20,box_size+20]) cube(40, center = true);
    
    // belt hole
    translate(v=[0,idler_pos,20]) cube(size = [8,idler_diameter,50], center = true);

    // space for idler
    translate(v=[0,shift,0]) cube(size = [idler_width,33,10], center = true);
    translate(v=[0,idler_pos,5]) rotate([90,0,90]) cylinder(h = idler_width, r=idler_diameter/sqrt(3), $fn=6, center = true);
    
    // M3 screw holes for tensioner
    // note: include 0.2mm wall to make it printable. It must be removed after to use.
    translate(v=[0,shift,0]) union() {
      translate(v=[0,rodX_distance()/2,box_size-2]) cylinder(h = 3, r = 3.2, $fn=6);
      translate(v=[0,rodX_distance()/2,box_size-6]) cylinder(h = 40, r = 1.5, $fn=30);
      translate(v=[0,rodX_distance()/2,-1]) cylinder(box_size-(6-0.8), r = 3.3, $fn=30);
      translate(v=[0,-rodX_distance()/2,box_size-2]) cylinder(h = 3, r = 3.2, $fn=6);
      translate(v=[0,-rodX_distance()/2,box_size-6]) cylinder(h = 40, r = 1.5, $fn=30);
      translate(v=[0,-rodX_distance()/2,-1]) cylinder(h = box_size-(6-0.8), r = 3.3, $fn=30);
    }
    
    // idler screw hole
    translate(v=[-10,idler_pos,5]) {
      rotate([0,90,0]) {
        if (idler_screw == 4)
        {
          //M4
          cylinder(h = 40, r = 2.2, $fn=30);
          rotate([0,0,90]) cylinder(h = 3, d=7.8, $fn=6);
          translate(v=[0,0,17]) cylinder(h = 10, r=3.6, $fn=30);
        }

        if (idler_screw == 3)
        {
          //M3
          cylinder(h = 40, r = 1.6, $fn=30);
          rotate([0,0,90]) cylinder(h = 3, r=3.2, $fn=6);
          translate(v=[0,0,17]) cylinder(h = 10, r=3.2, $fn=30);
        }

      }
    }

    // save filament
    //rotate([0,45,0]) cube(size = [9,33,9], center = true);

    translate(v=[0,shift,0]) union() {
      translate (v=[0,0,5]) 
        rotate([90,0,0]) cylinder(h = 33, d = idler_width, $fn=6, center = true);
      translate (v=[-12,42,0]) rotate([0,0,45]) cube(30, center = true);
      translate (v=[-12,-42,0]) rotate([0,0,45]) cube(30, center = true);
      translate (v=[+12,42,0]) rotate([0,0,45]) cube(30, center = true);
      translate (v=[+12,-42,0]) rotate([0,0,45]) cube(30, center = true);
    }
  }
}

x_tensioner();