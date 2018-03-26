# pi-dashcam
A dashcam init script for raspberry pi 2/3/zero-w


== Pre-requisites ==
* Raspberry pi 2/3/zero-w
* Rapsberry pi cam
* smb server as remote deposit source
* Rapsberry pi cam enabled and raspivid installed
* smbclient installed
* Debian/Ubuntu distribution with init.d

== Software installation ==
* Copy pi-dashcam.sh in /etc/init.d
* Copy dashcam-ctrl.sh in /etc/dashcam
* Enter command: update-rc.d pi-dashcam.sh defaults 98


== Hardware Setup ==
To indicate the Pi that the car is ON, a 3.3v current must be set on the GPIO11 of the pi (PIN #23).
To achieve this, we're going to be modifying an old cellphone charger with the following electronic components

 * Wires
 * 3.3V voltage regulator (LD1117)
 * 200 ohms resistor

 See here for circuit diagram and instructions:
  * circuit_diagram_tinycad.png (Schematics)
