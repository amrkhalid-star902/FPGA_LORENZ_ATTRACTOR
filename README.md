# FPGA_LORENZ_ATTRACTOR
In this project Lorenz attractor which consists of three coupled differential equations , that their solution gives a shape of butterfly effect in 3d space , is solved on FPGA using numerical integrators , then the digital output is converted into analog signal using Sigma-Delta modulator and displayed on the oscilloscope in X-Y mode.

# Mathematical background 
The Lorenz equations will be solved on the hardware using a circuit called a digital differential analyzer. 
The digital version of a differential analyzer can solve differential equations through numerical integration. 
This is achieved by using accumulators to store the results of repeated addition, which are then converted to pulse rates through the overflow.
Compared to an analog differential analyzer, a DDA can provide greater precision and stability. 
The Lorenz attractor consists of three coupled differential equations described in the following Figure .
![p1](https://github.com/amrkhalid-star902/FPGA_LORENZ_ATTRACTOR/assets/84184457/12e6e2d1-0cdc-4f43-9a9d-1a39c859caba) 



# Sigma-Delta DAC

A delta-sigma modulator is a device that converts a high-resolution digital input signal into a lower-resolution but higher sample-frequency signal. 
This lower-resolution signal is made up of a stream of pulses with varying density or frequency, 
which is then smoothed with an analog filter to reconstruct the original analog signal. Using a delta-sigma modulator as a DAC has the advantage of simplifying circuit design and 
improving efficiency by reducing the number of bits needed to be processed and transmitted. However, the disadvantage is that it introduces noise and distortion due to quantization error and oversampling. 
There is a tradeoff in terms of accuracy and complexity between the first-order sigma-delta modulator and the second-order one. When comparing first and second-order sigma modulators as DAC, there are several differences. A first-order sigma modulator has one integrator and feedback loop, while a second-order sigma modulator has two. The noise shaping function of a first-order sigma modulator attenuates quantization noise by 6 dB per octave, while a second-order sigma modulator attenuates it by 12 dB per octave. 
This means that a second-order sigma modulator can achieve higher SNR and resolution than a first-order sigma modulator for the same oversampling ratio.
A first-order sigma modulator is unconditionally stable, while a second-order sigma modulator requires stability analysis and may exhibit limited cycles or oscillations under certain conditions. 
A first-order sigma modulator has a simple structure and low power consumption, while a second-order sigma modulator has a more complex structure and higher power consumption. Finally, a first-order Sigma modulator produces more repetitive patterns and idle tones in the output spectrum, especially for DC inputs. In contrast, a second-order Sigma modulator produces fewer repetitive patterns and idle tones, improving the linearity of the DAC. In this project, a second-order sigma-delta modulator is used to improve the noise shaping and eliminate unwanted harmonics.

# Lorenz Arrtactor Display on the oscillscope video
https://youtu.be/SFxpYVhq8tM
 
