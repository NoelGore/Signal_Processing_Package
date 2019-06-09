# Signal Processing Package
The series of scripts runs through a various signal processing steps on a GPR dataset. The main script starts by loading in the dataset and then debiasing and normalizing the traces.
```
debiased = debiasTrace(offsets, GPR11, twt)
normalized_debiased = TraceEqualization(debiased, offsets)
```
Then a simple gain was compared to one using an Automatic Gain Control
```
simpleGain(offsets, twt, normalized_debiased, debiased, GPR11)
[agc, window] = AGC(offsets, twt, normalized_debiased, debiased)
```
Then ringing is removed through dewowing/trace averaging
```
dewowed = TraceAveraging(offsets, twt, agc, window)
```
Then zero padding was was done:
```
FreqContent(agc, twt, offsets)
```
Then a bandpass filter was applied:
```
[filttraces] = bandpass(agc, twt, fcorner)
```






