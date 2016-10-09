library(sunburstR)

sequence_data <- read.csv("visit-sequences.csv",header=F,stringsAsFactors = FALSE)

sunburst(sequence_data)

urlfile<-"http://gist.githubusercontent.com/mkajava/7515402/raw/9f80d28094dc9dfed7090f8fb3376ef1539f4fd2/comment-sequences.csv"

