LakeHuron
plot(LakeHuron)

data<- LakeHuron

par(mfrow=c(3,1))
# data.return=diff(data)
data.return=data
plot(data.return)
acf(data.return, main='ACF')
pacf(data.return, main='PACF')

# Order
p=3

# sample autocorreleation function r
r=NULL
r[1:p]=acf(data.return, plot=F)$acf[2:(p+1)]
r

# matrix R
R=matrix(1,p,p) # matrix of dimension 4 by 4, with entries all 1's.

# define non-diagonal entires of R
for(i in 1:p){
	for(j in 1:p){
		if(i!=j)
			R[i,j]=r[abs(i-j)]
		}
	}
R

# b-column vector on the right
b=matrix(r,p,1)# b- column vector with no entries
b

phi.hat=solve(R,b)[,1]
phi.hat


# Variance estimation using Yule-Walker Estimator
c0=acf(data.return, type='covariance', plot=F)$acf[1]
c0
var.hat=c0*(1-sum(phi.hat*r))
var.hat

# Constant term in the model
phi0.hat=mean(data.return)*(1-sum(phi.hat))
phi0.hat