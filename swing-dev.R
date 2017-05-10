
#' swing
#'
#' @param swing1 
#' @param swing2 
#' @param constituency 
#' @param region 
#' @param swing_style 
#'
#' @return
#' @export
#'
#' @examples



swing <- function(swing1=c("Conservative","Green", "Labour","Liberal Democrat" ,"Plaid Cymru","Scottish National Party","UKIP"), swing2=c("Conservative","Green", "Labour","Liberal Democrat","Plaid Cymru","Scottish National Party","UKIP"), constituency=NULL, region=NULL, swing_style=c("Butler", "Steed")){
  
  par_tib <- tibble(par_names=c("Conservative","Green", "Labour","Liberal Democrat" ,"Plaid Cymru","Scottish National Party","UKIP"), par_abs=c("con","green", "lab","ld" ,"pc","snp","ukip"))
  
  swing1_func <- par_tib$par_abs[par_tib$par_names==swing1]
  
  swing2_func <- par_tib$par_abs[par_tib$par_names==swing2]
  
  ### Subset data based on party names and restrictions
  
  swing_tbl <- parlitools::bes_2015
  
  if(swing_style=="Butler"){
    
    swing1_votes10 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing1_func, "_vote_10"))), na.rm = TRUE)
    
    swing2_votes10 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing2_func, "_vote_10"))), na.rm = TRUE)
    
    swing1_votes15 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing1_func, "_vote_15"))), na.rm = TRUE)
    
    swing2_votes15 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing2_func, "_vote_15"))), na.rm = TRUE)
    
    votes15 <- sum(dplyr::select(swing_tbl, total_vote_15), na.rm = TRUE)
    
    votes10 <- sum(dplyr::select(swing_tbl, total_vote_10), na.rm = TRUE)
    
    perc1_10 <- (swing1_votes10/votes10)*100
    
    perc2_10 <- (swing2_votes10/votes10)*100
    
    perc1_15 <- (swing1_votes15/votes15)*100
    
    perc2_15 <- (swing2_votes15/votes15)*100
    
    chng1 <- abs(perc1_15 - perc1_10)
    
    chng2 <- abs(perc2_15 - perc2_10)
    
    swing <- (chng1+chng2)/2
    
  } else if(swing_style =="Steed"){
    
    swing1_votes10 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing1_func, "_vote_10"))), na.rm = TRUE)
    
    swing2_votes10 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing2_func, "_vote_10"))), na.rm = TRUE)
    
    swing1_votes15 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing1_func, "_vote_15"))), na.rm = TRUE)
    
    swing2_votes15 <- sum(dplyr::select(swing_tbl, dplyr::contains(paste0(swing2_func, "_vote_15"))), na.rm = TRUE)
    
    tot1 <- swing1_votes15 + swing1_votes10
    
    tot2 <- swing2_votes15 + swing2_votes10
    
    chng1 <- perc1_15 *(perc1_15+perc1_10)
    
    chng2 <- perc2_15 *(perc2_15+perc2_10)
    
    chng1 - chng2  
    
  }
  
  
}
