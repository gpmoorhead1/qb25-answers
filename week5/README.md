## Mother Questions
1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?
   - The slope is 0.37757. This means that for every increase in 1 year of a mother's age, there is an additional .37 de novo mutations on the population level. This does seem to match the plot.

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.
   - The p value is 2.2e-16, which is below the standard threshold for significance (.05). This p-value means that there is a 2.2e-16 chance of seeing a correlation of this magnitude or greater by chance.


## Father Questions
1. What is the “size” (i.e., slope) of this relationship? Interpret the slope in plain language. Does it match your plot?
   - The slope is 1.35384. This means that for every increase in 1 year of a father's age, there is an additional 1.35384 de novo mutations on the population level. This does seem to match the plot.

2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.
   - The p value is 2.2e-16, which is below the standard threshold for significance (.05). This p-value means that there is a 2.2e-16 chance of seeing a correlation of this magnitude or greater by chance.


## Model Prediction

Code:
```
model_F <- lm(data=filter(M, Phase_combined=='father'), formula=n ~ 1 + Father_age)
newd <- data.frame(Father_age=50.5)
predict(model_F, newd)
```

Result: 78.69546 DNMs

## T Test
1. What is the “size” of this relationship (i.e., the average difference in counts of maternal and paternal DNMs)? Interpret the difference in plain language. Does it match your plot?
   - On average, there is a difference of 39.23485 DNMs between men and women, which matches the plot.
2. Is the relationship significant? How do you know? Explain the p-value in plain but precise language.
   - There is a 2.2e-16 chance of seeing this big of a difference between the 2 distributions or bigger by chance, which is significant.
3. How would you interpret the coefficient estimate for the intercept term?
   - The estimate for the intercept coefficient is the distance between the 2 averages of the distributions.
  

## Problem 3
I chose Billboard Hot 100 Number Ones.

Observations:
- Seems like the acousticness of the top song has decreased over time.
- Divisiveness of top song has maybe slightly increased over time.
- Rating of top song seems correlated with the number of weeks it spent at number one.

Linear Model: I tested if song happiness could be explained by song energy, danceability, and bpm.
Formula: happiness ~ 1 + energy + danceability + bpm.
The model has an r^2 value of 0.2952, meaning that it has a decent fit. Energy and danceability have coefficients of 0.456 and 0.518 respectively, meaning that they explain a good portion of the data.
Meanwhile, bpm has a coefficient near 0, meaning that it doesn't explain much of the data.
Energy and danceability both have p-values less that 2e-16, meaning that there is that low of a probability of seeing a variable explain that much of the data or more by chance.
