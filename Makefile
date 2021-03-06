# GNU makefile. This compiles to Java at need and combines bundled
# YAML configuration files into demonstration models of the DMOTE.
# https://www.gnu.org/software/make/manual/make.html

.PHONY: default visualization orthographic flat threaded threaded-visualization solid all test clean

OBJECTS = $(shell find src/)

default: target/dmote.jar
	java -jar target/dmote.jar

visualization: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/visualization.yaml

orthographic: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/orthographic_layout.yaml

flat: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/flat_layout.yaml

threaded: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/threaded_wrist_rest.yaml

threaded-visualization: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/threaded_wrist_rest.yaml -c resources/opt/visualization.yaml

solid: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/solid_wrist_rest.yaml

solid-visualization: target/dmote.jar
	java -jar target/dmote.jar -c resources/opt/solid_wrist_rest.yaml -c resources/opt/visualization.yaml

doc/options.md: target/dmote.jar
	java -jar target/dmote.jar --describe-parameters > doc/options.md

target/dmote.jar: $(OBJECTS)
	lein uberjar

test:
	lein test

# “all” will overwrite its own outputs.
# Intended for code sanity checking before pushing a commit.
all: test default threaded-visualization orthographic flat threaded solid doc/options.md

clean:
	-rm things/*.scad
	lein clean
