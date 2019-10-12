// By GityUpNow(2019). Licensed under the MIT License
// All units are in millimeters

//Constants
//Accuracy
$fn = 60;
TOLERANCE = 3;

//GC30E
GC30E_LENGTH = 107.5;
GC30E_WIDTH = 67;
GC30E_HEIGHT = 36;
GC30E_PLUG_DIAM = 14 + TOLERANCE;

//Mount
THICKNESS = 2;
LENGTH_PERCENTAGE = 0.70;
MOUNT_LENGTH = GC30E_LENGTH * LENGTH_PERCENTAGE + THICKNESS + TOLERANCE;
MOUNT_WIDTH = GC30E_WIDTH + 2 * THICKNESS + TOLERANCE;
MOUNT_HEIGHT = GC30E_HEIGHT + THICKNESS + TOLERANCE;

//Power-LED
LED_OVERSCALE = 2;
LED_MIDDLE_X = 11 + TOLERANCE / 2;
LED_MIDDLE_Y = 10 + TOLERANCE / 2;
LED_WIDTH = 3;
LED_LENGTH = 5;

//Screw-Tap
TAP_WIDTH = 20;
TAP_LENGTH = 12;
TAP_TOLERANCE = 1;
TAP_SCREW_DIAM = 4 + TAP_TOLERANCE;
TAP_SCREW_TOP_DIAM = 9 + TAP_TOLERANCE;
TAP_PYRA_DEPTH = 4;
TAP_ANGLE = 30;
TAP_ANGLE_LENGTH = TAP_LENGTH * tan(TAP_ANGLE);
TAP_LENGTH_W_ANGLE = TAP_LENGTH + 2 * TAP_ANGLE_LENGTH;

//Options
MOUNT_OPEN_END = true;
MOUNT_OPEN_RIGHT = false;
LED_ENABLED = true;
TAP_LEFT = true;
TAP_RIGHT = false;
TAP_START = true;
TAP_END = false;

module plugSlot() {
    translate([MOUNT_WIDTH / 2 - GC30E_PLUG_DIAM / 2, 0, 0]) {
        mirror(v = [0, 1, 0]) {
            rotate(a = [90, 0, 0]) {
                linear_extrude(THICKNESS) {
                    square([GC30E_PLUG_DIAM, MOUNT_HEIGHT / 2]);
                    translate([GC30E_PLUG_DIAM / 2, MOUNT_HEIGHT / 2]) { 
                        circle(d = GC30E_PLUG_DIAM);
                    }
                }
            }
        }
    }
}

module ledHole() {
    width = LED_WIDTH * LED_OVERSCALE;
    length = LED_LENGTH * LED_OVERSCALE;
    
    offset_x = GC30E_WIDTH - LED_MIDDLE_X - width/2 - THICKNESS;
    offset_y = GC30E_LENGTH - LED_MIDDLE_Y - length/2 - THICKNESS;

    translate([offset_x,
               offset_y,
               MOUNT_HEIGHT - THICKNESS]) {
        cube([width,
              length,
              THICKNESS]);
    }
}

module screwTap() {
    screw_middle_x = TAP_WIDTH * 2 / 3;
    screw_middle_y = TAP_LENGTH / 2;
    thickness = 2 * THICKNESS;

    translate([THICKNESS,
               TAP_ANGLE_LENGTH,
               0]) { 
        difference() {
            hull() {
                cube([TAP_WIDTH,
                      TAP_LENGTH,
                      thickness]);
                translate([-THICKNESS, 
                           -TAP_ANGLE_LENGTH,
                           0]) {
                    cube([THICKNESS,
                          TAP_LENGTH_W_ANGLE,
                          thickness]);
                }
            }
            
            translate([screw_middle_x,
                       screw_middle_y,
                       0]) {
                cylinder(d = TAP_SCREW_DIAM, h = thickness);
                translate([0, 0, thickness - TAP_PYRA_DEPTH]) {

                }
            }
        }
    }
}

module base() {
    difference() {
        cube([MOUNT_WIDTH,
              MOUNT_LENGTH,
              MOUNT_HEIGHT]);
       
        
        diff_length = (!MOUNT_OPEN_END && LENGTH_PERCENTAGE == 1.00) ? 2 * THICKNESS : 0;
        diff_width = (MOUNT_OPEN_RIGHT) ? THICKNESS : 2 * THICKNESS;        
 
        echo(diff_length);
        translate([THICKNESS, THICKNESS, 0]) {
            cube([MOUNT_WIDTH - diff_width,
                  MOUNT_LENGTH - diff_length,
                  MOUNT_HEIGHT - THICKNESS]);
        } 
    }
}

difference() {
    base();
    
    plugSlot();
    if (LENGTH_PERCENTAGE == 1.0) {
        translate([0, MOUNT_LENGTH - THICKNESS, 0]) {
            plugSlot();
        }
    }

    if (LED_ENABLED) {
        ledHole();
    } 
}

!screwTap();
