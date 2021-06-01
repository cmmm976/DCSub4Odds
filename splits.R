evianigt<-evianigttest[,-1]*86400000/1000
colnames(evianigt)<-c("PQ","Promenade","Ramparts","Black Bridge",
                      "Stilt Village","Sepulcher","Giant","HotK")

Prom<-as.vector(evianigt[2198:2486,"Promenade"])*86400000/1000
prom<-t(Prom)
prom<-as.vector(prom)
summary(prom)

hist(prom)

S<-as.vector(evianigt[2198:2486,"Ramparts"])*86400000/1000
ramp<-t(S)
ramp<-as.vector(ramp)
summary(ramp)
hist(ramp)
pnorm(20.31,50.46,54.94-44.21)
54.94-44.21

S<-as.vector(evianigt[2198:2486,"PQ"])*86400000/1000
PQ<-t(S)
PQ<-as.vector(PQ)
summary(PQ)
hist(PQ)
30.65-24.36

S<-as.vector(evianigt[2198:2486,"Sepulcher"])*86400000/1000
sep<-t(S)
sep<-as.vector(sep)
summary(sep)
hist(sep)
94.53-75.90

S<-as.vector(evianigt[2198:2486,"HotK"])*86400000/1000
Hotk<-t(S)
Hotk<-as.vector(Hotk)
summary(Hotk)
hist(Hotk)

S<-as.vector(evianigt[2198:2486,"PQ"])*86400000/1000
PQ<-t(S)
PQ<-as.vector(PQ)
summary(PQ)
hist(PQ)

PQSim<-rnorm(1000000,43.7,7.8)
PromSim<-rnorm(1000000,31.67,6.29)
RampSim<-rnorm(1000000,50.46,10.73)
BridgeSim<-rnorm(1000000,7.57,1.12)
StiltSim<-rnorm(1000000,41.43,6.76)
SepSim<-rnorm(1000000,86.15,18.63)
GiantSim<-runif(1000000,15.42,16.47)
HotKSim<-runif(1000000,2.46,3.03)

runSim<-PQSim+PromSim+RampSim+BridgeSim+StiltSim+SepSim+GiantSim+HotKSim
sub4<-runSim[runSim<240]

pbinom(1,120,5.4/100,FALSE)
?dbinom  

2486-2198
