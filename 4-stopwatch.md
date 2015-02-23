Back to [main](readme.md)

------------------------------------------------

4 - 7-Segment stopwatch
=======================

The DE0 contains a 4-digit 7-segment output display,
with each segment driven by one output pin. Create
a project and top-level called "stopwatch" that has
the following functionality:

- Push-button BUTTON0 resets the stopwatch,
  resetting the 7-segment display to "00.00".

- Push-button BUTTON1 starts the stopwatch,
  showing elapsed time in decimal, with two
  fractional digits, i.e. a precision of 10 ms.

- Push-button BUTTON2 pauses the display for as
  long as it is pushed (held down), but does not stop
  the stopwatch counter, providing something similar to the
  [split](http://en.wikipedia.org/wiki/Stopwatch) functionality
  of a stopwatch. Here the split time always reflects the time
  between when the "start" and "split" button are presses,
  not the time between consecutive presses of "split". _Note: my conception of split is a little
  different than the standard one; thanks to @bingthegreat93 for
  [highlighting the ambiguity](https://github.com/m8pple/eie1_fpga_lab/issues/2)._

- While the precision of the stopwatch is 10ms, the
  [accuracy](http://en.wikipedia.org/wiki/Accuracy_and_precision)
  of the stopwatch will be less than 10ms, as we don't
  know how accurate the 50MHz clock is. Your stopwatch
  should introduce no more than 1% error on top of
  the clock error.

You do not need to consider cases where users press more
than one button at the same time.

This is a more complicated task, as it involves
multiple steps. As an engineer, you need to break
it down into small testable steps, so that you
know what you are fixing/breaking with each
modification.

A suggestion is to break it down into four distinct blocks:

1. A block which generates a tick signal within 1% of the desired frequency.
2. A block which decodes four 4-bit binary digits to the correct 7-segment display signals.
3. A block which is able to count to 9999 in [binary-coded-decimal](http://en.wikipedia.org/wiki/Binary-coded_decimal).
4. A block to handle the push-button functionality and state machine.

Think carefully about the design and specification of
these blocks before you start implementing them:
- What are the input and output ports?
- Which ports will need to be routed to pins by the top-level?
- How can you test the blocks, both in simulation and at the top-level?

You should aim for as little functionality as
possible in the top level, so that all it does
is connect together known-good components.

Generating a tick at a desired frequency
----------------------------------------

You currently have a 50MHz clock, and have (presumably) been
able to reduce it by a binary multiple. How can you divide
it by a non binary multiple (the answer is _not_ to use a
divider). A normal incrementer or adder cascade will wrap
around at a power of two, how can you make it wrap earlier?

Additionally, what sort of output do you want? This frequency
will need to tick the BCD counter forward, so should that
happen when the output transitions from 0 to 1 within a
50MHz clock cycle (edge sensitive) or does the tick happen
if the output is 1 during a clock cycle (level sensitive)?

4-bit to 7-segment decoder
--------------------------

There is a standard mapping from hexadecimal digits to
[7-segment display bits](http://en.wikipedia.org/wiki/Seven-segment_display#Displaying_letters),
which is essentially a set of seven 4-bit to 1-bit
combinational functions, or a ROM. Hrmm, so each segment
is a function of the four bits of the decimal digit.
Hrmm, sounds like some sort of map... K-something? I forget.

Expressing this function using block diagrams would
be excessively painful, so a [skeleton Verilog decoder](resources/decode_7segment.v)
has been provided. This can be added to your project,
a symbol generated (try right-clicking on the file), and
used to generate one of the digits. For testing you
could try connecting the inputs to the toggle switches,
the outputs to one hex digit, and use that to debug the
functionality.

As given, the decoder does _not_ work. You will need
to figure out the mapping from the inputs to each
output bit. The given skeleton is not the best way
of describing this problem - what you really want is
a truth table or ROM, so you could investigate how
to do that (in Verilog or via a primitive).

Once you have one digit, you can move up to
the four digit block (don't forget the decimal point).

BCD counting block
--------------------

A 4-bit BCD counter can be viewed as a cascade of 4-bit
digit counters, with each digit counter wrapping around at 10
(wrapping counters should now be easy).
This counter needs to count according to an external
tick rate derived from your tick generator.

The only extra functionality you'll need is that
to support the stopwatch functionality. One way of doing
this is to have a 1-bit input signal which forces the
four digits to zero when asserted, and allows the
counter to proceed when de-asserted.

State machine
-------------

You have:
- three inputs coming from your push-button pins
- a counter which needs to be reset or allowed to increment
- a display which needs to show either the running counter or the held counter

So you need to design a state machine which is
able to co-ordinate all those activities, and
decide who has responsibility for what:
- While the "split" button is held, how do you make sure the counter continues but the display is fixed?
- If the value is registered within the state machine block, how
  do you control when the value is captured?
- Similarly, how do you control whether the display shows the
  running counter or the captured value?

---------------------------------------------------------------------

Back to [main](readme.md)
