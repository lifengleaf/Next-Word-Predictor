---
title       : Next Word Predictor
subtitle    : Capstone Project of Data Science Specialization 
author      : Feng Li
date        : April 21 2016
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]     # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides

---
## What is it?

- This is a [next word prediction model](https://leaf.shinyapps.io/capstone/).
- User input some words, it will predict the most likely next words.
- User can change the number of predictions to show.
- There are secondary tabs to give instructions to use the APP and documentation introducing the whole implementation.

---
## How does it work: Prediction Algorithm

!['flow chart'](diagram.png)


---
## How does it work: Language Model

- 509497   unigrams: the, and, to, a, of, i, in, that, with, you
- 8830370   bigrams: in the, on the, to the, to be, it is, in a, i am
- 35368584 trigrams: one of the, a lot of, as well as, the end of, going to do

Count their counts in the corpus. higher counts, higher weights when predicting next word.

The dataset used is from [HC Corpora](http://www.corpora.heliohost.org/aboutcorpcus.html), and could be downloaded [here](https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip).

Due to storage limit of Shiny APP, all trigrams with one occurance have to be removed.

To see how the ngrams are generated and distributed, check the [Github repo](https://github.com/lifengleaf/capstone).

--- @twocol
## how well does it work?

*** =left
Try it youself:
<iframe src="https://leaf.shinyapps.io/capstone/" style="border: none; width: 400px; height: 600px"></iframe>

*** =right
Evaluation on test data:
- Split every line of test data into word pairs: two words and the next word; one word and the next word.
- Make prediction on preceding words, and check whether the original next word is among the predicted next words.
- There're so many calculations that it's still running!



