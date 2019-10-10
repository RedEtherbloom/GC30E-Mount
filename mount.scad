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
THICKNESS = 3;
LENGTH_PERCENTAGE = 0.50;
MOUNT_LENGTH = GC30E_LENGTH * LENGTH_PERCENTAGE + THICKNESS + TOLERANCE;
MOUNT_WIDTH = GC30E_WIDTH + 2 * THICKNESS + TOLERANCE;
MOUNT_HEIGHT = GC30E_HEIGHT + THICKNESS + TOLERANCE;


module base() {
    difference() {
        cube([MOUNT_LENGTH,
              MOUNT_WIDTH,
              MOUNT_HEIGHT]);
        translate([THICKNESS, THICKNESS, 0]) {
            cube([MOUNT_LENGTH - 2 * THICKNESS,
                  MOUNT_WIDTH - THICKNESS,
                  MOUNT_HEIGHT - THICKNESS]);
        } 
    }
}

base();
