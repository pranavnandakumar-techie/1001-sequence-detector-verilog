# Verilog FSM Sequence Detectors — "1001"

Four Verilog implementations of a serial sequence detector for the bit
pattern **1001**, covering all four combinations of:

- **Mealy** vs **Moore** output style
- **Overlapping** vs **Non-overlapping** detection

Each design is built from gate-level next-state equations driving a D
flip-flop state register — no `case` statements — derived by hand from
state transition tables.

## Repo structure

```
mealy_1001/
  overlapping/
    overlapping_seqdetector_mealy.v      # includes dflip
    tb_overlapping_seqdetector_mealy.v
  non_overlapping/
    non_overlapping_seqdetector_mealy.v  # includes d_flip
    tb_nonoverlapping_seqdetector_mealy.v
moore_1001/
  overlapping/
    overlapping_seqdetector_moore.v      # includes _dflip
    tb_overlapping_seqdetector_moore.v
  non_overlapping/
    non_overlapping_seqdetector_moore.v  # includes __dflip
    tb_nonoverlapping_seqdetector_moore.v
docs/
  testbench-timing-notes.md              # two timing bugs found + fixed
```

Each detector file defines its own D flip-flop module (`dflip`, `d_flip`,
`_dflip`, `__dflip`) so every design + testbench pair is fully
self-contained and can be compiled on its own without pulling in any other
file from the repo.

## Design overview

**Mealy machines** (2 flip-flops, states S0–S3): output depends on current
state *and* current input, so detection is combinational and reacts in the
same cycle.

**Moore machines** (3 flip-flops, states S0–S4): output depends only on
current state, so there's a dedicated "match" state and the output is
registered/glitch-free.

**Overlapping** detection lets the trailing bits of one match seed the next
possible match (e.g. `10011001` can find matches at both positions).
**Non-overlapping** detection resets cleanly to the idle state after a
match, discarding the tail even if it could start a new one.

## Simulating

Each detector + testbench pair can be run standalone in any Verilog
simulator (tested with Vivado's XSIM). For example:

```
overlapping_seqdetector_mealy.v
tb_overlapping_seqdetector_mealy.v
```

Compile both together and run the testbench module (`tb_...`) as the
simulation top.

## Notes

See [`docs/testbench-timing-notes.md`](docs/testbench-timing-notes.md) for
two real timing bugs (a race condition and a dropped first bit) found and
fixed while building these — worth reading if you're writing your own
negedge-sampled testbenches.
