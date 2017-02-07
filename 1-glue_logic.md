Back to [main](readme.md)

---------------------------------------------------------------------------

1 - Glue-Logic: Connecting LEDs to switches
===========================================

One of the uses of an FPGA is as [glue logic](http://en.wikipedia.org/wiki/Glue_logic),
where it effectively acts as a convenient way of connecting
together lights. The DE0 contains 10 lights and 10 switches,
so "glue" the switches to the lights - when you toggle each
switch the corresponding LED should turn off and on.

Section 4.2 of the [DE0 user manual](resources/docs/DE0_User_manual.pdf) describes
the operation of the switches and LEDs, and also describes
exactly which pin of the FPGA each switch or LED is
connected to. For example, the rightmost toggle switch,
labelled SW0 on the board, is connected to input pin "J6"
on the FPGA, while the rightmost LED (LEDG0) is connected
to output pin "

What you need to do is:

1. Create a new Quartus project called "glue_logic", making
   sure the target device matches the FPGA on the DE0. _Note: use
   the older of the two versions of Quartus, as the newer ones
   do not support Cyclone III._
   
2. Create a top-level block diagram called "glue_logic" with
   a 10-bit input port and a 10-bit output port.
   
3. Within the block diagram, wire the input bus to the
   output bus.
   
4. Assign the switch pins to your input port, and
   the LED pins to your output port.
   
5. Compile and synthesise the design into a bit-file.

6. Configure the FPGA with the bit-file.

7. Marvel at your ability to control light itself!

The only steps you haven't performed before are
pin assignment and configuration.

Pin assignment
--------------

The top-level design or entity contains all logic
that will be placed in the FPGA; while it may contain
more logic in sub-blocks, this is the "top-level" of the hierarchy.
Any ports exposed by the top-level entity represent
connections to the outside world, and the only way
on or off the FPGA is via its pins.

Your top-level entity should contain one 10-bit
wide input port, and one 10-bit output port, which
need to be mapped to 20 corresponding pins on the
device. The steps involved are:

1. Compile (Analyse and Synthesise) the design: this allows
   the tools to identify how many ports there are,
   what they are called, how wide they are, and whether
   they are inputs or outputs.

2. Find and open the Pin Planner. This should give
   you a diagrammatic view of all the pins on the
   chip, as well as your 20 unassigned ports (called
   Nodes in this view).

3. For each unassigned port, set the "Location" to the
   "FPGA Pin No." from the [DE0 user manual](resources/docs/DE0_User_manual.pdf).

4. Close the Pin Planner, and synthesise the
   design.

Your design should now be completely synthesised and
converted to a bit-file file called `glue_logic.sof`.
This file defines the complete static configuration
of the FPGA, describing the configuration of each
lookup-table and the interconnect.

Programming the FPGA
--------------------

Once you have the bit-file ready, you need to transfer
it over to the FPGA, which will be via the USB cable. 

1. Make sure the DE0 is:
   - Plugged into the USB cable (which is also plugged into your PC)
   - Turned on (is there a blue light?)
   - The Run/Prog toggle is set to the "Run" setting

2. From within Quartus, open the "Programmer".

3. Within the Programmer, use "Add File.." to specify
   the `glue_logic.sof` configuration file.

4. Hit "Start"

This process is also covered in section 6 of
the [DE0 Getting Started Guide](resources/docs/DE0_Getting_Started.pdf).

Debugging
---------

If this process doesn't work, some things to check are:

- Did synthesis complete correctly? Are there any errors
  in the log?

- Did you specify the correct device type? Does the part
  number specified in the Quartus project and shown in
  the Programmer chain match the DE0 part?
  
- Does you device wire anything together? Find the
  "RTL viewer" in the Tasks pane on the left of Quartus.
  Does the RTL diagram show what you planned?

- Are your pin assignments correct?

If you have any suggestions for what else should/could
go here, they can be suggested via issues or pull requests.
Is there anything you found confusing that might help
others?

---------------------------------------------------------------------------

Back to [main](readme.md)

