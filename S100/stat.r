require(reshape2); require(ggplot2); require(scales);

s = (read.csv('data-accuracy-and-timings-ntaxa-100-new.csv'))
levels(s$MTHD) =  list("MulRF" = "mulrf", "DupTree" = "duptree","Astrid" = "astrid","STAG"="stag","A-Pro*"="apro-w-true", "A-Pro (V1)" ="apro","A-Pro" ="apro-v2","ASTRAL-multi"="astral-multi", "FastMulRFS"="fastmulrfs-single")
s[s$SQLN == 0,"SQLN"] = Inf
names(s)[5]="Seq Len"
names(s)[6]="k"
names(s)[2]="Ne"
s$Model=interaction(s$Ne/10000000,s$DLRT*10^10,sep="/")


dcast(Var2~value,data=melt(t(apply(round(dcast(
  k+Model+`Seq Len`~MTHD,data=s[s$MTHD %in% c("MulRF","DupTree",  "A-Pro","ASTRAL-multi"),],
  fun.aggregate = mean, value.var = "SERF")[,4:7],digits = 2), 1, rank, ties.method='min'))))


ggplot(aes(y=SERF,x=Model,group=MTHD,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro","ASTRAL-multi"),])+
  facet_grid(`Seq Len`~k,labeller = label_both,scales="free")+
  stat_summary(size=0.3,geom="errorbar",width=0.1)+stat_summary(size=0.051)+stat_summary(geom="line")+
  scale_y_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_discrete(name="ILS level / Duplication Rate")
ggsave("results-100taxa.pdf",width=7.5,height = 8)


ggplot(aes(y=SERF,x=k,group=MTHD,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro","ASTRAL-multi"),])+
  facet_grid(`Seq Len`~Model,labeller = label_both,scales="free")+
  stat_summary(geom="errorbar",width=0.08)+stat_summary(size=0.03)+stat_summary(geom="line")+
  scale_y_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_log10(breaks=c(25,50,100,500))
ggsave("results-100taxa-2.pdf",width=8.7,height = 7.2)

ggplot(aes(x=SERF,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro","ASTRAL-multi"),])+
  facet_grid(Model~`Seq Len`,labeller = label_both,scales="free")+
  stat_ecdf()+
  scale_x_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  scale_y_continuous(labels=percent, name="ECDF (% replicates)")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))
ggsave("results-100taxa-ecdf.pdf",width=11,height = 7.4)

ggplot(aes(y=SERF,x=as.factor(`Seq Len`),group=MTHD,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro","ASTRAL-multi"),])+
  facet_grid(k~Model,labeller = label_both,scales="free")+
  stat_summary(geom="errorbar",width=0.1)+stat_summary(size=0.051)+stat_summary(geom="line")+
  scale_y_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_discrete(name="Sequence length")
ggsave("results-100taxa-3.pdf",width=8,height = 7)

ggplot(aes(y=SERF,x=k,group=MTHD,color=MTHD),data=s[s$MTHD %in% c("STAG", "A-Pro"),])+
  facet_grid(`Seq Len`~Model,labeller = label_both,scales="free")+
  stat_summary(geom="errorbar",width=0.1)+stat_summary(size=0.051)+stat_summary(geom="line")+
  scale_y_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_log10(breaks=c(25,50,100,500))
ggsave("results-100taxa-stag.pdf",width=8,height = 7)


ggplot(aes(y=SERF,x=k,group=MTHD,color=MTHD),data=s[s$MTHD %in% c("A-Pro*", "A-Pro (V1)", "A-Pro"),])+
  facet_grid(`Seq Len`~Model,labeller = label_both,scales="free")+
  stat_summary(geom="errorbar",width=0.1)+stat_summary(size=0.051)+stat_summary(geom="line")+
  scale_y_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_log10(breaks=c(25,50,100,500))
ggsave("results-100taxa-X-2.pdf",width=8,height = 7)

ggplot(aes(y=SERF,x=interaction(k,`Seq Len`,sep=":"),group=MTHD,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro (V2)","ASTRAL-multi"),,])+
  facet_grid(DLRT~Ne,labeller = label_both,scales="free")+
  stat_summary(geom="errorbar",width=0.1)+stat_summary(size=0.051)+stat_summary(geom="line")+
  scale_y_continuous(labels=percent, name="Species tree error (NRF)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1),axis.text.x = element_text(angle=45,hjust=1))


ggplot(aes(y=SECS/60,x=Model,group=MTHD,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro","ASTRAL-multi"),])+
  facet_grid(`Seq Len`~k,labeller = label_both,scales="free")+
  stat_summary(size=0.1,width=1)+stat_summary(geom="line")+
  scale_y_log10(name="Running time (minutes)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_discrete(name="Duplication Rate / ILS level")
ggsave("runningtimes-100taxa.pdf",width=8,height = 7)


ggplot(aes(y=SECS/60,x=k,group=MTHD,color=MTHD),data=s[s$MTHD %in% c("MulRF","DupTree", "A-Pro","ASTRAL-multi"),])+
  facet_grid(`Seq Len`~Model,labeller = label_both,scales="free")+
  stat_summary(geom="errorbar",width=0.1)+stat_summary(size=0.051)+stat_summary(geom="line")+
  scale_y_log10( name="Running time (minutes)")+
  scale_color_brewer(palette = "Set2",name="")+
  theme_classic()+theme(legend.position = "bottom",panel.border  = element_rect(fill=NA,size = 1))+
  scale_x_log10(breaks=c(25,50,100,500))
ggsave("runningtime-100taxa-2.pdf",width=8,height = 7)
