// PRUSA iteration3
// X end prototype
// GNU GPL v3
// Josef Průša <iam@josefprusa.cz> and contributors
// http://www.reprap.org/wiki/Prusa_Mendel
// http://prusamendel.org

use <bearing.scad>
use <polyholes.scad>

function rodX_distance() = 45;

//function rodZ_distance() = 21;
function rodZ_distance() = 17; 

module x_end_base(){
  // Main block
  height = 58;
  translate(v=[-15-2.5,-9,height/2]) cube(size = [17,39,height], center = true);
  // Bearing holder
   vertical_bearing_base();	
  //Nut trap
   // Cylinder
     translate(v=[0,-rodZ_distance(),0]) poly_cylinder(h = 8, r=12.5, $fn=25);
   // Hexagon
   //translate(v=[0,-21,0]) rotate([0,0,30]) cylinder(h = 8, r=8, $fn = 6);
  //#translate(v=[-6,-10.6,10]) rotate([0,0,48.2]) cube(size = [10,5,1], center = true);
}
           
module x_end_belt_hole(size=46, spacer=0 ){
  difference(){
  	cube(size = [10-spacer,size,28-spacer], center = true);
  	// Nice edges
  	translate(v=[-5, 0, +23]) rotate([0,20,0]) cube(size = [10+spacer,size+1,28], center = true);
    translate(v=[ 5, 0, +23]) rotate([0,-20,0]) cube(size = [10+spacer,size+1,28], center = true);
    translate(v=[ 0, 0, -23]) rotate([0,45,0]) cube(size = [10+spacer,size+1,28], center = true);
  	translate(v=[ 0, 0, -23]) rotate([0,-45,0]) cube(size = [10+spacer,size+1,28], center = true);   
  }
}
           
module x_end_holes(){
 vertical_bearing_holes();
 // Belt hole
  translate(v=[-1,0,0]){
    // Stress relief
    translate(v=[-5.5-10+1.5-2.5,-10-1,30]) cube(size = [18,1,28], center = true);
    translate(v=[-5.5-10+1.5-2.5,-10,30]) x_end_belt_hole();
  }

// Bottom pushfit rod
translate(v=[-15-2.5,-41.5,6]) rotate(a=[-90,0,0]) pushfit_rod(7.8,50);
// Top pushfit rod
translate(v=[-15-2.5,-41.5,rodX_distance()+6]) rotate(a=[-90,0,0]) pushfit_rod(7.8,50);

// TR Nut trap
   // Hole for the nut
    translate(v=[0,-rodZ_distance(), -1]) poly_cylinder(h = 9.01, r = 5.3, $fn = 25);
    translate(v=[0,-rodZ_distance(), 46]) poly_cylinder(h = 12.01, r = 13, $fn = 40);

// Screw holes for TR nut
    translate(v=[0,-rodZ_distance(), 0]) rotate([0, 0, -135]) translate([0, 8, -1]) cylinder(h = 10, r = 1.55, $fn=25);
    translate(v=[0,-rodZ_distance(), 0]) rotate([0, 0, -135]) translate([0, -8, -1]) cylinder(h = 10, r = 1.55, $fn=25);

// Nut traps for TR nut screws
    translate(v=[0,-rodZ_distance(), 0]) rotate([0, 0, -135]) translate([0, 8, 6]) rotate([0, 0, 0])cylinder(h = 3, r = 3.3, $fn=6);

    translate(v=[0,-rodZ_distance(), 0]) rotate([0, 0, -135]) translate([0, -8, 6]) rotate([0, 0, 30])cylinder(h = 3, r = 3.2, $fn=6);
    translate([-5,-17.7,6]) rotate([0,0,30]) cube([5,5,3]);
    translate([-0,-17.7,6]) rotate([0,0,60]) cube([5,6,3]);
}


// Final prototype
module x_end_plain(){
 difference(){
  x_end_base();
  x_end_holes();
 }
}

x_end_plain();


module pushfit_rod(diameter,length){
 poly_cylinder(h = length, r=diameter/2);
 difference(){
 	translate(v=[0,-diameter/2.85,length/2]) rotate([0,0,45]) cube(size = [diameter/2,diameter/2,length], center = true);
 	translate(v=[0,-diameter/4-diameter/2-0.4,length/2]) rotate([0,0,0]) cube(size = [diameter,diameter/2,length], center = true);
 }
 //translate(v=[0,-diameter/2-2,length/2]) cube(size = [diameter,1,length], center = true);
}

