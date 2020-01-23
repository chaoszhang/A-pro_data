require(reshape2); require(ggplot2); require(scales)

d= read.csv("true-gt.csv",sep=" ",header = F)
head(d)
levels(d$V1)

ggplot(aes(x=interaction(V3,V2,sep=" "),y=V7,color=as.factor(V4),group=as.factor(V4)),data=d)+
  stat_summary(geom="line")+
  stat_summary()+
  facet_wrap(~V1,scales="free_x")


summary(aov(V7~V2*V4,d))

summary(aov(V7~(V3*V2),d[d$V1=="e3" & d$V4=="method1",]))
summary(aov(V7~(V3*V2),d[d$V1=="e3" & d$V4=="method2",]))

summary(aov(V7~(V3*V2),d[d$V1=="e4" & d$V4=="method1",]))
summary(aov(V7~(V3*V2),d[d$V1=="e4" & d$V4=="method2",]))
