#Data
revenue <- c(14574.49, 7606.46, 8611.41, 9175.41, 8058.65, 8105.44, 11496.28, 9766.09, 10305.32, 14379.96, 10713.97, 15433.50)
expenses <- c(12051.82, 5695.07, 12319.20, 12089.72, 8658.57, 840.20, 3285.73, 5821.12, 6976.93, 16618.61, 10054.37, 3803.96)

#Solution
?round
# This is right
profit <- revenue - expenses
profit
# didn't initially see round to two decimal places
tax <- round(profit * 0.3, 2)
tax
# this was correct
aftertax <- profit - tax
aftertax

# Missed this step. 
#Calculate The Profit Margin As Profit After Tax Over Revenue
#Round To 2 Decimal Points, Then Multiply By 100 To Get %
profit.margin <- round(aftertax / revenue, 2) * 100
profit.margin

#Calculate The Mean Profit After Tax For The 12 Months
avgMonths <- round(mean(aftertax), 2)
avgMonths

#Find The Months With Above-Mean Profit After Tax
goodMonths <- aftertax > avgMonths
goodMonths
# Find those below
badMonths <- !goodMonths
badMonths

# find the max
maxYear <- max(aftertax)
maxYear

#The Best Month Is Where Profit After Tax Was Equal To The Maximum
best.month <- aftertax == max(aftertax)
best.month

# finds the minimum
minYear <- min(aftertax)
minYear

#The Worst Month Is Where Profit After Tax Was Equal To The Minimum
worst.month <- aftertax == min(aftertax)
worst.month

# here's where I'm a bit lost
#Convert All Calculations To Units Of One Thousand Dollars
revenue.1000 <- round(revenue / 1000, 0)
expenses.1000 <- round(expenses / 1000, 0)
profit.1000 <- round(profit / 1000, 0)
aftertax.1000 <- round(aftertax / 1000, 0)

revenue.1000
expenses.1000
profit.1000
aftertax.1000
profit.margin
goodMonths
badMonths
best.month
worst.month

# making a Matric
M <- rbind(
  revenue.1000,
  expenses.1000,
  profit.1000,
  aftertax.1000,
  profit.margin,
  goodMonths,
  badMonths,
  best.month,
  worst.month
)
M
