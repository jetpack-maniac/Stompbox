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
roundness = 1; // this is degree of roundness the corners get

// This covers the inputs and outputs of the box
jackSize = 0;
leftSideJacks = 0;
rightSideJacks = 0;

module enclosureBase(){

  edge = roundness*enclosureThickness;

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
      cylinder(r = edge, enclosureHeight - edge);
    translate([enclosureLength - edge, edge, 0])
      cylinder(r = edge, enclosureHeight - edge);
    translate([edge, enclosureWidth-edge, 0])
      cylinder(r = edge, enclosureHeight - edge);
    translate([enclosureLength - edge, enclosureWidth - edge, 0])
      cylinder(r = edge, enclosureHeight - edge);

    // replace the cut top corners with rounded edges
}

// Final Assembly

enclosureBase();
