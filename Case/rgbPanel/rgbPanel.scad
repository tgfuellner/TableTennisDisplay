// Case for RGB Panel

CreateDxf = 0;    // Use with command line: openscad -DCreateDxf=1 -o all.dxf rgbPanel.scad

$fn=20;
CLEARANCE=0.3;
NOTCH_CLEARANCE = 1.002;
EPS=0.001;

WOOD_THICKNESS=6;
CASE_DEPTH_INSIDE=110;

BUTTON_R = 19/2;
BUTTON_EDGE = 35;
BACK_BUTTON_R = 16/2;
BACK_BUTTON_EDGE = 60;
POWERSWITCH_WIDTH = 8.5;
POWERSWITCH_HEIGHT = 13.2;
POWERSWITCH_EDGE = BUTTON_EDGE;

BALL_R = 39/2;
BALL_EDGE = 35;

OLED_WIDTH_HEIGHT = 33.5;
OLED_EDGE =23;

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
POWERBANK_HEIGHT = 41;
POWERBANK_WIDTH = 230;



// Seen from the back, referees sight
module wallLeft() {
  difference() {
    wallSide();

  }
}

module wallRight() {
  width = CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS;
  height = RGB_PANEL_HEIGHT+2*WOOD_THICKNESS;

  difference() {
    wallSide();

    translate([-POWERSWITCH_EDGE+width/2, -POWERSWITCH_EDGE+height/2, 0])
      cube([POWERSWITCH_WIDTH, POWERSWITCH_HEIGHT, WOOD_THICKNESS+CLEARANCE], center=true);
  }
}

module wallSide() {
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

    translate([BUTTON_EDGE-width/2, BUTTON_EDGE-height/2, 0])
      cylinder(r=BUTTON_R, h=WOOD_THICKNESS+CLEARANCE, center=true, $fn=70);

    translate([BACK_BUTTON_EDGE-width/2, BACK_BUTTON_EDGE-height/2, 0])
      cylinder(r=BACK_BUTTON_R, h=WOOD_THICKNESS+CLEARANCE, center=true, $fn=70);

  }
}

module wallTop() {
    height = CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS;
    difference() {
      wallTopBottom();

      translate([0, OLED_EDGE+(OLED_WIDTH_HEIGHT-height)/2])
        cube([OLED_WIDTH_HEIGHT, OLED_WIDTH_HEIGHT, WOOD_THICKNESS+CLEARANCE], center=true); 
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
module wallBottom() {
    width = RGB_PANEL_WIDTH+2*WOOD_THICKNESS;
    height = CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS;

    difference() {
      wallTopBottom();

      translate([BALL_EDGE-width/2, -BALL_EDGE+height/2, 0])
        cylinder(r=BALL_R, h=WOOD_THICKNESS+CLEARANCE, center=true, $fn=70);
      translate([-BALL_EDGE+width/2, -BALL_EDGE+height/2, 0])
        cylinder(r=BALL_R, h=WOOD_THICKNESS+CLEARANCE, center=true, $fn=70);
    }
}

module wallBack() {
    width = RGB_PANEL_WIDTH+2*WOOD_THICKNESS;
    height = RGB_PANEL_HEIGHT+2*WOOD_THICKNESS;
    r=10;
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

        minkowski() {
            union() {
              translate([0,POWERBANK_HEIGHT-RGB_PANEL_HEIGHT/2.0,0])
              cube([POWERBANK_WIDTH-2*r, POWERBANK_HEIGHT-2*r, WOOD_THICKNESS+CLEARANCE], center=true);
            }
            cylinder(r=r, h=WOOD_THICKNESS+CLEARANCE, $fn=70);
        }
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
        wallTop();

    translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,-(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
        wallBottom();

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
        wallTop();
    */

    translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,-(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
        wallBottom();

    /*
    translate([0,-d-CASE_DEPTH_INSIDE-(WOOD_THICKNESS+RGB_PANEL_DEPTH)/2.0])
        rotate([90,0,0]) wallBack();
    */
}

if (CreateDxf == 0) {
    wholeCase();
    //wallTop();
    //wholeCaseExploded();
    //wallBottom();
    //wallBack();
    //wallRight();
} else {
    projection(cut = true) {
        translate([160,105,0]) wallLeft();
        translate([160,-73,0]) wallRight();
        translate([-120,20,0]) rotate([0,0,90]) wallTop();
        translate([20,20,0]) rotate([0,0,90]) wallBottom();
        translate([-280,20,0]) rotate([0,0,90]) wallBack();
        translate([-305,-165,0]) rotate([0,0,90]) mountRight();
        translate([-185,-165,0]) rotate([0,0,90]) mountRight();
        translate([-65,-165,0]) rotate([0,0,90]) mountRight();
        translate([55,-175,0]) rotate([0,0,90]) mountRight();
        
        //color("red") translate([0,0,-5]) cube([750,400,2], center=true);
    }
}
