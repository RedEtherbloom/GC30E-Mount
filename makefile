EXPORT_DIR = export
SCAD_FILE = mount.scad
EXTENSION = .stl
BASE_COMMAND = openscad

all: mkdir entropia complete

mkdir::
	mkdir -p $(EXPORT_DIR)

entropia: 
	$(BASE_COMMAND) -D MOUNT_OPEN_RIGHT=true -D LENGTH_PERCENTAGE=0.70 -o $(EXPORT_DIR)/$@$(EXTENSION) $(SCAD_FILE)
    
complete: 
	$(BASE_COMMAND) -o $(EXPORT_DIR)/$@$(EXTENSION) $(SCAD_FILE)

clean:
	rm -rf $(EXPORT_DIR)

.PHONY: all clean
