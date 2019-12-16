find_cluster <- function(m, remain = NULL, th = 0){
  select <- c()
  if (is.null(remain)){
    remain <- 1:ncol(m)
  }
  
  while(TRUE){
    if (length(remain) == 0){
      break;
    }
    best_val <- -1
    for (i in 1:length(remain)){
      temp <- min(m[c(select, remain[i]), remain[i]], 
                  m[remain[i], c(select, remain[i])])
      if (temp > best_val){
        best_val <- temp
        best_ind <- remain[i]
        best_ind_ind <- i
      }
    }
    if (best_val >= th){
      select <- c(select, remain[best_ind_ind])
      remain <- remain[-best_ind_ind]
    } else {
      break;
    }
  }
  return(list(select=select, remain=remain))
}

find_neg_cluster <- function(m, remain = NULL, th = 0){
  select <- c()
  if (is.null(remain)){
    remain <- 1:ncol(m)
  }
  
  while(TRUE){
    if (length(remain) == 0){
      break;
    }
    best_val <- 1
    for (i in 1:length(remain)){
      temp <- max(m[c(select, remain[i]), remain[i]], 
                  m[remain[i], c(select, remain[i])])
      if (temp < best_val){
        best_val <- temp
        best_ind <- remain[i]
        best_ind_ind <- i
      }
    }
    if (best_val <= th){
      select <- c(select, remain[best_ind_ind])
      remain <- remain[-best_ind_ind]
    } else {
      break;
    }
  }
  return(list(select=select, remain=remain))
}

find_all_clusters <- function(m, pos_th = 0, neg_th = 0, verbose = T){
  if (verbose){
    verbose_message <- message
  } else {
    verbose_message <- function(...){}
  }
  verbose_message("Positive correlation clusters:")
  if (!is.null(colnames(m))){
    entities <- colnames(m)
  } else {
    entities <- 1:ncol(m)
  }
  ind <- c()
  mat2 <- mat
  remain <- 1:ncol(m)
  while(TRUE){
    new_cluster <- find_cluster(m, remain, pos_th)
    if (length(new_cluster$select) == 0){
      break;
    }
    verbose_message(paste(entities[new_cluster$select], collapse = ' '))
    ind <- c(ind, new_cluster$select)
    remain <- new_cluster$remain
  }

  verbose_message("Negative correlation clusters:")
  ind2 <- c()
  while(TRUE){
    new_cluster <- find_neg_cluster(m, remain, neg_th)
    if (length(new_cluster$select) == 0){
      break;
    }
    verbose_message(paste(entities[new_cluster$select], collapse = ' '))
    ind2 <- c(new_cluster$select, ind2)
    remain <- new_cluster$remain
  }
  
  return(c(ind, ind2))
}
