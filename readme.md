EIE1 FPGA Lab : 2015 Spring
===========================

The goals of this lab are to:

- Further develop experience with [EDA](http://en.wikipedia.org/wiki/Electronic_design_automation)
  tools (such as Quartus), and understand the different
  processes it applies and the types of analysis it
  performs.
  
- Put a few more of the concepts from digital logic
  into practise, in particular with the relationship
  between [sequential logic](http://en.wikipedia.org/wiki/Sequential_logic) and
  [combinational logic](http://en.wikipedia.org/wiki/Combinational_logic).

- Be able to independently solve problems with
  toolchains, and use documentation for tools.

- Work with digital logic in a real FPGA, as well as
  simulations of that digital logic.
  
- Deal with and resolve uncertainty in specifications.

This is a short lab with just four sessions, so
you are advised to read the specification before
lab, and also do any necessary planning or
high-level design before-hand.

This document
-------------

The online document [https://github.com/m8pple/eie1_fpga_lab](https://github.com/m8pple/eie1_fpga_lab)
is the lab specification, and it is a "live" specification. There may well be
errors in it (though not intentionally), or
questions about what it means. If you have suggestions
for how to improve it, you are encouraged to:

- [Raise an issue via github](https://github.com/m8pple/eie1_fpga_lab/issues/new):
  - What is the problem?
  - What did you expect to happen or want to do?
  - What methods have you tried, and how did they fail?
  - Do you already know what the solution is?

- Discuss [any issues already on github](https://github.com/m8pple/eie1_fpga_lab/issues/new):
  - add useful information you have found
  - suggest solutions that worked for you
  - _usefully_ contribute in any other way

- Submit a [pull request](https://help.github.com/articles/using-pull-requests/)
  if you think you have a good solution or contribution.

This is not a substitute for talking to GTAs, or
trying to solve problems yourself (mainly as it is
a slower feed-back process). The goal is to constructively
criticise and improve a specification when needed,
and to develop the skills needed to both report
problems, and to help in their solution.

Why is this in [git](http://git-scm.com/)?
------------------------------------------

You can view this specification as a web-site
that you visit to read, or [as a repository](http://git-scm.com/book/en/v2/Getting-Started-About-Version-Control)
that you [clone](https://help.github.com/articles/fetching-a-remote/)
into a local repository which you do your own work in.

While [revision control](http://en.wikipedia.org/wiki/Revision_control)
knowledge is *not* the main aim of this lab, as
computer engineers you may find it useful to
look at this way of working, and [learn about what it is](http://ericsink.com/vcbe/).

My main suggestions if you want to work with a repository are:
- be careful about "cleaning" your project
  before checking things in, to get rid of large binary
  files.
- only check in binary outputs like ".sof" files when
  you reach a milestone "known-good" version. For example, you
  may want a directory called "golden" where you put copies
  of the bit-files when they are working.
- github accounts are public by default, so if you want
  a [remote repository](http://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)
  then either get a [student account](https://education.github.com/pack),
  or use another provider like [bitbucket](https://bitbucket.org/)
  that supports private repositories.
  
Working with normal methods (USB sticks, DropBox, home
directories) is perfectly fine too, but you need a way of:
- capturing projects and outputs in "known-good" stages (numbered zip files?)
- documenting progress towards design goals (logbook?)
- capturing design goals and decisions as they are made (logbook?)
- moving projects between machines (DropBox?)
- sharing work between partners (email?)
- recording activity by both partners (logbook?)

Background knowledge
--------------------

You have all completed the Autumn lab, so have
experience with design entry and logic simulation
using Quartus.

You have also completed Digital Logic I last term,
so should be familiar with the concepts of:
- Combinational logic: and, or, not, ...
- Building truth tables from logic
- Adders and counters
- Sequential logic, in particular the [D Flip-Flip](http://en.wikipedia.org/wiki/Flip-flop_%28electronics%29#D_flip-flop)
- [Finite state machines](http://en.wikipedia.org/wiki/Finite-state_machine)

Target platform
---------------

The target platform is the [DE0](http://de0.terasic.com) from
Terasic. The computational heart of the device is a
[Cyclone III](https://www.altera.com/products/fpga/cyclone-series/cyclone-iii/overview.html)
EP3C16F484C6 FPGA. The part number can be decoded as:

- EP3C : indicates this is from the Cyclone III family
- EP3C*16* : the specific configuration of the device, describing the number of compute resources it contains
- F484 : the package and pin-configuration of the device
- C6 : the speed-grade of the device

The FPGA architecture is described in the [Cyclone III handbook](resources/docs/cyclone3_handbook.pdf)
with the main components of interest for this lab being:

- Logic elements (section 2 of the handbook) : primitive elements
  containing a look-up table for combinational logic, and
  a flip-flop for sequential logic.
- Pins (section 6) : the things that allow the FPGA to
  communicate with the outside world. These are surprisingly
  complicated, but we can ignore most of the details except
  for which pin is connected to what peripheral.
- Clock trees (section 5) : a method for taking one clock
  signal and efficiently distributing it to many hundreds
  or thousands of clock sequential elements. We will
  rely on this, but not think too much about it.

There are also block RAMs and DSP blocks, but we
will not explicitly make use of them in this lab.

The DE0 platform is a teaching platform developed by Altera
as part of their [university programme](https://www.altera.com/support/training/university/overview.html),
so it contains a wide spectrum of input and output
devices, including:

- a four-digit 7-segment display
- 10 LEDs
- 10 toggle switches
- 3 pushbutton switches ([de-bounced](http://en.wikipedia.org/wiki/Switch#Contact_bounce))
- A USB-blaster interface for communicating with a PC
- A 50 MHz clock generator

The DE0 manual is available [here](resources/docs/DE0_User_manual.pdf) or
[on the Terasic](http://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=English&CategoryNo=165&No=364&PartNo=4) web-site.
The manual describes many useful details of the board, including
how pins on the device are linked to the different peripherals.

Exercises
---------

1. [Glue logic](1-glue_logic.md) : This is a very simple task to
   get something up and running on the FPGA.

2. [Blinkenlights](2-blinkenlights.md) : Here the notion of
   clocks and state is introduced in a very simple way.

3. [Pipelined multiplier](3-multiplier.md) : An exploration
   of the interaction between registers and combinatorial
   logic, and the resulting implications for latency
   (execution time) and throughput (clock-rate).

4. [Stopwatch](4-stopwatch.md) : A more complicated task
   involving user interaction and free-running components,
   requiring some thought about heirarchical design and
   testing and integration of components.
   
You may complete all the exercises before the last
lab session. If so, you are encouraged to add extensions,
which add functionality, or improve the interface. Just
make sure you don't break existing functionality while
doing so.
   
Assessment
----------

You will be orally assessed on this lab (specific topic
and setup to be given later), and will need to be able
to talk about:

- Design: how did you approach the problem of developing
  the more complex designs, and what methods did you use
  to make sure the solution would work?
- Implementation: do the solutions work, and can they be
  shown to work. If they don't work, are the failure
  cases known and understood?
- Understanding: what are the general implications of
  the experiments in a wider sense; for example, can
  you show a more general understanding of modular
  design or pipelining?
- Team-work: what processes were used to make sure
  that both partners were (or at least could be) involved
  in design and implementation? Were there any examples
  of contributing to the larger team (EIE1) in a useful way?  

Make sure you document your progress and
decisions as you go; you should be able to
demonstrate that your solutions are functional
because you worked intelligently and applied good
practises, not just because you worked hard and/or got lucky.
