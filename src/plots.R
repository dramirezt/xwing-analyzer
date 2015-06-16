get_attack_plot <- function(atk_rolls){
  attackPlot <- ggplot(atk_rolls, aes(factor(x), prob, fill=type)) + 
    geom_bar(stat="identity", position="dodge") +
    labs(list(title="Attack statistics", x="# of hits", y="Probability")) +
    ylim(0, 100) +
    geom_text(aes(label=paste(prob, "%")), vjust=-0.2, size=8) + 
    theme(text = element_text(size=20, colour="red", face="bold.italic"), legend.position="top")
  
  g
}


get_defense_plot <- function(def_rolls){
  defensePlot <- ggplot(def_rolls, aes(factor(x), prob, fill=type)) + 
    geom_bar(stat="identity", position="dodge") +
    labs(list(title="Defense statistics", x="# of evades", y="Probability")) +
    ylim(0, 100) +
    geom_text(aes(label=paste(prob, "%")), vjust=-0.2, size=8) + 
    theme(text = element_text(size=20, colour="green", face="bold.italic"), legend.position="top")
  
  g
}



get_combat_plot <- function(combat_rolls){
  g <- ggplot(combat_rolls, aes(hits, prob)) + 
    geom_bar(stat="identity", fill=atk_colours[1:nrow(combat_rolls)], width=1) +
    labs(list(title="Combat statistics", x="Hits received", y="Probability")) +
    ylim(0, 100) +
    geom_text(aes(label=paste(prob, "%")), vjust=-1, size=4, colour=atk_colours[1:nrow(combat_rolls)]) + 
    theme(text = element_text(size=20, colour="black", face="bold.italic"))
  
  g
}
