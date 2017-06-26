# ----------- Collect Data from CPAC pipelines ---------------------- #

datasets <- c('BNU1', 'BNU2', 'DC1', 'HNU1', 'IACAS', 'IBATRT',
              'NYU1', 'SWU1', 'SWU2', 'SWU3', 'SWU4', 'UM', 'Utah1',
              'UWM', 'XHCUMS')
pipes <- c('FSL_frf_nsc_ngs_aal', 'FSL_nff_nsc_ngs_aal')
basepath <- 'C:/Users/ebrid/Documents/R/CPAC_results'

discrs <- list()

for (pipe in pipes) {
  discrs[[pipe]] <- c()
}

subids <- list()
for (dataset in datasets[(length(discrs[[pipe]])+1):length(datasets)]) {
  print(dataset)
  subids[[dataset]] <- list()
  for (pipe in pipes) {
    print(pipe)
    dset_path <- paste(basepath, dataset, pipe, pipe, '', sep='/')
    cpac_tsnames <- list.files(dset_path, pattern="\\.graphml", full.names=TRUE)
    scan_pos = 2
    cpac_graobj <- open_graphs(cpac_tsnames, sub_pos=scan_pos)
    cpac_graphs <- cpac_graobj[[1]]
    cpac_ids <- cpac_graobj[[3]]
    subids[[dataset]][[pipe]] <- cpac_ids
    d <- time_discr(cpac_graphs, cpac_ids, rank=TRUE, graphs = TRUE)$d
    print(d)
    discrs[[pipe]] <- c(discrs[[pipe]], d)
  }
}

results <- list()

for (pipe in pipes) {
  results[[pipe]] <- data.frame(dataset=datasets,
                                pipeline=rep('CPAC', length(datasets)),
                                discrs[[pipe]])
}
