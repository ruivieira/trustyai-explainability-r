#' @export df_to_features
df_to_features <- function(df) {
  f <- c()
  for(i in 1:ncol(df)) {
    f <- append(f, feature(name=colnames(df)[i],
                           type="number",
                           value = as.double(df[1, i])))
  }
  return(f)
}
