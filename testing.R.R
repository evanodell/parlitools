
x <- constituencies()

y <- election_results(ID = 382386)

test5 <- left_join(y, x, by = c("constituency_about"= "about"))



elections()
