# RT-qPCR-data-analysis
Reproducibility github setup
Learning github 

##DOI

[![DOI](https://zenodo.org/badge/924429703.svg)](https://doi.org/10.5281/zenodo.14934312)

## Links to analysis

There are the links to the analysis files viewable on GitHub(.md). The .RMD files and .HTML rendered files are also available. 


- [Analysis 1](Data_Visualization/Coding-Visualization-Assignment.md)
- [Analysis 2](README.md)

## File Tree

install.packages("fs")
library(fs)
fs::dir_tree()


```bash
├── Basic_R
│   ├── In class assignment1.R  #Basic R code in class assignment
│   └── TipsR.csv      #Raw data for basic R
├── Coding_exercise_2
├── Data_Visualization   #In class assignment and coding challenge for data visualization
│   ├── BacterialAlpha.csv
│   ├── Coding Visualization Assignment.Rmd    #coding assignment visualization part 1 rmd file
│   ├── Coding-Visualization-Assignment.md    #coding assignment visualization part 1 md file
│   ├── Coding-Visualization-Assignment_files  # figures created from visualization part 1 and 2
│   │   └── figure-gfm
│   │       ├── unnamed-chunk-1-1.png
│   │       ├── unnamed-chunk-1-2.png
│   │       ├── unnamed-chunk-2-1.png
│   │       ├── unnamed-chunk-2-2.png
│   │       ├── unnamed-chunk-2-3.png
│   │       ├── unnamed-chunk-2-4.png
│   │       ├── unnamed-chunk-2-5.png
│   │       ├── unnamed-chunk-3-1.png
│   │       ├── unnamed-chunk-4-1.png
│   │       ├── unnamed-chunk-4-2.png
│   │       ├── unnamed-chunk-4-3.png
│   │       ├── unnamed-chunk-5-1.png
│   │       └── unnamed-chunk-5-2.png
│   ├── Coding_Visualization_2 _Assignment .R   #coding assignment data visualization part 2
│   ├── diff_abund.csv                          # Raw data used for advanced visualization
│   ├── In class assignment 2 visualization.R   # In class assignment datavisualization part 1
│   ├── In class asssignment 3 advanced visualization.R   #In class assignment data visualization part 2
│   └── MycotoxinData.csv    # Raw data used for data visualization
├── README.html
├── README.md                     #Top level directory README
├── RT-qPCR-data-analysis.Rproj   #Top level drectory .Rproj file=working directory
└── R_markdown
    ├── R markdown coding.Rmd
    ├── R-markdown-coding.html
    └── R-markdown-coding.md
```

```r
fs::dir_tree()
```


