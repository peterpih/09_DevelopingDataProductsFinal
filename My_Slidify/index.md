---
title       : Dosage, Treatment, Response
subtitle    : Pitch Deck for Outcome Analyzer
author      : Peter J Pih
job         : Final Project for Developing Data Products (devdataprod-031)
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides


--- .class #id 

## Introduction

<style>
strong {
  font-weight: bolder;
}
em {
  font-weight: bolder;
  font-style: italic;
}

small {
    font-size: 60%;
    line-height: 20%;
}
</style>
<br>  
<strong>Outcome Analyzer</strong> is a software graphical package which helps determine the sgnificance and effectiveness of treatment supplements and dosage levels. This type of analysis is very common for clinical trails, patient dosage determination, and regime therapy inference.  
<br>  
<strong>Outcome Analyzer</strong> was the result of a need by budding data scientists to find answers for <em>cause-and-effect</em> questions on various datasets. Indeed, it is specific for this specific category of questions and is a powerful visual tool for evaluation.  
<br>  
<strong>Outcome Analyzer</strong> is implemented in <strong>R</strong> and <strong>Slidify</strong>, both <em>Open Source</em>, publicly available software packages supported by large communities of users.  


--- .class #id 

## Graphical Display

<strong>Outcome Analyzer</strong> easily shows the effectiveness of treatments by dosage or supplement

![plot of chunk unnamed-chunk-1](assets/fig/unnamed-chunk-1-1.png) 

--- .class #id 

## Demo Software To Try

A demonstration version of <strong>Outcome Analyzer</strong> can be found on the <strong>Shiny.io</strong> server:
  
  
https://peterpih.shinyapps.io/09_DevelopingDataProductsFinal

This demonstration is a subset of the full functionality of <strong>Outcome Analyzer</strong>.  

You will be able to slice and dice the data in various ways representative of how the full version of <strong>Outcome Analyzer</strong> works.  We have made the user interface intutitive, easy to use, and reactive to changes in user input.

Please contact us at: info@outcomeAnalyzer.com, with any questions, comments, or to receive further information.
<br>
<br>
<br>
<br>
<small>Outcome Analyzer is offered under the standard [Beerware](https://en.wikipedia.org/wiki/Beerware) license.</small>

--- .class #id 

## Appendix

The demonstration version of <strong>Outcome Analyzer</strong> uses the tooth growth dataset: <em>ToothGrowth</em> available in the R base dataset.


```r
data("ToothGrowth")
```
<br>
This dataset has 60 observations of tooth growth and is based on a study using supplements of either <em>Orange Juice</em> (30 observations) or <em>Vitamin C</em> (30 observations) at three different dosage levels: 0.5mg, 1.0mg, and 2.0mg (10 observations each).

<br>
<br>
<br>
<small> Fine print:  
<strong>Outcome Analyzer</strong> is only using the ToothGrowth dataset for illustrative purposes in its demonstration software and was not responsible for the actual study or its results. As far as we know, this study was supervised by trained, certified animal care practitioners, and all guinea pigs were treated humanely and with the utmost care.</small>
