function s=snew(s_old,alpha,beta,dt)

s=(s_old+dt*alpha)/(1+dt*(alpha+beta));

