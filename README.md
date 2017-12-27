# dissertation
Code from my PhD dissertation

"tetrad-lib-diss" contains the main source code, including tsFCI and tsGFCI.
"comparison-sim.zip" contains the output from the simulations comparing tsFCI and tsGFCI at various sample sizes to a known graph. See Chapter 4. The simulation code for producing this output is in the "algcomparison" package, directory "examples", filename "ExampleCompareSimulationTimeSeries".
"cvar.simXXX.zip" contains the output from the nonstationary simulations, where XXX is the sample size. See Chapter 5. There is an additional 10K sample size not included here, becauase of github's file size restrictions. The simulation code for producing this output is in the R file "ts_sim_cvar.R"

NOTE: this code is a "frozen" version of TETRAD from late 2017, and not up-to-date with the TETRAD repository. So, it is probably/definitely incompatible with TETRAD as it currently exists. The intent is just to keep record of the code used in my dissertation. If you are interested in using tsFCI or tsGFCI with TETRAD please use the current version of TETRAD, available at: http://github.com/cmu-phil/tetrad
