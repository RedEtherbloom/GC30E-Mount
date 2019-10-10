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
LENGTH_PERCENTAGE = 0.70;
MOUNT_LENGTH = GC30E_LENGTH * LENGTH_PERCENTAGE + THICKNESS + TOLERANCE;
MOUNT_WIDTH = GC30E_WIDTH + 2 * THICKNESS + TOLERANCE;
MOUNT_HEIGHT = GC30E_HEIGHT + THICKNESS + TOLERANCE;

module plugSlot() {
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

module base() {
    difference() {
        cube([MOUNT_WIDTH,
              MOUNT_LENGTH,
              MOUNT_HEIGHT]);
        translate([THICKNESS, THICKNESS, 0]) {
            cube([MOUNT_WIDTH - 2 * THICKNESS,
                  MOUNT_LENGTH - THICKNESS,
                  MOUNT_HEIGHT - THICKNESS]);
        } 
    }
}

difference() {
    base();
    echo(MOUNT_WIDTH/2);
    translate([MOUNT_WIDTH / 2 - GC30E_PLUG_DIAM / 2, 0, 0]) {
        plugSlot();
    }
}

echo(MOUNT_WIDTH);
