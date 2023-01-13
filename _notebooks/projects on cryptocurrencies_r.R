



#------------------------------------------------------------------------------ 

PREDICTING THE RETURNS OF BITCOIN USING OTHER CRYPTOCURRIES 

#------------------------------------------------------------------------------
             
PACKAGES USED IN THIS PROGECT

library(crypto2)
library(timeSeries)
library(tidyverse)
library(ggplot2)
library(ggpubr)
library(report)
library(aTSA)
library(robustbase)
library(lmtest)
library(olsrr)






write.csv(cryptodata_reedited,'C:\\Users\\PC\\Desktop\\data\\final_data.CSV', row.names = FALSE) 
# cryptodata_reedited['returns_currencies'] <- returns(cryptodata_reedited$close)    #  use the 'timeseries' package to convert the price to returns.

write.csv(final_data,'C:\\Users\\PC\\Desktop\\data\\final_data.CSV', row.names = FALSE) 




 DOWNLOAD CRYPTOCURRENCIES DATA FROM CoinMarketCap


library(crypto2)
Active_coins <- crypto_list(only_active = TRUE)    # It retrieves lists of active cryptocurrencies historical data

cryptodata <- crypto_history(coin_list = Active_coins,limit = 5, start_date = "20211107", end_date="20221109")    # Retrieve 5 of active cryptocurrencies  from  2021-11-09 to  2022-11-09.




cryptodata_reedited<- subset(cryptodata, select = c(timestamp, symbol,name, close ))      # Subset the data for the historical data on timestamp, symbol,name and  close

cryptodata_reedited['date'] <- as.Date(cryptodata_reedited$timestamp)     # Convert the time stamp to date for convenience. 



head(cryptodata_reedited) #  visualize the beginning of the cryptodata_reedited data frame using head function


ppppppppppppppppppppppppppppppppppppppppppp
# gpt3 optimisation

Here are a few suggestions for optimizing the code you provided:

If you only need a subset of the data returned by crypto_history(), consider specifying the columns you want to retrieve in the columns argument of the function, rather than subsetting the data after it has been retrieved. This can help reduce the amount of data you need to store and process in memory.

You can use the lapply() function to apply a function to each element of a list, rather than looping through the list manually. In this case, you could use lapply() to retrieve the data for each cryptocurrency in the Active_coins list in parallel, which may be faster than retrieving them sequentially.

You can use the data.table package to manipulate large data sets more efficiently. For example, you can use the setDT() function to convert a data frame to a data table, and then use the fread() function to read the data directly into a data table. This can be much faster than reading the data into a data frame and then converting it to a data table.

If you are only interested in a specific range of dates, consider using the start and end arguments of the crypto_history() function to filter the data by date. This can help reduce the amount of data you need to process and store in memory.

Consider using the gc() function to manually trigger garbage collection and free up memory that is no longer needed. This can be especially useful if you are working with large data sets and are running out of memory.

I hope these suggestions are helpful! Let me know if you have any questions or need further assistance.



give me the code


Here is an example of how you could modify the code you provided to incorporate the suggestions I mentioned:

Here is an example of how you could modify the code you provided to incorporate the suggestions I mentioned:


library(crypto2)

# Retrieve a list of active cryptocurrencies
Active_coins <- crypto_list(only_active = TRUE)

# Use lapply() to retrieve the data for each cryptocurrency in parallel
cryptodata_list <- lapply(Active_coins, function(coin) {
  crypto_history(coin_list = coin, limit = 5, start_date = "20211107", end_date = "20221109", columns = c("timestamp", "symbol", "name", "close"))
})

# Combine the data for each cryptocurrency into a single data frame
cryptodata <- do.call(rbind, cryptodata_list)

# Convert the data frame to a data table and set the key to the timestamp column
library(data.table)
setDT(cryptodata, key = "timestamp")

# Convert the timestamp column to a date
cryptodata[, date := as.Date(timestamp)]

# Visualize the beginning of the data table
head(cryptodata)



This code uses lapply() to retrieve the data for each cryptocurrency in parallel, combines the data into a single data frame using do.call() and rbind(), converts the data frame to a data table using the data.table package, and converts the timestamp column to a date.

I hope this helps! Let me know if you have any questions or need further assistance.



or

optimize this code too
Sure! Here are a few suggestions for optimizing the code you provided:

If you are working with large data sets and are running out of memory, consider using the fread() function from the data.table package to read the data directly into a data table. This can be much faster than reading the data into a data frame and then converting it to a data table.

You can use the setkey() function from the data.table package to set the key of the data table to the timestamp column. This can help improve the performance of certain operations, such as sorting and subsetting the data.

If you only need to perform a few specific operations on the data, consider using the data.table syntax for those operations, rather than using dplyr functions. For example, you can use the .SD syntax to apply a function to a subset of the data, or use the := operator to create new columns.

You can use the gc() function to manually trigger garbage collection and free up memory that is no longer needed. This can be especially useful if you are working with large data sets and are running out of memory.

If you are working with a large data set and only need to process a subset of the data, consider using the fread() function to read only the data you need. For example, you can use the select argument to specify which columns to read, or use the start and stop arguments to read only a certain number of rows.

I hope these suggestions are helpful! Let me know if you have any questions or need further assistance.



give the codes
Here is an example of how you could modify the code you provided to incorporate the suggestions I mentioned:

library(data.table)

# Read the data directly into a data table using fread()
cryptodata <- fread("cryptodata.csv")

# Set the key of the data table to the timestamp column
setkey(cryptodata, timestamp)

# Use data.table syntax to create a new column for the date
cryptodata[, date := as.Date(timestamp)]

# Use data.table syntax to filter the data by date
cryptodata_subset <- cryptodata[date >= "2022-01-01" & date < "2022-02-01"]

# Use data.table syntax to apply a function to a subset of the data
cryptodata_subset[, mean_close := mean(close), by = symbol]

# Visualize the beginning of the data table
head(cryptodata_subset)

This code reads the data directly into a data table using fread(), sets the key of the data table to the timestamp column using setkey(), and uses data.table syntax to create a new column for the date, filter the data by date, and apply a function to a subset of the data.

I hope this helps! Let me know if you have any questions or need further assistance.





SUBSET, AND CONVERT THE CLOSE VALUES TO RETURNS USING subset, and timeseries PACKAGE

Bitcoin <- subset(cryptodata_reedited, name == 'Bitcoin', select = c(date, close))  # Subset Bitcoin from the data and select it's date, and close columns
Bitcoin['close'] <- returns(Bitcoin$close)    #  Convert the close values to returns using the timeseries package
colnames(Bitcoin)[2]<- 'bitcoin_returns'      # Name the second column bitcoin_returns



Litecoin <- subset(cryptodata_reedited, name == 'Litecoin', select = c(date, close))   # Subset Litecoin from the data and select it's date, and close columns
Litecoin['close'] <- returns(Litecoin$close)    #  Convert the close values to returns using the timeseries package
colnames(Litecoin)[2]<- 'litecoin_returns'      # Name the second column litecoin_returns


Namecoin<- subset(cryptodata_reedited, name == 'Namecoin', select = c(date, close))     # Subset Namecoin from the data and select it's date, and close columns
Namecoin['close'] <- returns(Namecoin$close)    #  Convert the close values to returns using the timeseries package
colnames(Namecoin)[2]<- 'namecoin_returns'      # Name the second column namecoin_returns

Terracoin <- subset(cryptodata_reedited, name == 'Terracoin' , select = c(date, close)) # Subset Terracoin from the data and select it's date, and close columns
Terracoin['close'] <- returns(Terracoin$close)    #  Convert the close values to returns using the timeseries package
colnames(Terracoin)[2]<- 'terracoin_returns'      # Name the second column terracoin_returns

Peercoin<- subset(cryptodata_reedited, name == 'Peercoin', select = c(date, close))     # Subset Peercoin from the data and select it's date, and close columns
Peercoin['close'] <- returns(Peercoin$close)    #  Convert the close values to returns using the timeseries package
colnames(Peercoin)[2]<- 'peercoin_returns'      # Name the second column peercoin_returns





VISUALISE THE RETURNS OF THE FIVE CRYPTOCURENCIES TO BE USED IN THE ANALYSIS USING ggplot2 

b<- ggplot(data = Bitcoin, mapping = aes(date, bitcoin_returns))+geom_line()        #  Assign the Bitcoin plot to b using ggplot 2

bt<- b + theme(panel.grid.major = element_line(colour = "lavender"),
    panel.background = element_rect(fill = "ivory1"),
    plot.background = element_rect(fill = "aliceblue"))   # The theme of  returns of bitcons was changed to make it diffirent 



l<-  ggplot(data = Litecoin, mapping = aes(date, litecoin_returns))+geom_line()     # Assign the Litecoin plot to l using ggplot 2

n<-  ggplot(data = Namecoin, mapping = aes(date,  namecoin_returns))+geom_line()    # Assign the  Namecoin plot to using ggplot 2

t<- ggplot(data = Terracoin, mapping = aes(date,  terracoin_returns))+geom_line()   # Assign the  Terracoin plot to t using ggplot 2

p<- ggplot(data = Peercoin, mapping = aes(date,  peercoin_returns))+geom_line()     # Assign the Peercoin  plot to p using ggplot 2



COMBINE THE GRAPHS TO FORM ON GRAPH


text<- paste('         This graph shows the returens of the five cryptocurencies in this analysis', ' *Bitcoin,', ' * Litecoin,', ' *Namecoin', ' *Terracoin',' *Peercoin', sep = '')  # The texts on the combined graph are set using  the ggpubr package

text.p <- ggparagraph(text = text, face = 'italic', size = 14, color = 'blue')    # The specifications for the texts are set  using  the ggpubr package

ggarrange(bt,l,n, t, p, text.p, ncol = 1) # The plots and texts are fused  together using  the ggpubr package







JOIN ALL THE RETURNS  TO FORM ONE DATA FRAME USING THE tidyverse PACKAGES

Almost_final_data <- Bitcoin %>% inner_join(Litecoin, by = 'date') %>% inner_join(Namecoin, by = 'date') %>% inner_join(Terracoin, by ='date')%>% inner_join(Peercoin, by = 'date')  # Join the returns to form on data frame using the  tidyverse package for further statistical analysis

final_data <- Almost_final_data[-1, c(2,3,4,5,6)] # Deleted the first empty raw and assigned it to final_data

head(final_data)  # visualize the beginning of the final_data data frame using head function
 







PERFORM EXPLORATORY DATA ANALYSIS

over_view_data <- data.frame( report(final_data)) # created a data frame containing the descriptive statistic of final_data using the report package.
report(final_data)                                # It give a detail descriptive analysis on the final data.
plot(final_data)                                  # Because a regression is going to be conducted let take a look the scatter plot of the variables.


























In other to get a misleading results, it is of great importance to do a stationary test.


STATIONARITY TESTS ON THE FIVE VARIABLES  (CRYPTOCURENCIES)  


#-------                                    Augmented Dickey-Fuller Test 
#                                             alternative: stationary 

# 1. Check the stationarity of all the returns of the cryptocurrencies using  Augmented Dickey-Fuller Test.                                            

stationary.test(final_data$bitcoin_returns)          #   The stationarity of bitcoin_returns is tested using the Augmented Dickey-Fuller Test from aTSA package.
 # Interpretation: With  a maximum lag of 5 the returns of Bitcon (bitcoin_returns) is stationary across all the three kinds of Augmented Dickey-Fuller Test (Type 1: no drift no trend, Type 2: with drift no trend,Type 3: with drift and trend ).


stationary.test(final_data$litecoin_returns)    #   The stationarity of litecoin is tested using the Augmented Dickey-Fuller Test from  aTSA package.    

# Interpretation: With  a maximum lag of 5 the returns of litecoin (litecoin_returns) is stationary across all the three kinds of Augmented Dickey-Fuller Test (Type 1: no drift no trend, Type 2: with drift no trend,Type 3: with drift and trend ).




stationary.test(final_data$namecoin_returns)        #   The stationarity of namecoin_returns is tested using the Augmented Dickey-Fuller Test from  aTSA package.
# Interpretation: With  a maximum lag of 5 the returns of namecoin (namecoin_returns) is stationary across all the three kinds of Augmented Dickey-Fuller Test (Type 1: no drift no trend, Type 2: with drift no trend,Type 3: with drift and trend ).





stationary.test(final_data$terracoin_returns)      #   The stationarity of terracoin_returns is tested using the the Augmented Dickey-Fuller Test from  aTSA package.
# Interpretation: With  a maximum lag of 5 the returns of terracoin (terracoin_returns) is stationary across all the three kinds of Augmented Dickey-Fuller Test (Type 1: no drift no trend, Type 2: with drift no trend,Type 3: with drift and trend ).



stationary.test(final_data$peercoin_returns)        #   The stationarity of peercoin_returns is tested using the the Augmented Dickey-Fuller Test from aTSA package.

# Interpretation: With  a maximum lag of 5 the returns of peercoin (peercoin_returns) is stationary across all the three kinds of Augmented Dickey-Fuller Test  (Type 1: no drift no trend, Type 2: with drift no trend,Type 3: with drift and trend ).

Note: in fact, p.value = 0.01 means p.value <= 0.01 


      
      







                            #        Phillips-Perron Unit Root Test 
                            #          alternative: stationary  


#   Check the stationarity of all the returns of the cryptocurrencies using  Phillips-Perron Unit Root Test to confirm the results from  Augmented Dickey-Fuller. This is because Phillips-Perron test makes correction to the test statistics and is robust to the unspecified autocorrelation and heteroscedasticity in the errors.
                                    


# Note: p-value = 0.01 means p.value <= 0.01 


stationary.test(final_data$bitcoin_returns, method = c( "pp"), type = c( "Z_tau"), lag.short = TRUE)  # The stationarity of bitcoin_returns is tested using the  Phillips-Perron Unit Root Test from aTSA package.

 # Interpretation: With  a maximum lag of 5 the returns of Bitcon (bitcoin_returns) is stationary across all the three kinds of  Phillips-Perron Unit Root Test (Type 1: no drift no trend , Type 2: with drift no trend and Type 3: with drift and trend ).
 

 
stationary.test(final_data$litecoin_returns, method = c( "pp"), type = c( "Z_tau"), lag.short = TRUE) #   The stationarity of litecoin is tested using the Phillips-Perron Unit Root Test from  aTSA package.
# Interpretation: With  a maximum lag of 5 the returns of litecoin (litecoin_returns) is stationary across all the three kinds of  Phillips-Perron Unit Root Test (Type 1: no drift no trend , Type 2: with drift no trend and Type 3: with drift and trend ).
  

stationary.test(final_data$namecoin_returns, method = c( "pp"), type = c( "Z_tau"), lag.short = TRUE) #   The stationarity of namecoin_returns is tested using the Phillips-Perron Unit Root Test from  aTSA package.
# Interpretation: With  a maximum lag of 5 the returns of namecoin (namecoin_returns) is stationary across all the three kinds of  Phillips-Perron Unit Root Test (Type 1: no drift no trend , Type 2: with drift no trend and Type 3: with drift and trend ).



stationary.test(final_data$terracoin_returns, method = c( "pp"), type = c( "Z_tau"), lag.short = TRUE)  #   The stationarity of terracoin_returns is tested using the  Phillips-Perron Unit Root Test from  aTSA package.
# Interpretation: With  a maximum lag of 5 the returns of terracoin (terracoin_returns) is stationary across all the three kinds of  Phillips-Perron Unit Root Test (Type 1: no drift no trend , Type 2: with drift no trend and Type 3: with drift and trend ).



stationary.test(final_data$peercoin_returns, method = c( "pp"), type = c( "Z_tau"), lag.short = TRUE)    # The stationarity of peercoin_returns is tested using the Phillips-Perron Unit Root Test from aTSA package.
# Interpretation: With  a maximum lag of 5 the returns of peercoin (peercoin_returns) is stationary across all the three kinds of  Phillips-Perron Unit Root Test (Type 1: no drift no trend , Type 2: with drift no trend and Type 3: with drift and trend ).

Note: p-value = 0.01 means p.value <= 0.01 


gpt3 suggections 


in python write a code to do stationarity tests , provide the null and alternative hypothesis











RUN REGRESIONS TO TEST IF THE RETURNS OF THE OTHER CRYPTOCURRENCIES HAS THE STATISTICAL POWER TO PREDICT THE RETURNS OF BITCOIN



reglm<- lm(bitcoin_returns~ litecoin_returns + namecoin_returns +terracoin_returns , data =final_data)    # This is a linear regression model containing the four cryptocurencies returns and it it is assigned to reglm
summary(reglm)   # it prints the summary report of the linear regression assigned to reglm



The Intercept and terracoin_returns are not statistically significant, so to produce accurate results they should be taken from the equation. So the equation below is pustulated. 

reglm_int<- lm(bitcoin_returns~ litecoin_returns + namecoin_returns +0 , data =final_data)    # This is a linear regression model containing the three cryptocurencies returns with out the intercept which are statisticaly significant in predicting the returns of Bitcoin and assigned to reglm_int
summary(reglm_int)   # it prints the summary report of the linear regression assigned to reglm_int



CHECK THE MODELS FOR  outlierS AND RUN A ROBUST MODEL


ols_plot_resid_lev(reglm_int) # Graph for detecting outliers and/or observations with high leverage using the olsrr package

The results shows that there are outliers in our model capable of influencing the results. so we need models that are robost to outliers




USING ROBUST MODELS TO OUTLIERS

regrob <- lmrob(bitcoin_returns~ litecoin_returns + namecoin_returns +0 , data =final_data)    # This is an MM-type Estimators for Linear Regression which is robust to outliers using the robustbase package and assigned to regrob.
summary(regrob)    # it prints the summary report of the linear regression assigned to regrob





SUMMARIZING THE RESULTS OF THE THREE MODELS INTO ONE TABLE

stargazer(reglm,reglm_int, regrob, title="This table shows that the return of Bicon can be predicted with the returns of litecoin and  Namecoin", type = 'text')  # it put the summary report of the regression models together in on table  'stargazer' package














ts_almost_final<- ts(Almost_final_data, start = 2021-11-08)

reglm_int_ts<- lm(bitcoin_returns~ litecoin_returns + namecoin_returns +0 , data = ts_almost_final)    # This is a linear regression model containing the three cryptocurencies returns with out the intercept which are statisticaly significant in predicting the returns of Bitcoin and assigned to reglm_int
summary(reglm_int_ts)
predict(reglm_int_ts, newdata = window(ts_almost_final, start = 2022-11-08), interval = 'prediction')


