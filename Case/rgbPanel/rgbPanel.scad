// Case for RGB Panel

$fn=20;
CLEARANCE=0.3;
NOTCH_CLEARANCE = 1.002;
EPS=0.001;

WOOD_THICKNESS=6;
CASE_DEPTH_INSIDE=110;

// Values for P5 Panel

RGB_PANEL_WIDTH=320;
RGB_PANEL_HEIGHT=159;
RGB_PANEL_DEPTH=14;
RGB_PANEL_R_MOUNTING_HOLES=3/2.0;
RGB_PANEL_DEPTH_MOUNTING_HOLES=10;
RGB_PANEL_EDGE_SMALL=11;
RGB_PANEL_EDGE_BIG=37;

//                                                                           +---   RGB_PANEL_EDGE_BIG
//                                                                           |
// +------------------------- RGB_PANEL_WIDTH -------------------------------+---+
// |                                                                         |   |
// |                                        o RGB_B                          |   |
// |                                                                         v   |
// |   o RGB_A                                                         RGB_C o<--+  RGB_PANEL_EDGE_SMALL
// |                                                                             | 
// |                                                                             |
// |                                                                      RGB_PANEL_HEIGHT
// |                                                                             |
// |                                                                             |
// |                                                                             |
// |                                                                             |
// |   o RGB_F                                                         RGB_D o   |
// |                                                                             |
// |                                        o RGB_E                              |
// |                                                                             |
// +-----------------------------------------------------------------------------+

// RGB_A - RGB_F: Mounting Holes width Diameter RGB_PANEL_R_MOUNTING_HOLES

MOUNT_IN = 19;
MOUNT_LENGTH = RGB_PANEL_HEIGHT - 2*RGB_PANEL_EDGE_BIG + 2*15;


// Hole for USB Powerbank
POWERBANK_HEIGHT = 30;
POWERBANK_WIDTH = 90;
FINGER_WIDTH = 10;

// Seen from the back, referees sight
module wallLeft() {
  r=3;
  difference() {
    wallRight();

    minkowski() {
        union() {
          translate([-5,POWERBANK_HEIGHT-RGB_PANEL_HEIGHT/2.0,0])
          cube([POWERBANK_WIDTH-2*r, POWERBANK_HEIGHT-2*r, WOOD_THICKNESS+CLEARANCE], center=true);
          translate([-5,5+(POWERBANK_HEIGHT-RGB_PANEL_HEIGHT)/2.0,0])
          cube([FINGER_WIDTH-2*r, POWERBANK_HEIGHT-2*r, WOOD_THICKNESS+CLEARANCE], center=true);
        }
        cylinder(r=r, WOOD_THICKNESS+CLEARANCE);
    }
  }
}

module wallRight() {
  width = CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS;
  height = RGB_PANEL_HEIGHT+2*WOOD_THICKNESS;

  difference() {
    cube([width, height, WOOD_THICKNESS], center=true); 

    translate([0, (-WOOD_THICKNESS+height)/2.0, 0])
      createNotches(10, width, WOOD_THICKNESS, WOOD_THICKNESS);
    translate([0, -(-WOOD_THICKNESS+height)/2.0, 0])
      createNotches(10, width, WOOD_THICKNESS, WOOD_THICKNESS);

    translate([-(-WOOD_THICKNESS+width)/2.0-EPS, 0, 0])
      rotate(90,0,0) createNotches(6,height, WOOD_THICKNESS, WOOD_THICKNESS);

    translate([-RGB_PANEL_DEPTH+(-WOOD_THICKNESS+width)/2.0,0,MOUNT_IN/2.0])
      rotate([0,90,0]) scale(NOTCH_CLEARANCE) mountRight();
  }
}

module wallTopBottom() {
    width = RGB_PANEL_WIDTH+2*WOOD_THICKNESS;
    height = CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS;
    ly = CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS;
    case_height = RGB_PANEL_HEIGHT+2*WOOD_THICKNESS;
    difference() {
      cube([width, height, WOOD_THICKNESS], center=true); 

      translate([0, (WOOD_THICKNESS-height)/2.0-EPS, 0])
        createNotches(8, width, WOOD_THICKNESS, WOOD_THICKNESS);
      translate([-(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,0,(-WOOD_THICKNESS+case_height)/2.0])
        rotate([90,0,90]) scale(NOTCH_CLEARANCE) wallLeft();
      translate([(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,0,(-WOOD_THICKNESS+case_height)/2.0])
        rotate([90,0,90]) scale(NOTCH_CLEARANCE) wallLeft();

      translate([0,-RGB_PANEL_DEPTH+(-WOOD_THICKNESS+ly)/2.0,MOUNT_IN/2.0])
        rotate([0,90,90]) scale(NOTCH_CLEARANCE) mountRight();
    }
}

module wallBack() {
    width = RGB_PANEL_WIDTH+2*WOOD_THICKNESS;
    height = RGB_PANEL_HEIGHT+2*WOOD_THICKNESS;
    difference() {
        cube([width, height, WOOD_THICKNESS], center=true);

        translate([(WOOD_THICKNESS-width)/2.0,0,-(CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH)/2.0])
          rotate([0,90,0]) scale(NOTCH_CLEARANCE) wallRight();
        translate([-(WOOD_THICKNESS-width)/2.0,0,-(CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH)/2.0])
          rotate([0,90,0]) scale(NOTCH_CLEARANCE) wallRight();

        translate([0,(WOOD_THICKNESS-height)/2.0, (CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH)/2.0])
          rotate([90,0,0]) scale(NOTCH_CLEARANCE) wallTopBottom();
        translate([0,-(WOOD_THICKNESS-height)/2.0, (CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH)/2.0])
          rotate([90,0,0]) scale(NOTCH_CLEARANCE) wallTopBottom();
    }
}


//                                 |
// Aussparungen mit difference     |
// erzeugen                        v
// -----+   +-----+   +-----+   +----- 
//      +---+     +---+     +---+  into
//                                 ^
//                                 |
//                                  
// <------------- width -------------> 
// count = 3  Nr of Notches to create
// z = Thickness of Material to cut

module createNotches(count, width, into, z) {
    notchWidth = width/count;

    for (n = [1:2:count]) {
      translate([notchWidth*n-width/2.0,0,0])
        cube([notchWidth, into, z+CLEARANCE], center=true);
    }
}

module mountRight() {
    xl = MOUNT_IN+WOOD_THICKNESS;
    difference() {
      cube([xl, MOUNT_LENGTH,WOOD_THICKNESS], center=true);

      translate([(xl-WOOD_THICKNESS)/2.0+EPS, 0, 0])
        rotate([0,0,90]) createNotches(10, MOUNT_LENGTH, WOOD_THICKNESS, WOOD_THICKNESS);

      translate([-WOOD_THICKNESS-RGB_PANEL_EDGE_SMALL+xl/2.0, -RGB_PANEL_EDGE_BIG+RGB_PANEL_HEIGHT/2.0, 0])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES+CLEARANCE, h=100, center=true);
      translate([-WOOD_THICKNESS-RGB_PANEL_EDGE_SMALL+xl/2.0, RGB_PANEL_EDGE_BIG-RGB_PANEL_HEIGHT/2.0, 0])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES+CLEARANCE, h=100, center=true);
      translate([-WOOD_THICKNESS-RGB_PANEL_EDGE_SMALL+xl/2.0, 0, 0])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES+CLEARANCE, h=100, center=true);
    }
}

module mountLeft() {
    mirror([1,0,0]) mountRight();
}


module rgbPanel() {
  difference() {
    color("Gray") cube([RGB_PANEL_WIDTH, RGB_PANEL_HEIGHT, RGB_PANEL_DEPTH], center=true);

    // RGB_A
    translate([RGB_PANEL_EDGE_SMALL-RGB_PANEL_WIDTH/2.0, -RGB_PANEL_EDGE_BIG+RGB_PANEL_HEIGHT/2.0,-RGB_PANEL_DEPTH/2.0+(RGB_PANEL_DEPTH-RGB_PANEL_DEPTH_MOUNTING_HOLES)])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES, h=RGB_PANEL_DEPTH_MOUNTING_HOLES+CLEARANCE);
    // RGB_B
    translate([0, -RGB_PANEL_EDGE_SMALL+RGB_PANEL_HEIGHT/2.0,-RGB_PANEL_DEPTH/2.0+(RGB_PANEL_DEPTH-RGB_PANEL_DEPTH_MOUNTING_HOLES)])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES, h=RGB_PANEL_DEPTH_MOUNTING_HOLES+CLEARANCE);
    // RGB_C
    translate([-RGB_PANEL_EDGE_SMALL+RGB_PANEL_WIDTH/2.0, -RGB_PANEL_EDGE_BIG+RGB_PANEL_HEIGHT/2.0,-RGB_PANEL_DEPTH/2.0+(RGB_PANEL_DEPTH-RGB_PANEL_DEPTH_MOUNTING_HOLES)])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES, h=RGB_PANEL_DEPTH_MOUNTING_HOLES+CLEARANCE);
    // RGB_D
    translate([-RGB_PANEL_EDGE_SMALL+RGB_PANEL_WIDTH/2.0, RGB_PANEL_EDGE_BIG-RGB_PANEL_HEIGHT/2.0,-RGB_PANEL_DEPTH/2.0+(RGB_PANEL_DEPTH-RGB_PANEL_DEPTH_MOUNTING_HOLES)])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES, h=RGB_PANEL_DEPTH_MOUNTING_HOLES+CLEARANCE);
    // RGB_E
    translate([0, RGB_PANEL_EDGE_SMALL-RGB_PANEL_HEIGHT/2.0,-RGB_PANEL_DEPTH/2.0+(RGB_PANEL_DEPTH-RGB_PANEL_DEPTH_MOUNTING_HOLES)])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES, h=RGB_PANEL_DEPTH_MOUNTING_HOLES+CLEARANCE);
    // RGB_F
    translate([RGB_PANEL_EDGE_SMALL-RGB_PANEL_WIDTH/2.0, RGB_PANEL_EDGE_BIG-RGB_PANEL_HEIGHT/2.0,-RGB_PANEL_DEPTH/2.0+(RGB_PANEL_DEPTH-RGB_PANEL_DEPTH_MOUNTING_HOLES)])
        cylinder(r=RGB_PANEL_R_MOUNTING_HOLES, h=RGB_PANEL_DEPTH_MOUNTING_HOLES+CLEARANCE);
  }
}

module wholeCase() {

    rotate([90,0,0]) rgbPanel();

    translate([(RGB_PANEL_WIDTH-MOUNT_IN+WOOD_THICKNESS)/2.0, (-RGB_PANEL_DEPTH-WOOD_THICKNESS)/2.0, 0])
        rotate([90,0,0]) mountRight();

    translate([(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,0])
        rotate([90,0,90]) wallRight();

    translate([-(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,0])
        rotate([90,0,90]) wallLeft();

    translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
        wallTopBottom();

    translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,-(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
        wallTopBottom();

    translate([0,-CASE_DEPTH_INSIDE-(WOOD_THICKNESS+RGB_PANEL_DEPTH)/2.0])
        rotate([90,0,0]) wallBack();
}

module wholeCaseExploded() {
    d=10;

    rotate([90,0,0]) rgbPanel();

    translate([(RGB_PANEL_WIDTH-MOUNT_IN+WOOD_THICKNESS)/2.0, (-RGB_PANEL_DEPTH-WOOD_THICKNESS)/2.0, 0])
        rotate([90,0,0]) mountRight();

    translate([d+(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,0])
        rotate([90,0,90]) wallRight();

    translate([-(RGB_PANEL_WIDTH-MOUNT_IN+WOOD_THICKNESS)/2.0, (-RGB_PANEL_DEPTH-WOOD_THICKNESS)/2.0, 0])
        rotate([90,0,0]) mountLeft();

    translate([-d-(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,0])
        rotate([90,0,90]) wallLeft();

    translate([0, (-RGB_PANEL_DEPTH-WOOD_THICKNESS)/2.0, (RGB_PANEL_HEIGHT+WOOD_THICKNESS-MOUNT_IN)/2.0])
        rotate([90,-90,0]) mountRight();

    translate([0, (-RGB_PANEL_DEPTH-WOOD_THICKNESS)/2.0, (-RGB_PANEL_HEIGHT-WOOD_THICKNESS+MOUNT_IN)/2.0])
        rotate([90,90,0]) mountRight();

    /*
    translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
        wallTopBottom();
    */

    translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,-(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
        wallTopBottom();

    /*
    translate([0,-d-CASE_DEPTH_INSIDE-(WOOD_THICKNESS+RGB_PANEL_DEPTH)/2.0])
        rotate([90,0,0]) wallBack();
    */
}


//wholeCase();
wholeCaseExploded();
//wallTopBottom();

//wallBack();

//wallRight();
