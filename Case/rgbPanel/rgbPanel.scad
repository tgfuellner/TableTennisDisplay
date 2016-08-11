// Case for RGB Panel

$fn=128;
CLEARANCE=0.3;


// Values for P5 Panel

WOOD_THICKNESS=6;
CASE_DEPTH_INSIDE=110;

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


module wallLeftRight() {
    cube([CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS, RGB_PANEL_HEIGHT+2*WOOD_THICKNESS, WOOD_THICKNESS], center=true); 
}

module wallTopBottom() {
    %cube([RGB_PANEL_WIDTH+2*WOOD_THICKNESS, CASE_DEPTH_INSIDE+RGB_PANEL_DEPTH+WOOD_THICKNESS, WOOD_THICKNESS], center=true); 
}

module wallBack() {
    %cube([RGB_PANEL_WIDTH+2*WOOD_THICKNESS, RGB_PANEL_HEIGHT+2*WOOD_THICKNESS, WOOD_THICKNESS], center=true);
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


rotate([90,0,0]) rgbPanel();

translate([(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,0])
    rotate([90,0,90]) wallLeftRight();

translate([-(WOOD_THICKNESS+RGB_PANEL_WIDTH)/2.0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,0])
    rotate([90,0,90]) wallLeftRight();

translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
    wallTopBottom();

translate([0,-(WOOD_THICKNESS+CASE_DEPTH_INSIDE)/2.0,-(WOOD_THICKNESS+RGB_PANEL_HEIGHT)/2.0])
    wallTopBottom();

translate([0,-CASE_DEPTH_INSIDE-(WOOD_THICKNESS+RGB_PANEL_DEPTH)/2.0])
    rotate([90,0,0]) wallBack();
