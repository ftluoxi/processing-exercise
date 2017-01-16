PI = 3.1415926
w = 50
h = 50
sugartable = matrix(NA)
length(sugartable) = w*h
dim(sugartable) = c(w, h)
pmiu1 = c(0.3*w, 0.4*w)
#ptheta1 = c(0.2*w,0.2*w)
ptheta1 = c(1, 1)
prho1 = 0.5
termp1_1 = 2*PI*ptheta1[1]*ptheta1[2]*((1-prho1^2)^0.5)
termp1_1 = termp1_1^-1
termp1_2 = -1*(1/(2*(1-prho1^2)))
for(x in 1:w){
  for(y in 1:h){
    t1 = (x-pmiu1[1])^2/ptheta1[1]^2
    t1 = t1 - (2*prho1*(x-pmiu1[1])*(y-pmiu1[2])/(ptheta1[1]*ptheta1[2]))
    t1 = t1 + ((y-pmiu1[2])^2/ptheta1[2]^2)
    t1 = t1 * termp1_2
    t1 = exp(t1)
    t1 = termp1_1*t1
    sugartable[x, y] = t1
  }
}
order = rank(sugartable)
persp3d(1:50, 1:50, sugartable, col = rainbow(as.integer(max(order)))[order])