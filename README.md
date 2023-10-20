# double-well-model
The codebase for the paper: https://www.biorxiv.org/content/10.1101/2023.07.17.549266v1.abstract

## Usage
Requirements: Matlab 2021;

Two packages are provided:
* model_theory - to get the theoretical results for the double-well potential model
  
  The workflow of the code:
  
  1. solve the asymptotic distribution of the weights through ```model_theory/recursion_relation.m```
  2. calculate the local field of patterns given the distribution of weights through ```model_theory/cal_local_field.m```
  3. solve the self-consistent equation for retrieval quality through ```model_theory/cal_overlap_from_local_field.m```

  One example is provided in ```model_theory/main.m```
  
* model_simulation - to get the simulation results for the double-well potential model

  The example of the simulation is provided in ```model_simulation/main.m```

* what to expect:
  Each ```main.m``` in ```model_theory``` and ```model_simulation``` will give two plots:
  * the asymptotic distribution of the weights
  * retrieval quality vs memory age
    
  The results from theoretical analysis and simulations should align.

