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

screwSize = 3.4;
screwLength = 10;

cornerThickness = 1.25;

// This covers the inputs and outputs of the box
jackSize = 0;
leftSideJacks = 0;
rightSideJacks = 0;

// this covers the knobs and switches used
// two rows of knobs are created and one row of switches
topRowHoles = 2;
bottomRowHoles = 2;
switchHoles = 1;

topRowHorizontalAlign = 50; // percentage of shift side to side, 50 is centered
bottomRowHorizontalAlign = 50; // percentage of shift side to side, 50 is centered
topRowVerticalAlign = 90;  // percentage of shift up, 80 is close to the top
bottomRowVerticalAlign = 70; // percentage of shift up, 60 is just above center

topRowHoleSize = 10; // top row knob hole in mm
bottomRowHoleSize = 10; // bottom row knob hole in mm


// variables used in the script
edge = roundness*enclosureThickness;
topLength = enclosureLength - 2*edge;
topWidth = enclosureWidth - 2*edge;

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

  // this adds the corner posts (order CCW) and requests screw tapping on them

  translate([enclosureThickness, enclosureThickness, 0])
     supportConstructor("corner");
  translate([enclosureLength - enclosureThickness, enclosureThickness, 0])
  rotate([0,0,90])
    supportConstructor("corner");
  translate([enclosureLength - enclosureThickness, enclosureWidth - enclosureThickness, 0])
  rotate([0,0,180])
    supportConstructor("corner");
  translate([enclosureThickness, enclosureWidth - enclosureThickness, 0])
  rotate([0,0,270])
    supportConstructor("corner");
}

module screwTapping(type){
  // these two cut exterior screwhead holes in the lid
  if(type == "case"){
    translate([enclosureThickness + 2*cornerThickness, enclosureThickness + 2*cornerThickness, 0])
      cylinder(d = screwSize, h = screwLength, $fn = faces);
    translate([enclosureLength - enclosureThickness - 2*cornerThickness, enclosureThickness + 2*cornerThickness,  0])
      cylinder(d = screwSize, h = screwLength, $fn = faces);
    translate([enclosureLength - enclosureThickness - 2*cornerThickness, enclosureWidth - enclosureThickness - 2*cornerThickness, 0])
      cylinder(d = screwSize, h = screwLength, $fn = faces);
    translate([enclosureThickness + 2*cornerThickness, enclosureWidth - enclosureThickness - 2*cornerThickness, 0])
      cylinder(d = screwSize, h = screwLength, $fn = faces);
  }

}

module holePunch(){
  // this cuts the knob and switch holes in the case
  for(topHole = [1:topRowHoles]){
    translate([topLength*(topRowVerticalAlign/100), topWidth*((topRowHorizontalAlign/100)*topHole/topRowHoles), enclosureHeight - enclosureThickness - edge])
      cylinder(d = topRowHoleSize, h = enclosureThickness + edge);
  }

  for(bottomHole = [1:bottomRowHoles]){
    translate([topLength*(bottomRowVerticalAlign/100), topWidth*((bottomRowHorizontalAlign/100)*bottomHole/topRowHoles), enclosureHeight - enclosureThickness - edge])
      cylinder(d = topRowHoleSize, h = enclosureThickness + edge);
  }
}

// Final Assembly

difference(){
  enclosureBase();
  mainBodyCut();
  holePunch();
}

difference(){
  interiorConstructor();
  screwTapping("case");
}
