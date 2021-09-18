

# Load Libraries ------

library(tidyverse)
library(here)
library(INLA)


# Read data -------

pcp_all_dat = read_csv( here( "Data", "PCP_sample.csv" ) )

pcp_all_dat %>% glimpse()

pcp_all_dat %>% 
  group_by( pcp_id ) %>%
  summarise( n_time = n_distinct( time )  )


# Model 1: One PCP: Different UDCs --------

## Prepare Data for INLA -------

#### select PCP #######

pcp_dat = pcp_all_dat %>%
  filter( pcp_id == 1178 ) 

pcp_dat %>%
  print( n = Inf )

#### get indexes #########

pcp_dat = pcp_dat %>%
  mutate( t_index = 1:n(), 
          r_index_copy = r_index )

N = pcp_dat %>% summarise( n = n() ) %>% pull()


#### Response vector (need matrix) #########

Y = matrix( NA, N, 3)
Y[, 1] = c(  pcp_dat$y[ 1:43 ], rep( NA, 43 ), rep( NA, 43 ) )
Y[, 2] = c(  rep( NA, 43 ), pcp_dat$y[ 44:86 ], rep( NA, 43 ) )
Y[, 3] = c(  rep( NA, 43 ), rep( NA, 43 ), pcp_dat$y[ 87:129 ] ) 

N
Y


pcp_dat %>% glimpse()


## Model: separate time trends, mixed UDCs ---------

formula = Y ~ -1 + detailing_focal +
  f( r_index_copy, model="iid" )+
  f( t_index, model = "iid3d", n = N )+
  f( time, model = "rw1", replicate = r_index )


model_1a = inla( formula,
                family = c( "zeroinflatedpoisson1",
                             "poisson",
                             "zeroinflatedpoisson1" ),
            data = pcp_dat,
            control.compute = list( dic = TRUE ),
            control.predictor = list( compute = TRUE,
                                      link = 1 ) 
            )



summary( model_1a )
plot( model_1a )



## Model: separate time trends, Poisson UDC ---------


model_1b = inla( formula,
                 family = rep( "poisson", 3 ),
                 data = pcp_dat,
                 control.compute = list( dic = TRUE ),
                 control.predictor = list( compute = TRUE,
                                           link = 1 ) 
)



summary( model_1b )
plot( model_1b )



## Model: separate time trends, ZIP UDCs ---------


model_1c = inla( formula,
                 family = rep( "zeroinflatedpoisson1", 3 ),
                 data = pcp_dat,
                 control.compute = list( dic = TRUE ),
                 control.predictor = list( compute = TRUE,
                                           link = 1 ) 
)



summary( model_1c )
plot( model_1c )



##  Compare  ----------------------

model_1a$dic$dic
model_1b$dic$dic
model_1c$dic$dic




# Model 2: One PCP: common vs separate Time Trends --------


#### Model: Separate Time Trends

formula = Y ~ -1 + detailing_focal +
  f( r_index_copy, model="iid" )+
  f( t_index, model = "iid3d", n = N )+
  f( time, model = "rw1", replicate = r_index )



model_2a = inla( formula,
                 family = rep( "poisson", 3 ),
                 data = pcp_dat,
                 control.compute = list( dic = TRUE ),
                 control.predictor = list( compute = TRUE,
                                           link = 1 ) 
                 )


summary( model_2a )
plot( model_2a )


#### Model: Common (Shared) Time Trend

formula = Y ~ -1 + detailing_focal +
  f( r_index_copy, model="iid" )+
  f( t_index, model = "iid3d", n = N )+
  f( time, model = "rw1" )


model_2b = inla( formula,
                 family = rep( "poisson", 3 ),
                 data = pcp_dat,
                 control.compute = list( dic = TRUE ),
                 control.predictor = list( compute = TRUE,
                                           link = 1 ) 
                 )

summary( model_2b )
plot( model_2b )


##  Compare  ----------------------

model_2a$dic$dic
model_2b$dic$dic



# Model 3: All PCP's: Poisson UDC --------

## Prepare Data for INLA -------

pcp_all_dat %>% glimpse()

pcp_all_dat %>%
  group_by( r_name ) %>%
  summarise( n = n() )

#### get indexes #########

pcp_all_dat2 = pcp_all_dat %>%
  mutate( t_index = 1:n(), 
          r_index_copy = r_index ) %>%
  mutate( b0_focal = if_else( r_name == "Focal Drug", 
                              1L, 
                              NA_integer_ ),
          b0_leader = if_else( r_name == "Leader Drug", 
                              1L, 
                              NA_integer_ ), 
          b0_challenger = if_else( r_name == "Challenger Drug", 
                              1L, 
                              NA_integer_ )  ) %>%
  mutate( time_focal = if_else( r_name == "Focal Drug", 
                              time %>% as.integer(), 
                              NA_integer_ ),
          time_leader = if_else( r_name == "Leader Drug", 
                               time %>% as.integer(), 
                               NA_integer_ ), 
          time_challenger = if_else( r_name == "Challenger Drug", 
                                   time %>% as.integer(), 
                                   NA_integer_ )  )

N = pcp_all_dat2 %>% summarise( n = n() ) %>% pull()


#### Response vector (need matrix) #########

Y = matrix( NA, N, 3)
Y[, 1] = c(  pcp_all_dat2$y[ 1:43 ], rep( NA, 43 ), rep( NA, 43 ) )
Y[, 2] = c(  rep( NA, 43 ), pcp_all_dat2$y[ 44:86 ], rep( NA, 43 ) )
Y[, 3] = c(  rep( NA, 43 ), rep( NA, 43 ), pcp_all_dat2$y[ 87:129 ] ) 

N
Y %>% head( n = 45 )
Y %>% tail( n = 45 )


pcp_all_dat2 %>% glimpse()




formula = Y ~ -1 + detailing_focal+
  b0_focal + 
  b0_leader + 
  b0_challenger +
  f( t_index, model = "iid3d", n = N ) +
  f( time_focal, model = "rw1" )+
  f( time_leader, model = "rw1" )+
  f( time_challenger, model = "rw1" )


model_3 = inla( formula,
              family = rep( "poisson", 3 ), 
              data = pcp_all_dat2,
              control.compute = list( dic = TRUE ),
              control.predictor = list( compute = TRUE, link = 1)  )


summary( model_3 )
plot( model_3 )



# Predictions --------


pcp_dat %>% 
  print( n = Inf )

fitted_dat = model_2a$summary.fitted.values %>%
  as_tibble() %>%
  mutate( t_index = row_number() )

fitted_dat

#### Add Predictions: posterior mean #####

pcp_dat2 = pcp_dat %>%
  inner_join( fitted_dat %>% select( mean, t_index ) ) 

pcp_dat2 %>%
  filter( is.na( y ) ) 

pcp_dat2 %>%
  filter( is.na( y ) ) %>%
  mutate( abs_diff = abs( y_obs - mean )  ) %>%
  summarise( PMAE = mean( abs_diff ) )
    

