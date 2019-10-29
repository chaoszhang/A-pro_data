require(reshape2); require(ggplot2); require(scales);

mr = list("MulRF" = "mulrf", "DupTree" = "duptree", "PF" = "method1", "A-Pro" ="method2" )
gt = list("Est. (100bp)" = "100", "Est. (500bp)" = "500",  "true" ="true" )
lrates = list('0'="0", '0.1'="01",  '0.5'="05", '1'="1")
drates = list('0'="0",  '0.2'="02", '1'="1", '2'="2", '5'="5")


experiment="E3"
d= read.csv("stat3.stat",sep=" ",header = F,colClasses = c("factor","factor","factor","factor","factor","numeric","numeric","numeric"))
levels(d$V5) = mr
levels(d$V4)=gt
levels(d$V2)=drates
levels(d$V3)=lrates
head(d)

names(d)[2] = "Dup"
names(d)[3] = "Loss/Dup"
names(d)[4] = "Input"

ggplot(aes(x=interaction(Loss/Dup,DupRate,sep=" "),y=V8,color=as.factor(V5),group=as.factor(V5)),data=d)+
  stat_summary(geom="line")+
  stat_summary()+
  facet_wrap(~Input,scales="free_x")+coord_cartesian(ylim=c(0,0.1))+  
  scale_color_brewer(palette = "Paired")+
  xlab("Condition")+ylab("Species tree error (NRF)")+
  theme_bw()

ggplot(aes(x=Loss/Dup,y=V8,color=V5,group=V5),data=d)+
  stat_summary(geom="line")+
  #geom_boxplot()+
  stat_summary()+
  facet_grid(V4~DupRate,scales="free_y")+#coord_cartesian(ylim=c(0,0.15))+
  scale_color_brewer(palette = "Paired")+
  theme_bw()


ggplot(aes(x=Input,y=V8,color=V5,group=V5),data=d[!d$V5 %in% c("PF"),])+
  stat_summary(geom="line")+
  #geom_boxplot()+
  stat_summary(geom="errorbar",width=0.22)+
  stat_summary(geom="point",size=1)+
  facet_grid(`Loss/Dup`~`Dup`,scales="free_y",labeller = label_both)+#coord_cartesian(ylim=c(0,0.15))+
  scale_color_brewer(palette = "Set2",name="")+
  xlab("Gene alignment length")+ylab("Species tree error (NRF)")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))
ggsave("E3-2.pdf",width = 7,height = 7)

ggplot(aes(x=`Loss/Dup` ,y=V8,color=V5,group=V5),data=d[!d$V5 %in% c("PF"),])+
  stat_summary(geom="line")+
  #geom_boxplot()+
  stat_summary(geom="errorbar",width=0.22)+
  stat_summary(geom="point",size=1)+
  facet_grid(`Input`~`Dup`,scales="free_x",space="free_x",labeller = label_both)+#coord_cartesian(ylim=c(0,0.15))+
  scale_color_brewer(palette = "Set2",name="")+
  xlab("Loss/Dup rate")+ylab("Species tree error (NRF)")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))
ggsave("E3.pdf",width = 7,height = 5.4)

summary(aov(V8~V5*(DupRate+Loss/Dup+V4),d[d$V5 %in% c("PL","DupTree") &!d$DupRate %in% c("5","0"),]))

dcast(formula =DupRate+Loss/Dup+V4~V5 ,data=d[c(1:5,8)])
dcast(formula =V4+DupRate+Loss/Dup~V5 ,data=d[c(1:5,8)],fun.aggregate = mean)


d2= read.csv("stat_exp4.stat",sep=" ",header = F,colClasses = c("factor","factor","factor","factor","factor","numeric","numeric","numeric"))
head(d2)
levels(d2$V5) = mr
levels(d2$V4)=gt
levels(d2$V2)=drates
names(d2)[2] = "Dup"
names(d2)[3] = "ILS"
names(d2)[4] = "Input"
head(d)

ggplot(aes(x=ILS,y=V8,color=Input,linetype=V5,group=interaction(V5,Input)),data=d2)+
  stat_summary(geom="line")+
  #geom_boxplot()+
  stat_summary(size=.2,fatten=5)+
  facet_grid(.~Dup,scales="free_y")+#coord_cartesian(ylim=c(0,0.15))+
  scale_color_brewer(palette = "Dark2",name="")+
  scale_linetype_manual(values = c(3,1,2,4),name="")+
  xlab("ILS")+ylab("Species tree error (NRF)")+
  theme_bw()+theme(legend.position = c(.25,.82),legend.direction = "horizontal")
ggsave("E4-3.pdf",width = 5.5,height = 3.5)


ggplot(aes(x=ILS,y=V8,color=V5,group=V5),data=d2[!d2$V5 %in% c("PF"),])+
  stat_summary(geom="line")+
  #geom_boxplot()+
  stat_summary(geom="errorbar",width=0.22)+
  stat_summary(geom="point",size=1)+
  facet_grid(`Gene trees`~`Dup`,labeller = label_both)+#coord_cartesian(ylim=c(0,0.15))+
  scale_color_brewer(palette = "Set2",name="")+
  xlab("ILS level (RF%)")+ylab("Species tree error (NRF)")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))
ggsave("E4.pdf",width = 5.5,height = 5.5)


dcast(formula =V2+V3+V4~V5 ,data=d2[c(1:5,8)],fun.aggregate = mean)

summary(aov(V8~V5*(V2+V3+V4),d2[d2$V5 %in% c("PL","DupTree"),]))




e1t= read.csv("stat_exp1_time.stat",sep=" ",header = F,colClasses = c("factor","numeric","numeric","factor","factor","numeric"))
e1a =  read.csv("stat_exp1.stat",sep=" ",header = F,colClasses = c("factor","numeric","numeric","factor","factor","numeric","numeric","numeric"))

levels(e1a$V5) = mr
levels(e1t$V5) = mr
e1 = cbind(e1a,e1t[,6])
names(e1)[9] = "runTime"
e1s = cbind(dcast(formula =V2+V3+V4+V5~. ,data=e1t,fun.aggregate = mean),dcast(formula =V2+V3+V4+V5~. ,data=e1a,fun.aggregate = mean))

names(e1s)[5]="runTime"
names(e1s)[6:10]=c("t0", "t1","t2","t3","RF")
head(e1s)

ggplot( aes(x=runTime/60, y=RF,color=V4,group=V4), data=e1s[e1s$V5=="PL",])+
  geom_point(aes(size=(V2)))+
  geom_line( )+
  #stat_summary(geom="line")+
  scale_x_log10()+
  xlab("running time (minutes)")+ylab("Species tree error (NRF)")+
  scale_color_brewer(palette = "Dark2",name="Gene trees",labels=function(x) sub("true","true gt",sub("00","00 bp",x)))+
  scale_size(name=expression(n),breaks=unique(e1s$V2))+
  theme_bw()#+coord_cartesian(ylim=c(0,0.15))
ggsave("E1.pdf",width=3.5,height = 3.5)

ggplot( aes(x=V2, y=V8, color=V4), data=e1a[e1a$V5=="PL",])+
  stat_summary()+
  stat_summary(geom="line")+
  scale_x_log10(breaks=unique(e1a$V2))+
  xlab("n")+ylab("Species tree error (NRF)")+
  scale_color_brewer(palette = "Dark2",name="Gene trees",labels=function(x) sub("true","true gt",sub("00","00 bp",x)))+
  theme_bw()+theme(legend.position = c(.2,.8))
ggsave("E1-acc.pdf",width=3.5,height = 3.5)

ggplot( aes(x=V2, y=runTime/60,color=V4), data=e1[e1$V5=="PL",])+
  stat_summary()+
  stat_smooth(method="lm",se=F,show.legend = T, data=e1[e1$V5=="PL"&e1$V2>25,])+
  scale_x_log10(breaks=unique(e1a$V2))+
  scale_y_log10()+
  xlab("n")+ylab("running time (minutes) with 28 cores")+
  scale_color_brewer(palette = "Dark2",name="Gene trees",labels=function(x) sub("true","true gt",sub("00","00 bp",x)))+
  theme_bw()+theme(legend.position = c(.2,.8))+
  annotate(label=format(lm(log(runTime)~log(V2),data=e1[e1$V5=="PL" & e1$V4 == "500"& e1$V2>25,])[[1]][[2]],digits=2),
           geom="text",y=1.2,x=130,color="darkorange3")+
  annotate(label=format(lm(log(runTime)~log(V2),data=e1[e1$V5=="PL" & e1$V4 == "100"& e1$V2>25,])[[1]][[2]],digits=2),
           geom="text",y=6,x=130,color="darkgreen")+
  annotate(label=format(lm(log(runTime)~log(V2),data=e1[e1$V5=="PL" & e1$V4 == "true"& e1$V2>25,])[[1]][[2]],digits=2),
           geom="text",y=15,x=340,color="darkorchid4")
ggsave("E1-time.pdf",width=3.5,height = 3.5)

########################################

e2t= read.csv("stat_exp2_time.stat",sep=" ",header = F ) # ,colClasses = c("factor","numeric","numeric","factor","factor","numeric"))
e2a =  read.csv("stat_exp2.stat",sep=" ",header = F ) #, colClasses = c("factor","numeric","numeric","factor","factor","numeric","numeric","numeric"))

levels(e2a$V5) = mr
levels(e2t$V5) = mr
e2 = cbind(e2a,e2t[,6])
names(e2)[9] = "runTime"
e2s = cbind(dcast(formula =V2+V3+V4+V5~. ,data=e2t,fun.aggregate = mean),
            dcast(formula =V2+V3+V4+V5~. ,data=e2a,fun.aggregate = mean))

names(e2s)[5]="runTime"
names(e2s)[6:10]=c("t0", "t1","t2","t3","RF")
head(e2s)

ggplot( aes(x=runTime/60, y=RF, color=as.factor(V4),group=V4,), data=e2s[e2s$V5=="PL",])+
  geom_point(aes(size=(V3)))+
  geom_line( )+
  #stat_summary(geom="line")+
  #scale_x_continuous(breaks=unique(e2a$V2))+
  xlab("Running time (minutes)")+ylab("Species tree error (NRF)")+
  scale_shape(name=expression(k))+
  scale_size(name=expression(k),breaks=unique(e2s$V3))+
  scale_color_brewer(palette = "Dark2",name="Gene trees",labels=function(x) sub("true","true gt",sub("00","00 bp",x)))+
  scale_x_log10()+
  theme_bw()
ggsave("E2.pdf",width = 4.5,height = 3.5)

ggplot( aes(x=V3, y=V8, color=V5,shape=V4,linetype=V4), data=e2a[e2a$V5=="PL",])+
  stat_summary()+
  stat_summary(geom="line")+
  #scale_x_continuous(breaks=unique(e2a$V2))+
  xlab("n")+ylab("Species tree error (NRF)")+
  theme_bw()#+coord_cartesian(ylim=c(0,0.15))


dcast(formula =V2+V3+V4~V5 ,data=e2t)


