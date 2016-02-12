Back to [main](readme.md)

---------------------------------------------------------------------

2 - [Blinkenlights](http://en.wikipedia.org/wiki/Blinkenlights)
========================================

You current design is purely combinational, so it
contains no clock and has no sequential (stateful)
components. You will now add a clock input, give
the circuit some state, and get the LEDs to display
a 10-bit binary counter, incrementing at a rate
of ~47.6837hz (i.e. it should take ~21.5 seconds for
the LED counter to wrap round). This circuit does
not need any inputs, it only has state and outputs.

What you need to do is:

1. Create a new project called blinkenlights, with a
   top-level of the same name. This could be based on
   your previous project, as long as you change the
   relevant names. Doing so saves you setting up the
   pin assignments again.
   
2. Add a new 1-bit input port representing the clock,
   and make sure it gets assigned to the 50MHz clock
   pin (remember, pin names are in the DE0 user guide).
   
3. Create a clock buffer primitive (ALTCLKCTRL), which will
   take the raw input from the 50MHz oscillator, and expose
   it as something that can be used as a global clock.

4. Create a clock-divider which will reduce the 50MHz
   clock down to a signal toggling at a target
   of 47.7hz. This should be a _logical_ clock
   divider, and all sequential logic should derive
   their actual clocks from the same 50MHz source.

5. Create a counter which will count upwards at the
   slower rate.

6. Wire the output of the counter to the LEDs.

Once you have created the design and configured the
device, the LEDs should start counting up at the correct
rate.

Notes and hints
---------------

- The clock buffer is needed to ensure a [low-skew clock](http://en.wikipedia.org/wiki/Clock_skew).
  Your circuit will probably work without it, but it is bad practise
  to wire a pin directly into register clock inputs (why?)

- There are examples of counters/dividers in the digital
  electronics notes (lecture 11, I believe).

- You have already built a compatible counter out of
  full-adders in a previous lab.

- A D flip-flop will maintain state between clock cycles.

- Simulation still works, and you should use it. You
  should be able to simulate your design in the
  same way as the first lab.

- Simulation is slow, so try not to simulate 50 million
  cycles - choose a smaller time period with a simpler
  circuit.

- Compilation and synthesis is slow compared to simulating
  a small time period.

- If your counter counts at the wrong rate, but is
  still visibly changing, you should be able to
  work out how to adjust your divider.

- A very fast counter may be difficult to distuinguish
  from the LEDs being all on (why?)
  
- A very very slow counter is difficult to
  distuinguish from the LEDs being all off (why?)
  
Any other comments?
  
----------------------------------------------------------------------

Back to [main](readme.md)
