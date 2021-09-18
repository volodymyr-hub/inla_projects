
# Time Series Analysis using R-INLA library

This repo contains few examples how to fit multivariate time series models of counts using R-INLA package. 

Examples are taken from the Chapter 5 of:

>Serhiyenko, Volodymyr. "Dynamic Modeling of Multivariate Counts-Fitting, Diagnostics, and Applications." (2015).


[Dynamic Modeling of Multivariate Counts-Fitting, Diagnostics, and Applications.](https://opencommons.uconn.edu/dissertations/858/)

## Code 

Please go to `Rcode` folder and run the file named `multivariate_counts_inla.R`

## Data 

The sample of the prescription data from four physicians across 43 months. 

Data elements: 

- `pcp_id`: unique PCP identifier
- `r_name`: drug name
- `r_index`: index corresponding to the drug name
- `time`: monthly identifier
- `y_obs`: number of the prescriptions written by the PCP
- `y`: the same as `y_obs` but without the last month data (response variable in the model)
- `detailing_focal`: number of sales visits to the physician (only known for the Focal drug)


## Models

List of models covered in the code:

- Model 1: One PCP and Different UDC's 
  - separate time trends, mixed UDC's
  - separate time trends, Poisson UDC's
  - separate time trends, ZIP UDC's
- Model 2: One PCP and Common/Shared vs Separate Time Trends
  - separate time trends
  - common/shared time trend
- Model 3: All PCP's and Poisson UDC's
- Example how to get predictions


# References

- Serhiyenko, Volodymyr. "Dynamic Modeling of Multivariate Counts-Fitting, Diagnostics, and Applications." (2015).
- Serhiyenko, Volodymyr, Nalini Ravishanker, and Rajkumar Venkatesan. "Multi‐stage multivariate modeling of temporal patterns in prescription counts for competing drugs in a therapeutic category." Applied Stochastic Models in Business and Industry 34, no. 1 (2018): 61-78.
- [R-INLA website](https://www.r-inla.org/home)


<br>
<br>
<br>
<br>











