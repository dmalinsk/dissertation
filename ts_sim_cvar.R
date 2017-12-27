##### Model #####
# T1[t] = t10 + a1*T1[t-1] + errT1[t]
# T2[t] = t20 + a2*T2[t-1] + errT2[t]
# A[t] = a0 + a3*T1[t-1] + a4*T2[t-1] + a5*A[t-1] + errA[t]
# B[t] = b0 + b1*A[t] + a6*T2[t-1] + a7*B[t-1] + errB[t]
# C[t] = c0 + b2*B[t] + b3*D[t] + a8*A[t-1] + a9*C[t-1] + errC[t]
# D[t] = d0 + b4*E[t] + a10*A[t-1] + a11*B[t-1] + a12*D[t-1] + errD[t]
# E[t] = e0 + a13*T1[t-1] + a14*E[t-1] + errE[t]
# errors ~ N(0,s)
#
# So this is the setup of a (Cointegrated) SVAR

set.seed(102417)

a0 <- b0 <- c0 <- d0 <- e0 <- t10 <- t20 <- 0
a1 <- 1.0 #1.0 # unit root for T1
a2 <- 1.0 #1.0 # unit root for T2
a3 <- 0.55
a4 <- 0.55
a5 <- 0.55
a6 <- 0.55
a7 <- 0.55
a8 <- 0.55
a9 <- 0.55
a10 <- 0.55
a11 <- 0.55
a12 <- 0.55
a13 <- 0.55
a14 <- 0.55
b1 <- 0.55
b2 <- 0.55
b3 <- 0.55
b4 <- 0.55
s.a <- s.b <- s.c <- s.d <- s.e <- s.t1 <- s.t2 <- 1.0 # error variances

Nobs <- 100 # number of observations
Nburn <- 500
Ntot <- Nobs + Nburn # add 500 to discard

##### Generating the data #####

# Start with 1 initial values and then create a dataset with Ntot observations

for(i in 1:100){

A <- rep(0,Ntot)
B <- rep(0,Ntot)
C <- rep(0,Ntot)
D <- rep(0,Ntot)
E <- rep(0,Ntot)
T1 <- rep(0,Ntot)
T2 <- rep(0,Ntot)

T1[1] <- rnorm(1, t10, s.t1)
T2[1] <- rnorm(1, t20, s.t2) 
A[1] <- rnorm(1, a0, s.a)
E[1] <- rnorm(1, e0, s.e)
B[1] <- rnorm(1, b0 + b1*A[1], s.b)
D[1] <- rnorm(1, d0 + b4*E[1], s.d)
C[1] <- rnorm(1, c0 + b2*B[1] + b3*D[1], s.c)

for(t in 2:Ntot){
  T1[t] <- rnorm(1, t10 + a1*T1[t-1], s.t1)
  T2[t] <- rnorm(1, t20 + a2*T2[t-1], s.t2) 
  A[t] <- rnorm(1, a0 + a3*T1[t-1] + a4*T2[t-1] + a5*A[t-1], s.a)
  E[t] <- rnorm(1, e0 + a13*T1[t-1] + a14*E[t-1], s.e)
  B[t] <- rnorm(1, b0 + b1*A[t] + a6*T2[t-1] + a7*B[t-1], s.b)
  D[t] <- rnorm(1, d0 + b4*E[t] + a10*A[t-1] + a11*B[t-1] + a12*D[t-1], s.d)
  C[t] <- rnorm(1, c0 + b2*B[t] + b3*D[t] + a8*A[t-1] + a9*C[t-1], s.c)
}

# throw out first Nburn observations
A <- A[(Nburn+1):Ntot]
B <- B[(Nburn+1):Ntot]
C <- C[(Nburn+1):Ntot]
D <- D[(Nburn+1):Ntot]
E <- E[(Nburn+1):Ntot]
T1 <- T1[(Nburn+1):Ntot]
T2 <- T2[(Nburn+1):Ntot]

data <- cbind(A,B,C,D,E)
colnames(data) <- c("X1","X2","X3","X4","X5")
fname <- paste("Documents/research/data/cvar100/data", i, "txt", sep = ".")  
write.table(data,file = fname,quote = FALSE, row.names=FALSE,col.names=TRUE)
}

plot(A,type="l")
plot(B,type="l")
plot(C,type="l")
plot(D,type="l")
plot(E,type="l")
plot(T1,type="l")
plot(T2,type="l")

L1.A <- rep(NA,Nobs)
L1.B <- rep(NA,Nobs)
L1.C <- rep(NA,Nobs)
L1.D <- rep(NA,Nobs)
L1.E <- rep(NA,Nobs)
L1.T1 <- rep(NA,Nobs)
L1.T2 <- rep(NA,Nobs)

for(t in 2:Nobs){
  L1.A[t] <- A[t-1]
  L1.B[t] <- B[t-1]
  L1.C[t] <- C[t-1]
  L1.D[t] <- D[t-1]
  L1.E[t] <- E[t-1]
  L1.T1[t] <- T1[t-1]
  L1.T2[t] <- T2[t-1]
}

d1.A <- A-L1.A
d1.B <- B-L1.B
d1.C <- C-L1.C
d1.D <- D-L1.D
d1.E <- E-L1.E
d1.T1 <- T1-L1.T1
d1.T2 <- T2-L1.T2

plot(d1.A,type="l")
plot(d1.B,type="l")
plot(d1.C,type="l")
plot(d1.D,type="l")
plot(d1.E,type="l")
plot(d1.T1,type="l")
plot(d1.T2,type="l")
