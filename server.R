library(ggplot2)
library('ggthemr')

ggthemr('earth')


kerns=c("gaussian", "rectangular", "triangular", "epanechnikov", "biweight", "cosine", "optcosine")

defaultData<-function(){
        
       
        Petal.Length<-rep(scale(iris$Petal.Length),length(kerns))
        kernels<-rep(kerns,each=length(iris$Petal.Length))
        data<-cbind(Petal.Length,kernels)
        data<-as.data.frame(data)
        data$Petal.Length<-as.character(data$Petal.Length)
        data$Petal.Length<-as.numeric(data$Petal.Length)
        data
}

readUploaded<-function(filePath,separator,quote,column,session){
        
        file<-read.csv(filePath, header=TRUE, sep=separator, quote=quote)
        
        file[,column]<-scale(file[,column])
        
        longCol<-rep(file[,column],length(kerns))
        kernelsCol<-rep(kerns,each=length(file[,column]))
        data<-cbind(longCol,kernelsCol)
        data<-as.data.frame(data)
        data$longCol<-as.character(data$longCol)
        data$longCol<-as.numeric(data$longCol)
        data
}

shinyServer(
        function(input, output,session) {

                output$plot <- renderPlot({
                        
                        data<-data.frame()
                        
                        upFile <- input$upfile
                        if (is.null(upFile)){
                                data<<-defaultData()
                        }else{

                                data<<-readUploaded(upFile$datapath, input$separator,input$quote,input$column,session)
                        }
                        
                        
                        histTxt<- paste0("Histogram binwidth: ",input$histbin)
                        kdeTxt<- paste0("KDE bandwidth: ",input$kdeadjust)
                        kernelTxt<-paste0("KDE function: ",input$kde)
                        fontSize=6
                        
                      
                        
                        ggplot()+
                                geom_histogram(data=data,aes(x=data[,1],y=..density..),   
                                               binwidth=input$histbin,
                                               colour="black", fill="white")+
                                stat_density(data=data,aes(x=data[,1]),kernel=input$kde,alpha=0.8,adjust=input$kdeadjust)+
                                ggtitle("Experiment with different KDE functions and bandwidths")+
                                annotate("text",x=c(Inf,Inf,Inf),y=c(Inf,Inf,Inf),hjust=c(1.5,1.5,1.5),vjust=c(3.0,4.5,6.0),
                                         label=c(histTxt,kdeTxt,kernelTxt),family ="serif", 
                                         fontface ="italic", colour ="white", size = fontSize,align="right")

                })


                output$txt<-renderText("Shiny happy people holding hands
Shiny happy people holding hands
Shiny happy people laughing
Everyone around, love them, love them
Put it in your hands
Take it, take it
There's no time to cry
Happy, happy
Put it in your heart
Where tomorrow shines
Gold and silver shine
                                       
by R.E.M ",quoted=TRUE)
        }
)