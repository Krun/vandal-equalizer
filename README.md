#vandal-equalizer

##Overview

**vandal-equalizer** is a simple audio equalizer programmed with VHDL. Its purpose is to serve as a learning exercise of VHDL, performing some basic digital signal processing tasks such as filtering, level detection or gain adjustment.

The project comprises the implementation of the following modules, each of which can be studied as independent VHDL examples:

* IIR digital bandpass filters
* Gain adjustment for each audio band
* Delay module (reverb effect)
* Simulated VU meter (level detection)

The project has been developed with *ModelSim PE Student Edition 10.1*. Although it has not been simulated with any other tool, it should be able to work with any simulation software compatible with VHDL.

The quality of the implemented modules may not meet high performance standards. The purpose of this implementation is exclusively educational, and therefore a proper audio processing ability is not guarranteed.

##Installation

I recommend using ModelSim for simulation of this project. A free copy can be obtained from [their site](http://model.com/update/modelsim-downloads) as long as it is used for educational purposes.

If you are a student, visit http://model.com/update/modelsim-downloads and get the free copy they offer. There are also many other compatible tools, such as *GHDL* and *GTKWave*, which can be used for VHDL simulation.

Download the source files from github:
```bash
git clone https://github.com/Krun/vandal-equalizer.git
```

Compile and run the simulation. Testbench files are provided, although they do not provide an exhaustive demonstration of the implemented capabilities.

##FPGA Embedding

This project has not been made with the purpose of being embedded in FPGA's, and therefore, its implementation is not adequate for its direct embedding.
