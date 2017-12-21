# pi-dashcam
A dashcam init script for raspberry pi 2/3/zero-w


== Pre-requisites ==
* Raspberry pi 2/3/zero-w
* Rapsberry pi cam
* Micro-usb cable, soldering iron, battery source (See wiki for hardware setup)
* smb server as remote deposit source (Optional)
* Rapsberry pi cam enabled and raspivid installed
* smbclient installed
* Debian/Ubuntu distribution with init.d

== Software installation ==
TO DO


== Hardware Setup ==
To indicate the Pi that the car is ON, a 3.3v current must be set on the GPIO11 of the pi (PIN #23).
To achieve this, we're going to be modifying an old cellphone charger with the following electronic components

 * Wires
 * 3.3V voltage regulator (LD1117)
 * 550 ohms resistor

 See here for circuit diagram and instructions:
  * circuit_diagram_tinycad.png (Schematics)
