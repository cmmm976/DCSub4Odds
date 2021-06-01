fillingTestSet<-function(vec)
{
  result = 1:length(vec)
  for (i in 1:length(vec)) {
    if(vec[i] == i)
    {
      result <- result[result != i]
    }
  }
  
  return(result)
}


rockstombSplits<-rockstomb*86400000/1000
rockstombSplits<-rockstombSplits[,-1]

colnames(rockstombSplits)<-c("PQ","Prom","Ramp","BB","Stilt","Sep","Giant","HotK")

N = 4000
trainingSetSize = 0.7*N
testSetsize = .3*N

dataset <- rockstombSplits[(12191-N+1):12191,];rownames(dataset)<-1:N
idTR<-sample(1:3000,trainingSetSize)
trainingDataSet <- dataset[idTR,]
testingDataSet <- dataset[-idTR,]

trPQ<-as.numeric(trainingDataSet$PQ)
trPQ<-trPQ[trPQ>17.76];trPQ<-trPQ[trPQ<60]
trProm<-as.numeric(trainingDataSet$Prom)
trProm<-trProm[trProm>17.18];trProm<-trProm[trProm<30];summary(trProm)
trRamp<-as.numeric(trainingDataSet$Ramp);summary(trRamp)
trRamp<-trRamp[trRamp>20.31];trRamp<-trRamp[trRamp<60];summary(trRamp)
trBB<-as.numeric(trainingDataSet$BB)
trBB<-trBB[trBB>3.48];trBB<-trBB[trBB<9.5];summary(trBB)
trStilt<-as.numeric(trainingDataSet$Stilt)
trStilt<-trStilt[trStilt>24.46];trStilt<-trStilt[trStilt<54];summary(trStilt)
trSep<-as.numeric(trainingDataSet$Sep)
trSep<-trSep[trSep>60.10];trSep<-trSep[trSep<122];summary(trSep)
trGiant<-as.numeric(trainingDataSet$Giant)
trGiant<-trGiant[trGiant>11.41];trGiant<-trGiant[trGiant<17];summary(trGiant)
trHotK<-as.numeric(trainingDataSet$HotK);summary(trHotK)
trHotK<-trHotK[trHotK>2.11];trHotK<-trHotK[trHotK<4.3]

testPQ<-as.numeric(testingDataSet$PQ)
testPQ<-testPQ[testPQ>17.76];testPQ<-testPQ[testPQ<60]
testProm<-as.numeric(testingDataSet$Prom)
testProm<-testProm[testProm>17.18];testProm<-testProm[testProm<30];summary(testProm)
testRamp<-as.numeric(testingDataSet$Ramp);summary(testRamp)
testRamp<-testRamp[testRamp>20.31];testRamp<-testRamp[testRamp<60];summary(testRamp)
testBB<-as.numeric(testingDataSet$BB)
testBB<-testBB[testBB>3.48];testBB<-testBB[testBB<9.5];summary(testBB)
testStilt<-as.numeric(testingDataSet$Stilt)
testStilt<-testStilt[testStilt>24.46];testStilt<-testStilt[testStilt<54];summary(testStilt)
testSep<-as.numeric(testingDataSet$Sep)
testSep<-testSep[testSep>60.10];testSep<-testSep[testSep<122];summary(testSep)
testGiant<-as.numeric(testingDataSet$Giant)
testGiant<-testGiant[testGiant>11.41];testGiant<-testGiant[testGiant<17];summary(testGiant)
testHotK<-as.numeric(testingDataSet$HotK);summary(testHotK)
testHotK<-testHotK[testHotK>2.11];testHotK<-testHotK[testHotK<4.3]

PQSim<-simulateSplits(trPQ,length(trPQ))
PromSim<-simulateSplits(trProm,length(trProm))
RampSim<-simulateSplits(trRamp,length(trRamp))
BBSim<-simulateSplits(trBB,length(trBB))
StiltSim<-simulateSplits(trStilt,length(trStilt))
SepSim<-simulateSplits(trSep,length(trSep))
GiantSim<-simulateSplits(trGiant,length(trGiant))
HotKsim<-simulateSplits(trHotK,length(trHotK))

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

runSim<-PQSim+PromSim+RampSim+BBSim+StiltSim+SepSim+GiantSim+HotKsim



sub4<-runSim[runSim<240]  #4 minutes = 240 seconds"
length(sub4)/n*100
sub350<-runSim[runSim<3*60+50]
length(sub350)/n*100
sub3<-runSim[runSim<180]
length(sub3)/n*100
WR<-runSim[runSim<180+26.02]  #WR = 3.26,02
length(WR)/n*100

d<-density(trSep,na.rm=TRUE)
f<-approxfun(d$x,d$y)
hist(testSep,freq=FALSE)
curve(f(x),col="red",add = TRUE,from=59, to=115)

hist(runSim,xlab = "Duration of the run (in seconds)",ylab="Number of runs (10e+05 = 100 000)",freq = TRUE,
     main="3 700 000 runs simulated based on Henpaku's Splits")

hist(SepSim)
hist(runSim)
summary(runSim)
length(sub3)/n
298/60

0.000000000000000005

length(PQSim[PQSim<40])
231470/324265
