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
