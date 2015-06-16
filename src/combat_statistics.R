source("src/rolls.R")

dmgReceived <- function(attack_value=2, defense_value=2, focus_atk=TRUE, focus_def=TRUE, targetlock=FALSE, cloak=FALSE){
  atk_rolls <- get_atk_prolls(attack_value, focus_atk, targetlock)
  def_rolls <- get_def_prolls(defense_value, focus_def, cloak)
  
  if(focus_atk && targetlock) atk_rolls <- atk_rolls[atk_rolls$type=="Target Lock + Focus", ]
  else if(focus_atk || targetlock) atk_rolls <- atk_rolls[atk_rolls$type=="Focus / Target Lock", ]
  else atk_rolls <- atk_rolls[atk_rolls$type=="None", ]
  
  if(cloak && focus_def) def_rolls <- def_rolls[def_rolls$type=="Cloak + Focus", ]
  else if(cloak) def_rolls <- def_rolls[def_rolls$type=="Cloak", ]
  else if(focus_def) def_rolls <- def_rolls[def_rolls$type=="Focus", ]
  
  # [% 0 dmg received; % 1 dmg received; ...; % attack_value dmg received]
  p = rep(0, attack_value+1)
  
  if(cloak) defense_value <- defense_value+2
  
  for(i in seq(0, defense_value, by=1)){
    def_col <- def_rolls[i+1, 2]
    
    for(j in seq(0, attack_value, by=1)){
      dif <- j-i
      if(dif < 0) dif <- 0
      p[dif+1] <- p[dif+1] + def_col*atk_rolls[j+1, 2]
    }
  }
  
  p <- as.data.frame(round(p/100, 2))
  p <- cbind(seq(0, attack_value, by=1), p)
  colnames(p) <- c("hits", "prob")
  p
}