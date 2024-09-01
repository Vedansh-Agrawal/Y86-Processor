# Y86-Processor
Constructed a high-performance sequential and 5-stage pipeline processor using verilog-HDL. The processor is capable of running Y86-64 instructions.

## File Structure : 

```bash
|   README.md
|   Report.pdf
|
+---PIPE
|       addersub.v
|       ALU.v
|       and.v
|       control.v
|       decodewb.v
|       Dreg.v
|       Ereg.v
|       execute.v
|       fetch.v
|       Freg.v
|       input.txt
|       inst_mem.v
|       memory.txt
|       memory.v
|       Mreg.v
|       predictPC.v
|       processor.v
|       reg.txt
|       registerfile.v
|       selfwd.v
|       Wreg.v
|       xor.v
|
\---SEQ
    |   processor.v
    |   processor.vcd
    |   processortb.v
    |
    +---Decode
    |       decodewb.v
    |       decodewb_tb.v
    |       decodewb_tb.vcd
    |       regfile.vcd
    |       registerfile.v
    |       registerfiletb.v
    |
    +---Execute
    |   |   execute.v
    |   |   execute.vcd
    |   |   executetb.v
    |   |
    |   \---ALU
    |           addersub.v
    |           adder_tb.v
    |           ALU.v
    |           ALU_tb.v
    |           and.v
    |           and_tb.v
    |           x.txt
    |           xor.v
    |           xor_tb.v
    |
    +---Fetch
    |       fetch.v
    |       fetch.vcd
    |       fetchtb.v
    |       inst_mem.v
    |       inst_mem.vcd
    |       inst_memtb.v
    |
    +---Memory
    |       memory.v
    |       memory.vcd
    |       memorytb.v
    |
    +---MISC
    |       input.txt
    |       memory.txt
    |       reg.txt
    |       x.txt
    |
    \---PCupdate
            pcupdate.v
            pcupdatetb.v
            pcupdatetb.vcd

```
