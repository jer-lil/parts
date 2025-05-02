# Internal Part number guidelines

<!-- vim-markdown-toc GFM -->

- [Internal Part number guidelines](#internal-part-number-guidelines)
- [Background](#background)
  - [Part Categories](#part-categories)
    - [Why use the same format for IPN and external model number?](#why-use-the-same-format-for-ipn-and-external-model-number)
    - [Examples](#examples)
      - [Resistor part numbers](#resistor-part-numbers)
      - [Capacitor part numbers](#capacitor-part-numbers)
      - [Relay part numbers](#relay-part-numbers)
      - [Switch part numbers](#switch-part-numbers)
        - [Toggle Switches](#toggle-switches)
  - [Implementation](#implementation)
  - [Structured or Unstructured?](#structured-or-unstructured)
  - [Reference](#reference)

<!-- vim-markdown-toc -->


# Background

See ***partnumbers.md*** for background

Basic format: **CCC-NNNN-VVVV**
- CCC is a 3-character code indicating the part category
- NNNN is a 4-digit code indicating the part / part family. 
  - Incremements sequentially, no inherent meaning
- VVVV is a 4-digit code indicating the part variant within the family
  - e.g. different resistance values with the same package size / tolerance
  - e.g. pots with different resistance values, shaft lengths, etc with the same footprint 


## Part Categories

| Code | Description                              |
| ---- | ---------------------------------------- |
| ANA  | op-amps, comparators, A/D, D/A           |
| CAP  | capacitors                               |
| CON  | connectors                               |
| CPD  | Circuit protection devices               |
| DIO  | diodes                                   |
| IND  | inductors, transformers                  |
| ICS  | integrated circuits                      |
| MPU  | SOC, SOM, SBC, etc.                      |
| MCU  | Microcontrolleres, modules, etc.         |
| OPT  | Optical, couplers, phototransistor, etc. |
| OSC  | oscillators, Crystals                    |
| PWR  | relays, etc                              |
| RFM  | RF modules, ICs, and related components  |
| REG  | regulators                               |
| RES  | resistors                                |
| SEN  | sensors                                  |
| SWI  | switch                                   |
| XTR  | transistors, FETs                        |

The following CCC groups are suggested for other parts (preliminary):

| Code | Description                                                                                                                                          |
| ---- | ---------------------------------------------------------------------------------------------------------------------------------------------------- |
| FST  | fasteners (screws, bolts, nuts, etc)                                                                                                                 |
| CBL  | cables, etc                                                                                                                                          |
| ENC  | enclosures                                                                                                                                           |
| PKG  | packaging                                                                                                                                            |
| OPT  | Optics: Windows, Lens, light pipes, etc.                                                                                                             |
| FLD  | Fluids: Lubricants, oil, valve, check, divertor, reducer, tubes, pipes, hoses, seals, gaskets, sealants, diaphragms, bellows, pistons, cylinders     |
| MRK  | Markings: Coatings, labels, Pain, Dye, Ink, etc                                                                                                      |
| DRV  | Drive: Bearings/ Bushings, Gears and sprockets, Chains, Rollers, Motors, actuators                                                                   |
| STC  | Structural: connection hardware, lever arms, springs, beams, bars, plates, guide rods, ways, saddles, clamps, brackets, flanges, standoffs, castings |
| TMP  | Heat exchangers, sinks                                                                                                                               |

The following CCC groups are suggested for things you produce:

| Code | Description                                                                                                                                                                                                                                      |
| ---- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| PCS  | Printed Circuit Schematic.                                                                                                                                                                                                                       |
| PCA  | Printed Circuit Assembly. The version is incremented any time the BOM for the assembly changes.                                                                                                                                                  |
| PCB  | Printed Circuit board. This category identifies the bare PCB board.                                                                                                                                                                              |
| ASY  | Assembly (can be mechanical or top level subassembly -- typically represented by BOM and documentation). Again, the variation is incremented any time a BOM line item changes. You can also use product specific prefixes such as GTW (gateway). |
| DOC  | standalone documents                                                                                                                                                                                                                             |
| DFW  | data -- firmware to be loaded on MCUs, etc                                                                                                                                                                                                       |
| DSW  | data -- software (images for embedded Linux systems, applications, programming utilities, etc)                                                                                                                                                   |
| DCL  | data -- calibration data for a design                                                                                                                                                                                                            |
| FIX  | manufacturing fixtures                                                                                                                                                                                                                           |

Conventions can be used such that the PCS, PCA, and PCB NNNN are a matched set:

| IPN           | Description                                    | Version |
| ------------- | ---------------------------------------------- | ------- |
| PCA-0055-0002 | Gateway with RS485 support PCB assembly BOM    | 2       |
| PCA-0055-0102 | Gateway with CAN support PCB assembly BOM      | 2       |
| PCB-0055-0005 | Bare PCB used in above assemblies              | 5       |
| PCS-0055-0006 | Schematic documentation for above PCB/assembly | 6       |

In the above, the common `0055` ties all the IPNs together. We can quickly find
the schematic, bare PCB, or BOM if we know one of the IPNs -- whether it's a
file on disk, paper printout in the lab, documentation in the factory, field
service kit, etc.

Some additional guidelines:

- Every part number has the same number of characters in it (3-4-4). This makes
  sorting/comparison/entry simpler with less chance of error.
- Character set is restricted to capital letters, digits, and hyphen.
- Avoid punctuation characters such as %, !, (, ., etc.

### Why use the same format for IPN and external model number?

Having a consistent format between IPN and external model number has several
benefits:

- both should be easy for humans to recognize and process, so why not use the
  same format for both.
- both need to be stocked, warehoused, handled, etc
- customers may need to order service parts that are also used in manufacturing.
  If the internal and external numbers are the same, handling/stocking these
  parts is simpler.

### Examples

With resistors, capacitors, and connectors, we encode the value and pin count in
the variation:

- 1K 0805 1%: RES-0002-1001
- 3.3K 0805 1%: RES-0002-3301
- 2.2K 0603 5%: RES-0003-2201 (note we bumped NNN to 003, because different
  package size)
- 10.3K high power 0603: RES-0004-1032 (different vendor/datasheet than RES-002,
  so we bump NNN)
- 2x10, 0.1 in header: CON-0000-0020
- 2x12, 0.1 in header: CON-0000-0024
- 1x10, 0.1 in header: CON-0001-0010
- 1x20, 0.1 in header: CON-0001-0020

With most ICs we simply enumerate all the variations of a particular IC in a
sequentially incrementing variation (we don't try to encode information)

- LM78xx SOT223 5V: REG-0089-0000
- LM78xx DIP 5V: REG-0089-0001
- LM78xx SOT223 3.3V: REG-0089-0002
- LM78xx DIP 3.3V: REG-0089-0003
- 3.3v switching reg, SSOP8: REG-0002-0000
- 3.3v switching reg, S08: REG-0002-0001
- STM32H7 in 44 pin package, 1M flash: MCU-0001-0000
- STM32H7 in 44 pin package, 2M flash: MCU-0001-0001
- STM32H7 in 208 pin package, 1M flash: MCU-0001-0002
- STM32H7 in 208 pin package, 2M flash: MCU-0001-0003
- STM32F3 in 44 pin package: MCU-0002-0000 (note different base part, so bump
  NNN)

Many parts will not have any variations:

- 2N4401 DIODE: DIO-0000-0000 (no variation information, that is fine)
- 2N2222 transistor: TRA-0000-0000 (again, no variation info)

The variation section is only used in cases where a part with a single datasheet
has multiple variations. Variations are generally used to encode one parameter
with the most different variations -- for instance resistance with resistors. A
single datasheet may include 0603, 0805, and 1206 options, but take out separate
NNN part numbers for different package sizes because with resistors, it makes
the most sense to encode the resistance in the variation (because there are lots
of resistance values), not the package size. There are relatively few package
sizes for resistors so it makes sense to take out new NNN numbers for different
packages. However, for voltage regulators, it may make sense to encode both the
regulated voltage and the package in the variation, because there is a
relatively small number of combinations.

Generally we don't need to create house part numbers for every part variation --
only the ones we use. Resistors/caps may be an exception where we simply create
the entire series in the partmaster because it is easiest to just do once.

#### Resistor part numbers

Most resistor variations (at least 1%) are encoded using the E96 4-digit
industry standard. Examples:

- 2500 = 250 x 100 = 250 x 1 = 250 Ω (This is only and only 250Ω not 2500 Ω)
- 1000 = 100 x 100 = 100x 1 = 100 Ω
- 7201 = 720 x 101 = 720 x 10 = 7200 Ω or 7.2kΩ
- 1001 = 100 × 101 =100 x 10 = 1000 Ω or 1kΩ
- 1004 = 100 × 104 =100 x 10000 = 1,000,000 Ω or 1MΩ
- R102 = 0.102 Ω (4-digit SMD resistors (E96 series)
- 0R10 = 0.1 x 100 = 0.1 x 1 = 0.1 Ω (4-digit SMD resistors (E24 series)
- 25R5 = 25.5Ω (4-digit SMD resistors (E96 series))

#### Capacitor part numbers

Most capacitors values are encoded in a 3-digit number where the 1st two digits
are the value and the last digit is the number of zeros in pF. Since we have 4
digits, the 1st digit is typically not used, but can if precision caps exist
that need 3 significant places to encode the value. The goal is to match what
most vendors are doing so we can easily compare IPN and vendor part numbers.

Examples:

- 103 = 10 \* 10^3 = 10,000pF = 10nF = 0.01uF
- 104 = 0.1uF

To figure out the extension, you can divide the capitance by 1pF to get the
number of pF. From this, you can visually tell what the variation should be.
Example:

`0.022uF = 0.022e-6/1e-12 = 22000`

So the extension would be `223`

To work backwards, we would have `1000 * 22 = 22,000pF/1e-6 = 0.022uF`.

#### Relay part numbers

Within the last 4 digits, the encoding is as follows:

RLY-0000-ABCD:

A: Coil version
- 0: Non-Latching
- 1: Single coil latching
- 2: Dual coil latching

B: Footprint
- 0: Through-hole
- 1: Gull-wing
- 2: J-Load
- 3+: Other variants

CD: Coil Voltage

For example, a J-lead, single coil latching, 9V relay would be RLY-XXXX-1209

#### Switch part numbers

##### Toggle Switches

SWI-0000-ABCD:

A: Form
- 0: SPST
- 1: SPDT
- 2: DPST
- 3: DPDT
- 4: 3PST
- 5: 3PDT
- 6: 4PST
- 7: 4PDT
 
B: Function - "()" denotes momentary
- 1: On-On
- 2: On-(On)
- 3: On-Off-On
- 4: (On)-Off-(On)
- 5: On-Off-(On)
- 6: On-On-On*
- 7: On-On-(On)*
- 8: (On)-On-(On)*

*only available with DPDT and 4PDT

C: Mounting
- 0: M1 - Solder Lug
- 1: M2 - PC Pin
- 2: M6 - PC Pin, Right Angle, Vertical
- 3: M7 - PC Pin, Right Angle, Horizontal
- 4: VS2

D: Actuator & Bushing
- 0: Long Shaft, Threaded
- 1: Short Shaft, Threaded
- 2: Long Shaft, Unthreaded
- 3: Short Shaft, Unthreaded

Other options exist that aren't explicitly included, such as:
- Right angle 
- Bracket
- Other actuator lengths
- Other bushing types

## Implementation

Defining a part number structure is only part of the story -- implementation is
also critical. IPNs function as a _common_ reference to an object across an
organization. Thus, the implementation needs to be common across the
organization. Engineers should be able to pull new PN's and specify requirements
in the same database as manufacturing uses for planning and purchasing -- this
is the only configuration that will scale.

## Structured or Unstructured?

One of the fundamental questions regarding part numbers is whether to use
structured or unstructured part numbers. An unstructured part number is a number
that starts at say 1000000, and simply increments for each new part.

A fully structured part number might try to encode every parameter in the part
number -- for example:

`RES-0603-0.1W-1%-20ppm-10K`

A semi-structured part number might be:

`RES-0025-1002`

The `0603-0.1W-1%-20ppm` parameters are all represented by the NNN section
(`025`). `1002` is the standard EIA E69 coding for 10K, which is used to encode
the value in most 1% resistor manufacturer part numbers today.

Many companies use a semi-structured part number format that consists of the
following components:

- **category** - a broad category for the part
- **incrementing number** - this is a simple incrementing number within a
  category that gives semi-structured part numbers all the same flexibility that
  unstructured part numbers have.
- **variation** - this field is used to differentiate similar parts and can
  encode the differentiating parameter(s) (resistance, length, size, etc) or can
  be a simple incrementing number.

There are many arguments for and against structure in part numbers, and
different organizations have different needs, so there is no one-size-fits-all.
Some trade-offs to consider:

- **semi-structure cons**
  - some training and knowledge is required to use the system
  - some claim numbers (vs letters) are easier to type on a keypad. However,
    more and more people are using laptops which don't have a numberpad.
  - the business may change such that the structure you start with no longer
    makes sense
  - parts may be categorized incorrectly, which is hard to fix later
- **semi-structure pros**
  - a semi-structured part number like CAP-0023-0429 is easy to recognize as an
    IPN, and differentiate from other numbers
  - the category (CCC) part in easy to recognize/remember which reduces the size
    of the arbitrary NNN section you need to memorize. This also naturally sorts
    parts for you -- on your BOM, in the warehouse, in the factory, in your lab
    stock, etc. When physically dealing with 100's part numbers on a large PCB,
    any organization is helpful. Having a dozen or two CCC categories is also
    reasonable for humans to manage. If you had 200 categories, it would be
    difficult to determine what category a new part went in, or where to find it
    in the lab stock.
  - the NNNN increments, so you still have a "Random" part, which gives you any
    flexibility you need.
  - the VVVV allows you to group variations of the same part together -- in
    documentation and in the warehouse.
  - `RES-0098-1004` is much easier for a human to compare without mistakes than
    `1029102` or `0603-0.1W-1%-20ppm`.
  - phone numbers, two-factor authentication codes, PINs, etc are often in the
    form of XXX-XXX. There is a reason for this -- groups of 3 or 4
    letters/digits are easy for humans to remember and recognize. Why not follow
    a similar format in IPNs?
  - We often group schematic parts into symbol libraries in our CAD tools. If
    that level of organization is useful for designers, why not leverage that
    same organization throughout the company?
  - humans read and compare IPNs many more times than we create or write them.
    Thus IPNs **should be optimized for reading and comparison by humans.**
  - a semi-structured part number is conducive to simple automation and
    scripting tasks. You can do a lot with a few lines of code (GitPLM is an
    example of this). CCC values can trigger different types of workflow. This
    helps a lot when you are starting out and can't afford $2M for a full blown
    MRP/PLM/... system.
  - a semi-structured part number is simple to implement -- any company, no
    matter how small, can implement this now and gain benefits.

An argument can be made that we don't need semi-structured IPNs and a simple
incrementing number and expressive descriptions/parameters in a database is
adequate. This works fine if you are using a computer and have access to a
database. However, this does not help you when you are in the warehouse picking
parts and comparing bags in a bin to numbers on a BOM, or doing a quick scan of
a BOM looking for mistakes. In this scenario, having **easy to compare
identifiers** helps a lot. This **improves efficiency** and **minimizes
mistakes**.

The case can be made that inventory and PLM software does care about structure
in PNs. This may be true, but you still need to solve the following problems:

- humans move parts around -- smart naming helps minimize errors and improve
  processing/recognition/comparison
- how are you going to organize/find parts/products in your back room before you
  are big enough to justify an inventory management system? If you have a
  structured PN system, you have a built-in way to sort and find parts.
- you still have to organize parts when kitting them for moving around, staging
  for manufacturing operations, etc.

An argument can be made that if you can't encode all parameters in the PN, then
you should not encode any. Information is not all or nothing. Some information
is better than no information. CCC/VVVV organization is very useful when dealing
with physical bags of parts in the real world. To find commonly used parts, the
CCC code is fairly obvious -- you will quickly memorize the small NNNN number
for commonly used parts (like 1%, 0603 resistors) and the variation can often be
deduced logically for most parts. The reason we use IPNs is similar to why we
give people, countries, cities, etc. names -- so we can quickly identify and
communicate information about something in the physical (or even virtual) world
between humans. We don't call our co-worker down the hall
`engineer-5'11"-brown-hair-blue-eyes-150lbs-bsee-...` or `1029629` -- we
identify people by `<firstname> <lastname>`. Names are useful!

The CCC-NNNN-VVVV scheme is a pragmatic compromise between random part numbers
and extensive descriptions where every last parameter is encoded in the
description. It is kind of like using colors on the factory floor -- you can't
encode everything in colors, but what you can encode sure helps with rapid,
accurate processing by humans.

Three letters for CCC has the following attributes:

- descriptive enough that you can encode meaning in it -- RES, CAP, SWI, DIO,
  etc are all fairly obvious and easier to remember/recognize than an arbitrary
  number.
- short enough to naturally limit the number of categories. If you had 4
  characters, you'd probably end up with RESS (surface mount resistor), and REST
  (through hole resistor), which is probably overkill and just complicates part
  number assignment.

CCC-NNNN-VVVV also follows the general to specific naming convention, which is
generally a good way to name things.

The CCC-NNNN-VVVV format presented here is optimized for a small/mid-sized
company making electronic products. It may not be optimal for other industries.

If you do a google search on this topic, the seemingly prevailing opinion is
against structured part numbers. However, it appears most of these articles are
written by PLM tool vendors. Perhaps their criticisms are valid for fully
structured part numbers, but we're already demonstrated that semi-structured
part numbers can be designed to avoid most drawbacks, other than a little more
work up-front to create. The efficiencies gained downstream should pay back this
effort many times. It appears that most automotive manufacturers use
semi-structured part numbers. I don't have direct experience, but I've heard you
can tell where a part goes on an automobile from its PN. It takes more work up
front to figure out these part numbers, but having this bit of information
during manufacturing is a simple and effective check against errors and improves
efficiency. McMaster-Carr also uses semi-structured PNs. Maybe you should too
...

## Reference

The above information was compiled from the following discussions, articles, and
direct discussions with various people. All input, especially criticisms, has
been very valuable in clarifying the thinking on this topic.

- [Extensive discussion on the KiCad forum](https://forum.kicad.info/t/internal-house-part-number-formats/34958)
- PLM good practice (PDexpert)
  - [Part numbering system design](https://www.buyplm.com/plm-good-practice/part-numbering-system-software.aspx)
  - [Intelligent part numbers: The cost of being too smart](https://www.buyplm.com/plm-good-practice/intelligent-part-number-scheme.aspx)
- [Intelligent Numbering: What’s the Great Part Number Debate?](https://blog.grabcad.com/blog/2014/07/24/intelligent-numbering-debate/)
  - 4 perspectives to consider:
    - Creation and Data Entry
    - Longevity and Legacies
    - Readability
    - Uniqueness
    - Interpretation
  - This is a great article that explains the challenge of balancing all these
    factors.
- [Pary Numbering](https://www.linkedin.com/pulse/part-numbering-sethupathy-a-b2s1c/)
- Oleg Shilovitsky
  - [Why to use intelligent PNs in the 21st century](https://beyondplm.com/2015/09/18/why-to-use-intelligent-part-numbers-in-21st-century/)
  - [Part Numbers are hard. How to think about data first?](https://beyondplm.com/2014/07/28/part-numbers-are-hard-how-to-think-about-data-first/)
    - > Product data is one of the most expensive assets in manufacturing
      > companies. It represents your company IP and it is a real foundation of
      > every manufacturing business. Think about data first. It will help you
      > to develop strategy that organize data for longer lifecycle and minimize
      > the cost of bringing new systems and manage changes in existing systems.
  - [The future of Part Numbers and Unique Identification?](https://beyondplm.com/2013/12/12/the-future-of-part-numbers-and-unique-identification/)
    - discusses schemes that large companies are using to accomplish global
      product IDs
