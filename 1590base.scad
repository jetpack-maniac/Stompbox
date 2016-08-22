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
jackSize = 10;  // 10mm is close to 3/8", which is the proper hole for 1/4" jacks
leftSideJacks = 2;
rightSideJacks = 1;

// this covers the knobs and switches used
// two rows of knobs are created and one row of switches
topRowHoles = 1;
midRowHoles = 1;
bottomRowHoles = 2;
switchHoles = 1;
ledHoles = 2;

topRowVerticalAlign = 90;  // percentage of shift up, 90 is close to the top
midRowVerticalAlign = 75; // percentage of shift up, 75 is between the top and center
bottomRowVerticalAlign = 60; // percentage of shift up, 60 is just above center
ledVerticalAlign = 100; // percentage of shift up, 100 is on the edge
switchVerticalAlign = 20; // percentage of shift up, 20 is near the bottom

// The horizontal align shifts the rows side to side.  WIP/Unused.
/*topRowHorizontalAlign = 50; // percentage of shift side to side, 50 is centered
bottomRowHorizontalAlign = 50; // percentage of shift side to side, 50 is centered
ledHorizontalAlign = 50; // percentage of shift side to side, 50 is centered*/

topRowHoleSize = 5; // top row knob hole in mm, this is the standard size for switches (other than footswitches)
midRowHoleSize = 7.5; // mid row knob hole in mm, this is the standard size for pots
bottomRowHoleSize = 7.5; // bottom row knob hole in mm, this is the standard size for pots
switchHoleSize = 12; // the expected size in mm for standard footswitches
ledHoleSize = 5; // LED holes in mm, this is the normal size for LEDs
dcHoleSize = 12; // Typical DC jack size


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
    translate([topLength*(topRowVerticalAlign/100) + edge/2, (topWidth + 2*edge)*(topHole/(topRowHoles+1)), enclosureHeight - enclosureThickness - edge])
      cylinder(d = topRowHoleSize, h = enclosureThickness + edge, $fn = faces);
  }

  for(bottomHole = [1:bottomRowHoles]){
    translate([topLength*(bottomRowVerticalAlign/100) + edge/2, (topWidth + 2*edge)*(bottomHole/(bottomRowHoles+1)), enclosureHeight - enclosureThickness - edge])
      cylinder(d = bottomRowHoleSize, h = enclosureThickness + edge, $fn = faces);
  }

  for(midHole = [1:midRowHoles]){
    translate([topLength*(midRowVerticalAlign/100) + edge/2, (topWidth + 2*edge)*(midHole/(midRowHoles+1)), enclosureHeight - enclosureThickness - edge])
      cylinder(d = midRowHoleSize, h = enclosureThickness + edge, $fn = faces);
  }

  for(ledHole = [1:ledHoles]){
    translate([topLength*(ledVerticalAlign/100) + edge/2, (topWidth + 2*edge)*(ledHole/(ledHoles+1)), enclosureHeight - enclosureThickness - edge])
      cylinder(d = ledHoleSize, h = enclosureThickness + edge, $fn = faces);
  }

  for(input = [1:leftSideJacks]){
    translate([(topLength + edge)*(input/(leftSideJacks+1)), 0, (enclosureHeight - edge)/2])
    rotate([270,0,0])
      cylinder(d = jackSize, h = enclosureThickness + edge);
  }

  for(output = [1:rightSideJacks]){
    translate([(topLength + edge)*(output/(rightSideJacks+1)), enclosureWidth, (enclosureHeight - edge)/2])
    rotate([90,0,0])
      cylinder(d = jackSize, h = enclosureThickness + edge);
  }

  for(switch = [1:switchHoles]){
    translate([topLength*(switchVerticalAlign/100) + edge/2, (topWidth + 2*edge)*(switch/(switchHoles+1)), enclosureHeight - enclosureThickness - edge])
      cylinder(d = switchHoleSize, h = enclosureThickness + edge);
  }

  translate([enclosureLength, enclosureWidth/2, (enclosureHeight - edge)/2])
  rotate([0,270,0])
    cylinder(d = dcHoleSize, h = enclosureThickness + edge);
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
