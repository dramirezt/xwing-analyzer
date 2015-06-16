# Dice probabilities

p_atk_normal <- 4/8
p_atk_focus <- 6/8
p_atk_focus_targetlock <- p_atk_focus + (1 - p_atk_focus)*(p_atk_focus)

p_def_normal <- 3/8
p_def_focus <- 5/8

# Getting attack distribution probability

get_atk_prolls <- function(attack_dices=2, focus=TRUE, targetlock=FALSE){
  attack <- as.integer(attack_dices)
  successes <- seq(0, attack, by=1)
  
  dist_atk_normal <- round((dbinom(successes, attack, p_atk_normal)*100), 2)
  dnormal <- data.frame(x = successes, prob = dist_atk_normal, type = "None")
  p_atk_rolls <- dnormal
  
  if(focus || targetlock){
    dist_atk_focus <- round((dbinom(successes, attack, p_atk_focus)*100), 2)
    dfocus <- data.frame(x = successes, prob = dist_atk_focus, type = "Focus / Target Lock")
    p_atk_rolls <- merge(p_atk_rolls, dfocus, all=TRUE)
  }
  if(focus && targetlock){
    dist_atk_targetlock <- round((dbinom(successes, attack, p_atk_focus_targetlock)*100), 2)
    dtargetlock <- data.frame(x = successes, prob = dist_atk_targetlock, type = "Target Lock + Focus")
    p_atk_rolls <- merge(p_atk_rolls, dtargetlock, all=TRUE)
  }
  
  p_atk_rolls
}


# Getting defense distribution probability

get_def_prolls <- function(defense_dices=2, focus=TRUE, cloak=FALSE){
  defense <- defense_dices
  successes <- seq(0, defense, by=1)
  if(cloak){
    successes <- seq(0, defense+2, by=1)
  }
  
  dist_def_normal <- round((dbinom(successes, defense, p_def_normal)*100), 2)
  dnormal <- data.frame(x = successes, prob = dist_def_normal, type = "None")
  p_def_rolls <- dnormal
  
  if(focus){
    dist_def_focus <- round((dbinom(successes, defense, p_def_focus)*100), 2)
    dfocus <- data.frame(x = successes, prob = dist_def_focus, type = "Focus")
    p_def_rolls <- merge(p_def_rolls, dfocus, all=TRUE)
  }
  if(cloak){
    dist_def_normal_clk <- round((dbinom(successes, defense+2, p_def_normal)*100), 2)
    dnormalclk <- data.frame(x = successes, prob = dist_def_normal_clk, type = "Cloak")
    p_def_rolls <- merge(p_def_rolls, dnormalclk, all=TRUE)
    if(focus){
      dist_def_focus_clk <- round((dbinom(successes, defense+2, p_def_focus)*100), 2)
      dfocusclk <- data.frame(x = successes, prob = dist_def_focus_clk, type = "Cloak + Focus")
      p_def_rolls <- merge(p_def_rolls, dfocusclk, all=TRUE)
    }
  }
  
  p_def_rolls
}