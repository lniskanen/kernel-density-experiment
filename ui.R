



shinyUI(pageWithSidebar(
        headerPanel("Experiment with KDE functions"),
        sidebarPanel(
                h2('Histogram'),
                sliderInput('histbin', 'Histogram bin width',value = 0.3, min = 0.01, max = 2.5, step = 0.01,),
                h2('Kernel density estimates'),
                selectInput("kde", "Select KDE function:",
                             list(
                                  "Rectangular" = "rectangular",
                                  "Gaussian" = "gaussian",
                                  "Triangular" = "triangular",
                                  "Epanechnikov" = "epanechnikov",
                                  "Biweight" = "biweight",
                                  "Cosine" = "cosine",
                                  "Optcosine" = "optcosine")),
                sliderInput('kdeadjust', 'Set KDE bandwidth',value = 0.3, min = 0.01, max = 2.5, step =0.01,)
        ),
        mainPanel(
                tabsetPanel(
                        tabPanel("Plot", plotOutput("plot",width = "100%", height = "600px"),icon = icon("bar-chart-o")),
                        tabPanel("Upload",icon = icon("file"),
                                 h2('File upload'),
                                h3('Separator character used'),
                                radioButtons('separator', '',
                                     c("Comma"=',', "Semicolon"=';',"Tab"='\t')),
                                h3('Quotes used'),
                                radioButtons('quote', '',
                                     c("None"='','Double Quote'='"', 'Single Quote'="'")),
                                h3('Select column number'),
                                numericInput('column', label='', value=1, min = 1, max = 20, step = 1),
                                h3('Select file'),
                                fileInput('upfile', '',multiple = FALSE,
                                          accept = c(
                                                  'text/csv',
                                                  'text/comma-separated-values',
                                                  'text/tab-separated-values',
                                                  'text/plain',
                                                  '.txt',
                                                  '.csv'
                                          ))                          
                        ),
                        tabPanel("Help", icon = icon("info"),
                                 includeMarkdown('./info.Rmd')
                                 ),
                        tabPanel("Shiny", verbatimTextOutput('txt'),icon = icon("music"))
                )
        )
))