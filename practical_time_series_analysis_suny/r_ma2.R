# Generate noise 
noise = rnorm(10000)
# Introduce a var 
ma_2 = NULL 
for(i in 3:10000){
	ma_2[i] = noise[i] + 0.7*noise[i-1] + 0.2*noise[i-2]
}
moving_average_process = ma_2[3:10000]
# Put the dataset into a time series object 
moving_average_process=ts(moving_average_process)
# Create a multi fig 
par(mfrow = c(2,1))
# Plot things
plot(moving_average_process, main = 'Moving average processs', col = 'blue')
acf(moving_average_process, main = 'Moving average processs AC', col = 'red')