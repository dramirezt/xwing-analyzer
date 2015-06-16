# Reading ship data from ships dataset

get_faction_ships <- function(faction_code=0){
  if(faction_code == 1) ships[ships$Faction == 1, ]
  else if(faction_code == 2) ships[ships$Faction == 2, ]
  else if(faction_code == 3) ships[ships$Faction == 3, ]
  else ships
}


get_curr_ship <- function(ship_code=1){
  ships <- get_faction_ships()
  
  ships[ships$id == ship_code, ]
}


get_ship_name <- function(ship_code=1){
  if(ship_code != 0 && !is.null(ship_code)){ 
    lapply(get_curr_ship(ship_code)$Name, as.character)[[1]]
  }
  else "No ship selected"
}


get_ship_attack <- function(ship_code=1){
  as.numeric(get_curr_ship(ship_code)$Attack)
}


get_ship_defense <- function(ship_code=1){
  as.numeric(get_curr_ship(ship_code)$Defense)
}


get_ship_hull <- function(ship_code=1){
  as.numeric(get_curr_ship(ship_code)$Hull)
}


get_ship_shields <- function(ship_code=1){
  as.numeric(get_curr_ship(ship_code)$Shields)
}


get_ship_focus <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$Focus)
}


get_ship_evade <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$Evade)
}


get_ship_targetlock <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$TargetLock)
}


get_ship_cloak <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$Cloak)
}


get_ship_barrelroll <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$BarrelRoll)
}


get_ship_boost <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$Boost)
}


get_ship_slam <- function(ship_code=1){
  as.logical(get_curr_ship(ship_code)$Slam)
}