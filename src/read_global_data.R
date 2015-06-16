# READING DATA FROM CSV FILES

ships <<- read.csv("data/ships.csv", sep=",", header=TRUE)
ships <<- ships[order(ships$Name, ships$Faction), ]

atk_colours <- c("darksalmon", "firebrick2", "red", "red3", "darkred", "firebrick4")
def_colours <- c("palegreen1", "palegreen4", "darkolivegreen2", "darkolivegreen4", "green", "green4")