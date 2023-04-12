# Bike-share in Washington DC

Project for the course "Foundations of Strategic Business Analytics" at ESSEC Business School. 

Data source: https://capitalbikeshare.com/system-data 

R code: https://github.com/nicola-orlando/courses/blob/main/business_ana_essec/Final_Project.R 

## Data and analysis goals 

Look at data of bike-sharing in Washington DC. The available information is as follows 

- Duration – Duration of trip
- Start Date – Includes start date and time
- End Date – Includes end date and time
- Start Station – Includes starting station name and number
- End Station – Includes ending station name and number
- Bike Number – Includes ID number of bike used for the trip
- Member Type – Indicates whether user was a "registered" member (Annual Member, 30-Day Member or Day Key Member) or a "casual" rider (Single Trip, 24-Hour Pass, 3-Day Pass or 5-Day Pass)

The goal of the analysis is to summarise the content of this dataset in a single readable slide. 

## Methodology 

Given the restriction of the project, that is I can't use more than one slide to illustrate the results of the analysis, 
I tried to be as simple as possible, here below the information I extracted from the dataset: 

1. Most users are members: about 50000 casual users about 120000 members
2. Classic bikes are the most popular bikes (see the first table below). Caveat: the actual supply of bikes in unknown, so it might just be that most available bikes are Classic
3. I looked at the most popular stations (see the second table below) 
4. Median of the ride duration is about 10 minutes, with a distribution skewed towards the left.  
5. Using the k-means clustering algorithm, I identified five clusters of customers. Each cluster is characterised by different kind of used bike and customer types

| Bike type     | Number of rented bikes |      
| ------------- |:-------------:|
| Classic  | 140796 | 
| Docked   | 5238   | 
| Electric | 29199  | 

| Station     | Number of rented bikes |      
| ------------- |:-------------:|
|  New Hampshire Ave & T St NW     |  2217  | 
|  Columbus Circle / Union Station |  2192  | 
|  15th & P St NW.                 |  1967  | 


| ![Rplot_ride_duration.pdf](https://github.com/nicola-orlando/courses/files/11215533/Rplot_ride_duration.pdf) | 
|:--:| 
| *Distribution of the duration of the bike rides* |

| ![Rplot_1.pdf](https://github.com/nicola-orlando/courses/files/11215143/Rplot_1.pdf) | 
|:--:| 
| *Customers groups as derived from the k-means clustering algorithm* |

## Results 

Putting it all together .. 

| ![final_project.pdf](https://github.com/nicola-orlando/courses/files/11215582/final_project.pdf) |
|:--:| 
| *Summary of the study* |

