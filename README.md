This directory includes the NEURON code (for data generation) and the Matlab code (for data processing) to demonstrate the bilinear dendritic integration rule of a spatial neuron reported in Li et al PNAS, 2019. The detailed description of the NEURON model can be found in the file Model details.pdf.

NEURON related files: Neuron morphology: n128.hoc, apical_dendrite.hoc, apical_trunk.hoc, axon_sections.hoc, basal_dendrite.hoc, radiatum.hoc, whole_dendrites.hoc. Active ion channels: na3.mod, nax.mod, kdrca1.mod, kaprox.mod, kadist.mod, h.mod. Transmitter receptors: ampa.mod, gabaa.mod.

The effefctive passive parameters of the point neuron model (normalized leak conductance and surface area) are first estimated by placing current clamp to inject current at soma with five different levels. This is done in "pas_parameter_measure.hoc", "pas_parameter_measure.m", and "pas_parameter_evaluation.m".

To generate figure 2 in the paper (the bilinear integration rule for a pair of E-I synpatic inputs), run "EI_pair_random.hoc" first to generate voltage trace data when a pair of E-I synaptic inputs are first given separately and then given together simultaneously. Then run the matlab code "Conductance_Integration_random.m" to identify the bilinear integration rule. "EI_pair_random_delay.hoc" generates data when a pair of E-I synaptic inputs are given and the I input arrives 20ms earlier than the E input. "trace.hoc" and "trace.m" generate Figs. 2B-2D.

To generate figure 3 in the paper (the bilinear integration rule for a pair of E-E or I-I synpatic inputs), run "EE_pair_random.hoc" followed by "conductnce_integration_EE.m", and run "II_pair_random.hoc" followed by "conductnce_integration_II.m".

To geneate figure 5 in the paper (the bilinear integration rule for multiple synaptic inputs), open the folder named Figure5, run the matlab code "DIF_active.m", which will process the data "target.dat" generated by "insimultaneous_multiEI.hoc" in the subfolder named NEURON. 

The programs are run in NEURON 7.4 under the windows operating system. One can use the “mknrndll” command to compile the mod files, and double-click the target program to run.  For linux system, see https://www.neuron.yale.edu/neuron/ for reference.

In several Matlab programs, the function "tsmovavg.m" from Financial Time Series Toolbox is called to smooth data obtained from calculating numerical derivatives. One can comment related lines if the toolbox is not installed in your Matlab. Accordingly, the result maybe slightly different.

Written by Songting Li songting@sjtu.edu.cn Jan. 26, 2020
