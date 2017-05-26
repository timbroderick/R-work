# first homework exercise
# test how often randome numbers
# are between 1 and -1 on normal
# dist. rnorm() generates numbers
# based on normal dist
N <-1000

counter <- 0


for( i in rnorm(N) ){
  if( (i > -1) & (i < 1) ){
    counter <- counter + 1
  }
}

answer <- counter / N
print(answer)
if (answer <= 0.682 ){
  print("yes")
} else {
  print("Nope")
}
# answer should be close to 68.1% as 
# that's likelihood of numbers being
# normally distributed