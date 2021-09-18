
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


# R Session Info

```r
R version 4.1.1 (2021-08-10)
Platform: x86_64-apple-darwin17.0 (64-bit)
Running under: macOS Big Sur 11.6

Matrix products: default
LAPACK: /Library/Frameworks/R.framework/Versions/4.1/Resources/lib/libRlapack.dylib

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] parallel  stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] INLA_21.02.23   sp_1.4-5        foreach_1.5.1   Matrix_1.3-4    here_1.0.1      forcats_0.5.1  
 [7] stringr_1.4.0   dplyr_1.0.7     purrr_0.3.4     readr_2.0.1     tidyr_1.1.3     tibble_3.1.4   
[13] ggplot2_3.3.5   tidyverse_1.3.1

loaded via a namespace (and not attached):
 [1] tidyselect_1.1.1 splines_4.1.1    haven_2.4.3      lattice_0.20-44  colorspace_2.0-2 vctrs_0.3.8     
 [7] generics_0.1.0   utf8_1.2.2       rlang_0.4.11     pillar_1.6.2     glue_1.4.2       withr_2.4.2     
[13] DBI_1.1.1        dbplyr_2.1.1     modelr_0.1.8     readxl_1.3.1     lifecycle_1.0.0  munsell_0.5.0   
[19] gtable_0.3.0     cellranger_1.1.0 rvest_1.0.1      codetools_0.2-18 tzdb_0.1.2       fansi_0.5.0     
[25] broom_0.7.9      Rcpp_1.0.7       scales_1.1.1     backports_1.2.1  jsonlite_1.7.2   fs_1.5.0        
[31] hms_1.1.0        stringi_1.7.4    grid_4.1.1       rprojroot_2.0.2  cli_3.0.1        tools_4.1.1     
[37] magrittr_2.0.1   crayon_1.4.1     pkgconfig_2.0.3  ellipsis_0.3.2   xml2_1.3.2       reprex_2.0.1    
[43] lubridate_1.7.10 assertthat_0.2.1 httr_1.4.2       rstudioapi_0.13  iterators_1.0.13 R6_2.5.1        
[49] compiler_4.1.1  
```

<br>
<br>
<br>
<br>











