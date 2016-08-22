// This is a model based on the commonly used stompbox enclosure for guitar and
// hobbyist electronic projects.  It is configurable and does not need to be
// drilled out like a normal case, in fact it's not recommended as it will
// affect the infill of the unit.  Specify the holes you want and you need only
// print it and put your electronics in.

// All sizes are in mm (millimeters)

enclosureLength = 112; // length along x axis
enclosureWidth = 60; // width along y axis
enclosureHeight = 38; // enclosureHeight along z axis
enclosureThickness = 2; // this is the thickness of each side
roundness = 2; // this is degree of roundness the corners get
faces = 40; // this is how detailed the curved edges get

// This covers the inputs and outputs of the box
jackSize = 0;
leftSideJacks = 0;
rightSideJacks = 0;

// variables used in the script
edge = roundness*enclosureThickness;

module enclosureBase(){

  // draw the shape out, cut the corners, cut screw holes
  difference(){
      cube([enclosureLength, enclosureWidth, enclosureHeight]);

      // this cuts the corner edges around the sides
      cube([edge, edge, enclosureHeight]);
      translate([enclosureLength - edge, 0, 0])
        cube([edge, edge, enclosureHeight]);
      translate([enclosureLength - edge, enclosureWidth - edge, 0])
        cube([edge, edge, enclosureHeight]);
      translate([0, enclosureWidth - edge, 0])
        cube([edge, edge,enclosureHeight]);
      /*screwTapping(); // screws are cut before the corners are filled back in*/

      // this cuts the corner edges around the top
      translate([0, 0, enclosureHeight - edge])
        cube([enclosureLength, edge, edge]);
      translate([0, enclosureWidth - edge, enclosureHeight - edge])
        cube([enclosureLength, edge, edge]);
      translate([0, 0, enclosureHeight - edge])
        cube([edge, enclosureWidth, edge]);
      translate([enclosureLength - edge, 0, enclosureHeight - edge])
        cube([edge, enclosureWidth, edge]);
    }

    // replace the cut side corners with rounded edges
    translate([edge, edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);
    translate([enclosureLength - edge, edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);
    translate([edge, enclosureWidth-edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);
    translate([enclosureLength - edge, enclosureWidth - edge, 0])
      cylinder(r = edge, enclosureHeight - edge, $fn = faces);

    // replace the cut top corners with rounded edges
    translate([edge, edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([enclosureLength - edge, edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([edge, enclosureWidth-edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);
    translate([enclosureLength - edge, enclosureWidth - edge, enclosureHeight - edge])
      sphere(r = edge, $fn = faces);

    // this lays the long curved edges, starts with origin going CCW
    translate([edge, edge, enclosureHeight - edge])
    rotate([0,90,0])
      cylinder(r = edge, enclosureLength - 2*edge, $fn = faces);
    translate([enclosureLength - edge, edge, enclosureHeight - edge])
    rotate([270,0,0])
      cylinder(r = edge, enclosureWidth - 2*edge, $fn = faces);
    translate([enclosureLength - edge, enclosureWidth - edge, enclosureHeight - edge])
    rotate([0,270,0])
      cylinder(r = edge, enclosureLength - 2*edge, $fn = faces);
    translate([edge, enclosureWidth-edge, enclosureHeight - edge])
    rotate([90,0,0])
      cylinder(r = edge, enclosureWidth - 2*edge, $fn = faces);

}

module mainBodyCut(){

  // cuts the interior open
  translate([enclosureThickness, enclosureThickness, 0])
    cube([enclosureLength - 2*enclosureThickness, enclosureWidth - 2*enclosureThickness, enclosureHeight - 2*enclosureThickness]);
}

module supportConstructor(type){

  if(type == "corner"){
    cornerThickness = 2;
    union(){
      translate([0, 4*cornerThickness, 0])
        cube([4*cornerThickness, cornerThickness, enclosureHeight - cornerThickness]);
      cube([5*cornerThickness, 4*cornerThickness, enclosureHeight - cornerThickness]);
      translate([4*cornerThickness, 4*cornerThickness, 0])
        cylinder(r = cornerThickness, enclosureHeight - cornerThickness, $fn = faces);
    }
  }
}


module interiorConstructor(){

  // this adds the corner posts and requests screw tapping on them

  translate([3*enclosureThickness, 3*enclosureThickness, 0])
     supportConstructor("corner");



}

// Final Assembly

difference(){
  enclosureBase();
  mainBodyCut();
}
