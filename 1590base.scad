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

// This covers the inputs and outputs of the box
jackSize = 0;
leftSideJacks = 0;
rightSideJacks = 0;

module enclosureBase(){
  // draw the shape out, cut the corners, cut screw holes
  difference(){
      cube([enclosureLength, enclosureWidth, enclosureHeight]);

      // this cuts the corner edges around the sides
      cube([3*enclosureThickness, 3*enclosureThickness, enclosureHeight]);
      translate([enclosureLength - 3*enclosureThickness, 0, 0])
        cube([3*enclosureThickness, 3*enclosureThickness, enclosureHeight]);
      translate([enclosureLength - 3*enclosureThickness, enclosureWidth - 3*enclosureThickness, 0])
        cube([3*enclosureThickness, 3*enclosureThickness, enclosureHeight]);
      translate([0, enclosureWidth - 3*enclosureThickness, 0])
        cube([3*enclosureThickness, 3*enclosureThickness,enclosureHeight]);
      /*screwTapping(); // screws are cut before the corners are filled back in*/

      // this cuts the corner edges around the top
      translate([0, 0, enclosureHeight - 3*enclosureThickness])
        cube([enclosureLength, 3*enclosureThickness, 3*enclosureThickness]);
      translate([0, enclosureWidth - 3*enclosureThickness, enclosureHeight - 3*enclosureThickness])
        cube([enclosureLength, 3*enclosureThickness, 3*enclosureThickness]);
      translate([0, 0, enclosureHeight - 3*enclosureThickness])
        cube([3*enclosureThickness, enclosureWidth, 3*enclosureThickness]);
      translate([enclosureLength - 3*enclosureThickness, 0, enclosureHeight - 3*enclosureThickness])
        cube([3*enclosureThickness, enclosureWidth, 3*enclosureThickness]);
    }

    // replace the cut side corners with rounded edges
    translate([3*enclosureThickness, 3*enclosureThickness, 0])
      cylinder(r = 3*enclosureThickness, enclosureHeight - 3*enclosureThickness);
    translate([enclosureLength - 3*enclosureThickness, 3*enclosureThickness, 0])
      cylinder(r = 3*enclosureThickness, enclosureHeight - 3*enclosureThickness);
    translate([3*enclosureThickness, enclosureWidth-3*enclosureThickness, 0])
      cylinder(r = 3*enclosureThickness, enclosureHeight - 3*enclosureThickness);
    translate([enclosureLength - 3*enclosureThickness, enclosureWidth - 3*enclosureThickness, 0])
      cylinder(r = 3*enclosureThickness, enclosureHeight - 3*enclosureThickness);

    // replace the cut top corners with rounded edges
}

// Final Assembly

enclosureBase();
