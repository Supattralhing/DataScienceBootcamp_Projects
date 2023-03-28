play_game <- function(){
  print("Instruction: you choose hummer, scissor, paper")
  cat("Do you want start to play game? (1:start, 0:exit) ")
  start <- readLines("stdin", 1)

  ##time for play
  time <- 0
  tie_time <- 0
  ##score
  user_score <- 0
  com_score <- 0

  if (start == 1){
    while(TRUE){
     ##count time when start to play game
      time <- time + 1
  
      cat("Choose one: ")
      options <- c("hummer", "scissor", "paper")
      user <- readLines("stdin", 1)
      print(paste("user choose: ", user))

      com <- sample(options, 1)
      print(paste("computer choose: ", com))
      ##case
        if (user == com){
          #do not count both of score
          tie_time <- tie_time + 1
        } else if (user == "hummer" & com == "scissor"){
          user_score <- user_score + 1
        } else if (user == "hummer" & com == "paper"){
          com_score <- com_score + 1
        } else if (user == "scissor" & com == "paper"){
          user_score <- user_score + 1
        } else if (user == "scissor" & com == "hummer"){
          com_score <- com_score + 1
        } else if (user == "paper" & com == "hummer"){
          user_score <- user_score + 1
        } else if (user == "paper" & com == "scissor"){
          com_score <- com_score + 1
        }

        ##Ask to exit or play again
        cat("Do you want to exit? (1:exit, 0:play again) ")
        exit <- readLines("stdin", 1)
        if (exit == 1){
          print("--End game and summary score--")
          print(paste("time to play: ", time))
          print(paste("tie time: ", tie_time))
          print(paste("user score: ", user_score))
          print(paste("computer score: ", com_score))
            if (user_score > com_score){
              print("You Win")
            } else if (user_score == com_score){
              print("You tie with computer")
            } else{
              print("You Lose")
            }
          break
        } else {} ##do not anything
    }
  
  }else{
    print("Exit play game and summary below")
    print(paste("time to play: ", time))
    print(paste("user score: ", user_score))
    print(paste("computer score: ", com_score))
  }
}

play_game()