# Tail light FSM
In this project I implemented a FSM as specified in the famous Onur Mutlu “*Digital Design & Computer Architecture”* course labs 2020 edition.
## FSM overview

💡 Keep in mind that I don not own a FPGA so this was not tested

In this project I implemented a FSM to control the tail lights of a 1965 Ford Thunderbird. There are three lights on each side that operate in sequence to indicate the direction of a turn. Figure 2 shows  both tail lights and their flashing sequence (a) left turns and (b) right turns.

![image](https://github.com/OmarNehad/Tail-Lights-FSM/assets/52573189/bad4defd-b719-4cdf-b6cb-b78e5215b5d4)

This project employs the built-in crystal oscillator circuit in the FPGA that operates in 100Mhz, but because this oscillator is too fast (each `clk` period is 10 nanoseconds). If we want to see our sequence, we need to find a way to dramatically slow down the circuit; this is done with the help a small clock divider circuit that takes `clk` and `rst` signals as input and generates a `clk_en` signal every 33’554’432 cycles (or once every 225 cycles).
## Designing the FSM

To design the FSM machine, I have followed the following steps.

### 1. Identify the inputs and outputs

Since the blinking operation is the same for both turns. The machine is broken into two identical Moore FSMs each controlling one side of tail lights with **1-bit input $I$ (TRUE means there is a turn in that direction).**

- 2 inputs: Left and Right turn (if both are TRUE → both sides sequences will play)
- 6 outputs: 3 Lights for each side: LA , LB, LC, RA, RB, and RC (Red, Yellow, Green)

![image](https://github.com/OmarNehad/Tail-Lights-FSM/assets/52573189/6f9409fe-028f-4b97-89b9-a5321266b6f1)
### 2. For each FSM: Select state encodings → We will use one-hot encoding

- OFF: 000

- $E_A: 001$

- $E_{A,B}: 010$

- $E_{A,B,C}: 100$

### 3. For each FSM: Write a state transition table and an output table

State transition table with binary encodings

| Current State | Input ($I$) | Next state |
| --- | --- | --- |
| OFF | 1 | $E_A$ |
| OFF | 0 | OFF |
| $E_A$ | X | $E_{A,B}$ |
| $E_{A,B}$ | X | $E_{A,B,C}$ |
| $E_{A,B,C}$ | X | OFF |

Output table

| Current State | $O_A$ | $O_B$ | $O_C$ |
| --- | --- | --- | --- |
| OFF | 0 | 0 | 0 |
| $E_{A}$ | 1 | 0 | 0 |
| $E_{A,B}$ | 1 | 1 | 0 |
| $\small E_{A,B,C}$ | 1 | 1 | 1 |

### 4. For each FSM: Write Boolean equations for the next state and output logic

- $\text {OFF} = \text{OFF * } \overline {I} + E_{A,B,C}$
- $E_{A,B} = E_A$

- $E_A = \text {OFF} * I$
- $E_{A,B,C} = E_{A,B}$

- $O_A = E_A + E_{A,B} + E_{A,B,C}$

- $O_B = E_{A,B} + E_{A,B,C}$

- $O_C = E_{A,B,C}$
