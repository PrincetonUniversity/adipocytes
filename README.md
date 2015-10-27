# adipocytes metabolic flux analysis
Determine adipocyte central carbon fluxes and confidence intervals via metabolic flux analysis

- data.xlsx has labeling fractions, measured fluxes, and net/exchange flux inequality constraints that went into the model as input.
- model3.xml shows the metabolites, reactions, carbon mapping, and flux equality constraints

To run:
1) Open Matlab 2013b or newer.
2) Set Path -> Add Folder -> Choose ./src -> Save
3) Open script.m and execute
4) To run it parallel, enter 'matlabpool local 4' on the command line. '4' can be a different number if a different number of cores is desired.
