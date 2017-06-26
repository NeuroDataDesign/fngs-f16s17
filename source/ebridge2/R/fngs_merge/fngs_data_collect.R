# -------- FNGS Data Collect ----------------------------------#
datasets <- c('BNU1', 'BNU2', 'DC1', 'HNU1', 'IACAS', 'IBATRT',
              'NYU1', 'SWU1', 'SWU2', 'SWU3', 'SWU4', 'UM', 'Utah1',
              'UWM', 'XHCUMS')

basepath <- 'C:/Users/ebrid/Documents/R/FNGS_results'

fngs_scanids <- list()
fngs_results <- data.frame(dataset=c(), pipeline=c(), discriminability=c())
performed_dataset <- c()
for (dataset in datasets) {
  dset_path <- paste(basepath, dataset, 'timeseries/roi/aal-2mm/', sep='/')
  fngs_tsnames <- list.files(dset_path, pattern="\\.rds", full.names=TRUE)
  scan_pos = 2
  if (length(fngs_tsnames) != 0) {
    performed_dataset <- c(performed_dataset, dataset)
    print(dataset)
    fngs_obj <- open_timeseries(fngs_tsnames, sub_pos=scan_pos)
    signal <- fngs_obj[[1]]
    fngsids <- fngs_obj[[3]]
    fngs_scanids[[dataset]] <- cpac_ids
    d <- time_discr(signal, fngsids, rank=TRUE, graphs = FALSE)$d
    print(d)
    fngs_results <- rbind(fngs_results, data.frame(dataset=dataset, pipeline='FNGS',
                                                   n=length(fngs_tsnames), discriminability=d))
  }
}