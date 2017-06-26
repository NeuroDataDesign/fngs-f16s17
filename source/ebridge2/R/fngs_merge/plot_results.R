agg <- cp_results[cp_results$dataset %in% fngs_results$dataset,]
agg <- rbind(agg, fngs_results[, c(1,2,4)])

ggplot(agg, aes(x=pipeline, y=discriminability, color=dataset, group=dataset)) +
  geom_line(size=3) +
  ggtitle('Discriminability of CPAC vs FNGS') +
  theme(text=element_text(size=20))