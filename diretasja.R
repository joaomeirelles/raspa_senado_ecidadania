library("ggplot2")
library("igraph")
library("devtools")

d <- read.csv(file="/home/jm/Documents/database/diretasja/diretas_data.csv", header=TRUE, sep=",")
d$datahora <- as.POSIXct(d$datahora, format="%Y-%m-%d %H:%M:%S")
#str(d)


o <- ggplot() + 
  geom_line(data= d, aes(x=datahora,y=favor), colour="mediumseagreen") + 
  geom_line(data= d, aes(x=datahora,y=contra), colour="brown3") +
  ylab('total de votos')+xlab('')+ theme_bw(base_size = 12, base_family = "cambria")+
  annotate("text", x = d$datahora[300], y = d$favor[1], label = "a favor", colour="mediumseagreen")+
  annotate("text", x = d$datahora[300], y = d$contra[1]+5000, label = "contra", colour="brown3")
ggsave("/home/jm/Documents/database/diretasja/overview.png", plot=o, width = 6, height = 3)

c <- ggplot() + 
  geom_line(data= d, aes(x=datahora,y=contra), colour="brown3") +
  ylab('total de votos')+xlab('')+ theme_bw(base_size = 12, base_family = "cambria")+
  annotate("text", x = d$datahora[500], y = d$contra[1]+d$contra[1]/100, label = "contra", colour="brown3", size = 8)
ggsave("/home/jm/Documents/database/diretasja/contra.png", plot=c, width = 3, height = 3)

f <- ggplot() + 
  geom_line(data= d, aes(x=datahora,y=favor), colour="mediumseagreen") +
  ylab('total de votos')+xlab('')+ theme_bw(base_size = 12, base_family = "cambria")+
  annotate("text", x = d$datahora[500], y = d$favor[1]+d$favor[1]/50, label = "a favor", colour="mediumseagreen", size = 8)
ggsave("/home/jm/Documents/database/diretasja/favor.png", plot=f, width = 3, height = 3)  


n <- nrow(d)
d_ret_fav <- ((d[2:n, 2] - d[1:(n-1), 2])/d[1:(n-1), 2])
d_ret_con <- ((d[2:n, 3] - d[1:(n-1), 3])/d[1:(n-1), 3])

d <- d[2:n,]
d$favor_cum <- d_ret_fav 
d$contra_cum <- d_ret_con 


v <- ggplot() + 
  geom_line(data= d, aes(x=datahora,y=contra_cum), colour="brown3") +
  geom_line(data= d, aes(x=datahora,y=favor_cum), colour="mediumseagreen") + 
  ylab('total de votos no intervalo')+xlab('')+ theme_bw(base_size = 12, base_family = "cambria")+
  annotate("text", x = d$datahora[n/2], y = d$favor_cum[1]+0.00005, label = "a favor", colour="mediumseagreen")+
  annotate("text", x = d$datahora[n/2], y = d$favor_cum[1], label = "contra", colour="brown3")
ggsave("/home/jm/Documents/database/diretasja/variacao.png", plot=v, width = 6, height = 3)  

#ggplot() + 
#  geom_line(data= d, aes(x=datahora,y=favor_cum), colour="mediumseagreen") + 
#  theme_bw()

#ggplot() + 
#  geom_line(data= d, aes(x=datahora,y=contra_cum), colour="brown3") +
#  theme_bw()
                                       