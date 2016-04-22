

# lookup:
#   takes in a character string, outputs the corresponding key (index) in the dictionary
lookup<- function(word){
  for(i in 1:n){
    
    if (names(dict[i]) == word){
      return(i)
    }
  }
  return(NULL)
}


# cleanInput:
#   preprocesses input: giving <num> to digits, replacing :?!. with <eos> mark, removing extra spaces
#   keeping only the last two words for prediction when multiple words in input

cleanInput <- function(input) {
  # remove non-ASCII characters
  input<- iconv(input, "latin1", "ASCII", sub = "")
  
  # revert symbol & / to words
  input<- gsub("\\&", " and ", input)
  input <-gsub("\\/", " or ", input)
  
  # remove period in abbreviation
  input <- gsub("\\s([A-Z])\\.\\s", " \\1", input)
  input <- gsub("\\s([A-Z][a-z]{1,3})\\.\\s", " \\1", input)
  input <- gsub("^([A-Z])\\.\\s", " \\1", input)
  input <- gsub("^([A-Z][a-z]{1,3})\\.\\s", " \\1", input)
  
  input<- tolower(input)
  
  # replace :.?! with end of sentence tags <eos>
  # and eliminate other punctuation except apostrophes
  input<- gsub("[:.?!]+", " <eos> ", gsub("(?![:.?!'])[[:punct:]]", " ", input, perl=T))
  
  # remove errant apostrohes
  input<-gsub(" ' "," ", input)        
  input<-gsub("\\' ", " ", input)
  input<-gsub("^'", "", input)
  
  # replaces numbers with number tag <num>
  input<- gsub("[0-9]+"," <num> ", input)
  
  # remove extra spaces
  input<- gsub("^[ ]","",input)
  input<- gsub("[ ]$", "", input)
  
  splitInput<- unlist(strsplit(input, " "))
  n<- length(splitInput)
  
  if(n == 0){
    stop("input something..")
  }
  
  # if more than 2 words in input, keep only last two
  if(n > 2){
    input<- paste0(splitInput[n-1], " ", splitInput[n], sep = "")
  }
  
  return(input)
}


# predict:
#   takes in character strings, and outputs a vector of words which have highest conditional pobability given the input
#   when no result found in higher order N-Gram, backoff to lower order N-Grams

predict <-function(input, max = 15){
  input <- cleanInput(input)
  
  inputSplit<- unlist(strsplit(input, " "))
  inputSize<-length(inputSplit)
  
  # if input has one word
  if(inputSize == 1){
    ind<- lookup(input)
    
    # if input not found in dictionary
    if (is.null(ind)){
      result<- head(uniGram, max)$w1
    }
    
    else {
      result<- head(biGram[w1 == ind], max)$w2
    }
  }
  
  # if input has two words
  else{
    indw1<- lookup(inputSplit[1])
    indw2<- lookup(inputSplit[2])
    subTri<- triGram[w1 == indw1 & w2 == indw2]
    
    if(nrow(subTri) == 0){
      # if w1w2 not found in trigram, backoff to bigram
      subBi<- biGram[w1 == indw2]
      
      if (nrow(subBi) == 0){
        result<- head(uniGram, max)$w1
      }
      
      else {
        result<- head(subBi, max)$w2
      }
    }
    
    else {
      result<- head(subTri, max)$w3
    }
  }
  resultWord<- names(dict[result])
  resultWord
}
