density_function <- function(df, xcol, ycol, length.out=5){
  density_shiz <- function(df){
    bins <- seq(min(df[[ycol]], na.rm = TRUE),
                max(df[[ycol]],   na.rm = TRUE), length.out =length.out)

    df1 <- df %>%
      mutate(bin = cut(.[[ycol]], bins, ordered_result=TRUE)) %>%
      group_by(bin) %>%
      summarise(density=n())

    while (length(bins)!=nrow(df1)){
      bins <- seq(min(df[[ycol]], na.rm = TRUE),
                  max(df[[ycol]],   na.rm = TRUE),length.out=nrow(df1) )

      df1 <- df %>%
        mutate(bin = cut(.[[ycol]], bins, )) %>%
        group_by(bin) %>%
        summarise(density=n())
    }


    df1 %>%
      mutate(bin_val=bins,
             bin_max = lead(bin_val, default=max(bins)+(bins[2]-bins[1])),
             bin_chr = as.character(bin),
             group=pull(df, xcol)[1]) %>%
      replace_na(list(bin_chr='max_bin')) %>%
      select(!bin)
  }

  df %>%
    tidyr::drop_na()%>%
    group_by(!!sym(xcol))%>%
    group_map(~density_shiz(.), .keep=TRUE)%>%
    bind_rows()%>%
    mutate(group_fct = as.factor(group))
}
