## Chatbot
Chatbot <- function(){
  cat("Hello, what's your name? ")
  name <- readLines("stdin", 1)
  print(paste("Hi ", name))
  cat("How old are you? ")
  age <- readLines("stdin", 1)
  print(paste( name,"is", age, "Years old"))
  cat("What's your gender? ")
  gender <- readLines("stdin", 1)
  print(paste(name, "is", gender))
  
  if (gender == "Female"){
    cat("Do you like makeup? ")
    ans1 <- readLines("stdin", 1)
      if (ans1 == "Yes"){
        print(paste(name, "like makeup"))
        cat("What's your favourite makeup brand? ")
        makeup <- readLines("stdin", 1)
        print(paste(name, "like", makeup))
      }else{
        print(paste(name, "don't like makeup"))
      }
  }
  if (gender == "Male"){
    cat("Do you like sports? ")
    ans2 <- readLines("stdin", 1)
      if (ans2 == "Yes"){
        print(paste(name, "like sports"))
        cat("What's your favourite sports? ")
        sport <- readLines("stdin", 1)
        print(paste(name, "like", sport))
      }else{
        print(paste(name, "don't like sports"))
      }
  }
}

Chatbot()