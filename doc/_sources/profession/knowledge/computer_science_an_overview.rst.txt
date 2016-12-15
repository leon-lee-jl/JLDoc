*******************************
Computer Science -- An Overview
*******************************
*By J. Gleen Brookshear*

.. contents:: Table of Contents
   :depth: 4

Chapter 0 Introduction
=========================

0.1 The Role of Algorithms
*************************
One of the best known examples of this early research is the long division algorithm for finding the quotient of two multiple-digit numbers. Another example is the Euclidean algorithm, discovered by the ancient Greek mathematician Euclid, for finding the greatest common divisor of two positive integers

0.2 The History of Computing
**************************
One of the earlier computing devices was the abacus.

0.3 The Science of Algorithms
**************************
.. image:: ../../../../_static/algorithms_roles.jpg
      :height: 600px
      :width: 600px
      :alt: Algorithms Roles
      :scale: 100 %
      :align: center

0.4 Abstraction
****************
The term abstraction, as we are using it here, refers to the distinction
between the external properties of an entity and the details of the entity’s internal
composition.

0.5 An Outline of Our Study
************************

0.6 Social Repercussions
*********************
Consequence-based ethics attempts to analyze issues based on the consequences
of the various options. In contrast to consequence-based ethics, duty-based ethics does not consider
the consequences of decisions and actions but instead proposes that members of
a society have certain intrinsic duties or obligations that in turn form the foundation
on which ethical questions should be resolved. Contract-based ethical theory begins by imagining society with no ethical
foundation at all. Character-based ethics (sometimes called virtue ethics), which was promoted
by Plato and Aristotle, argues that “good behavior” is not the result of
applying identifiable rules but instead is a natural consequence of “good character.”


Chapter 1. Data Storage
===================

1.1 Bits and Their Storage
***********************
Three of the basic Boolean operations are AND, OR, and XOR (exclusive or). XOR produces an output of 1 (true) when one of its inputs is 1 (true) and the other is 0 (false). In short, the XOR operation produces an output of 1 when its inputs are different.)

A device that produces the output of a Boolean operation when given the operation’s input values is called a gate.

A computer engineer does not need to know which circuit is actually used within a flip-flop. Instead, only an understanding of the flip-flop’s external properties is needed to use it as an abstract tool.

1.2 Main Memory
****************
For the purpose of storing data, a computer contains a large collection of circuits (such as flip-flops), each capable of storing a single bit. This bit reservoir is known as the machine’s main memory.

Many of these technologies store bits as tiny electric charges that dissipate quickly. Thus these devices require additional circuitry, known as a refresh circuit, that repeat- edly replenishes the charges many times a second. In recognition of this volatility, computer memory constructed from such technology is often called dynamic memory, leading to the term DRAM (pronounced “DEE–ram”) meaning Dynamic RAM. Or, at times the term SDRAM (pronounced “ES-DEE-ram”), meaning Syn- chronous DRAM, is used in reference to DRAM that applies additional techniques to decrease the time needed to retrieve the contents from its memory cells.

In the late 1990s, international standards orga- nizations developed specialized terminology for powers of two: kibi-, mebi-, gibi-, and tebi-bytes denote powers of 1024, rather than powers of a thousand.

1.3 Mass Storage
****************
A major disadvantage of magnetic and optical mass storage systems is that they typically require mechanical motion and therefore require significantly more time to store and retrieve data than a machine’s main memory, where all activities are performed electronically. Moreover, storage systems with moving parts are more prone to mechanical failures than solid state systems.

Several measurements are used to evaluate a disk system’s performance:
* seek time
* rotation delay or latency time
* access time
* transfer rate

A factor limiting the access time and transfer rate is the speed at which a disk system rotates.

Delay times within an electronic circuit are measured in units of nanoseconds (billionths of a second) or less, whereas seek times, latency times, and access times of disk systems are measured in milliseconds (thousandths of a second).

Another class of mass storage systems applies optical technology. An example is the compact disk (CD). To obtain a uniform rate of data transfer, CD-DA players are designed to vary the rotation speed depending on the location of the laser. CD storage systems perform best when dealing with long, continuous strings of data, as when reproducing music. In contrast, when an application requires access to items of data in a random manner, the approach used in magnetic disk storage outperforms the spiral approach used in CDs.

A common property of mass storage systems based on magnetic or optic technology is that physical motion is required to store and retrieve data.

Since flash memory is not sensitive to physical shock (in contrast to magnetic and optic systems), it is now replacing other mass storage technologies in portable applications such as laptop computers.
