henpaku<-henpakuSplits[,-1]

#putting the times per level into different vectors, no need to convert the times if you are using henpaku2"
PQ<-as.numeric(henpaku$PQ)
PQ<-PQ[PQ>17.76];PQ<-PQ[PQ<60]
Prom<-as.numeric(henpaku$Prom);summary(Prom)
Prom<-Prom[Prom>17.18];Prom<-Prom[Prom<30]
Ramp<-as.numeric(henpaku$Ramp);summary(Ramp)
Ramp<-Ramp[Ramp>20.31];Ramp<-Ramp[Ramp<60]
BB<-as.numeric(henpaku$BB);summary(BB)
BB<-BB[BB>3.48];BB<-BB[BB<9.5]
Stilt<-as.numeric(henpaku$Stilt);summary(Stilt)
Stilt<-Stilt[Stilt>24.46];Stilt<-Stilt[Stilt<54]
Sep<-as.numeric(henpaku$Sep);summary(Sep)
Sep<-Sep[Sep>60.10];Sep<-Sep[Sep<122]
Giant<-as.numeric(henpaku$Giant);summary(Giant)
Giant<-Giant[Giant>11.41];Giant<-Giant[Giant<17]
HotK<-as.numeric(henpaku$HotK);summary(HotK)
HotK<-HotK[HotK>2.11];HotK<-HotK[HotK<4.3]

k = 300

PQSim<-simulateSplits(PQ,k)
PromSim<-simulateSplits(Prom,k)
RampSim<-simulateSplits(Ramp,k)
BBSim<-simulateSplits(BB,k)
StiltSim<-simulateSplits(Stilt,k)
SepSim<-simulateSplits(Sep,k)
GiantSim<-simulateSplits(Giant,k)
HotKsim<-simulateSplits(HotK,k)

n<-min(c(length(PQSim),length(PromSim),length(RampSim),length(BBSim),length(StiltSim),length(SepSim),length(GiantSim)
         ,length(HotKsim)))

PQSim<-sample(PQSim,n)
PromSim<-sample(PromSim,n)
RampSim<-sample(RampSim,n)
BBSim<-sample(BBSim,n)
StiltSim<-sample(StiltSim,n)
SepSim<-sample(SepSim,n)
GiantSim<-sample(GiantSim,n)
HotKsim<-sample(HotKsim,n)

runSim<-PQSim+PromSim+RampSim+BBSim+StiltSim+SepSim+GiantSim+HotKsim  #a (simulated) run is just the sum of splits

summary(runSim)
par(mfrow=c(1,1))
hist(PromSim)

hist(Prom[length(Prom)-300:length(Prom)])

d<-density(Prom[length(Prom)-900:length(Prom)],na.rm = TRUE)

curve( approxfun(d$x,d$y)(x),add = TRUE )

summary(Ramp[3600:3928])

sub4<-runSim[runSim<240]  #4 minutes = 240 seconds"
length(sub4)/n*100
sub350<-runSim[runSim<3*60+50]
length(sub350)/n*100
sub3<-runSim[runSim<180]
length(sub3)/n*100
WR<-runSim[runSim<180+26.02]  #WR = 3.26,02
length(WR)/n*100


hist(runSim,xlab = "Duration of the run (in seconds)",ylab="Number of runs (10e+05 = 100 000)",freq = TRUE,
main="3 700 000 runs simulated based on Henpaku's Splits")

hist(Prom[length(Prom)-300:length(Prom)],breaks = 10,freq=FALSE,main="300 most recent Henpaku's Promenades",
     xlab="Duration (in seconds)",ylab="Density (probability = density * 2)")
d<-density(Prom[length(Prom)-300:length(Prom)],na.rm = TRUE)
f<-approxfun(d$x,d$y)
curve(f(x),from=18,to=32,add=TRUE,col="red")


simulateSplits<-function(splitName,RunsAmount)
{
  k<-density(splitName[(length(splitName)-RunsAmount):length(splitName)],na.rm = TRUE)
  f<-approxfun(k$x,k$y)
  
  xrange <- max(k$x)# function range from 0 (implicit) to x
  N <- 1000000 # number of samples
  
  xy <- data.frame(proposed = runif(N, min = min(k$x), max = xrange))
  
  xy$fit <- f(xy$proposed)
  xy$random <- runif(N, min = 0, max = 1)
  
  maxDens <- max(xy$fit,na.rm = TRUE)
  
  xy$accepted <- with(xy, random <= xy$fit/maxDens)
  # retain only those values which are "below" the custom distribution
  
  xy<- xy[xy$accepted, ]
  sample<-xy$proposed
  
  
  
  
  return(sample)
  
}
