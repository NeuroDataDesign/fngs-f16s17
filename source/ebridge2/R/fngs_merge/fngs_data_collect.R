# -------- FNGS Data Collect ----------------------------------#
datasets <- c('BNU1', 'BNU2', 'DC1', 'HNU1', 'IPCAS1', 'IPCAS2', 'IPCAS5', 'IPCAS6',
              'IPCAS8','IACAS', 'IBATRT', 'NYU1', 'SWU1', 'SWU2', 'SWU3', 'SWU4',
              'UWM', 'XHCUMS')

basepath <- '/data/timeseries'

fngs_scanids <- list()
fngs_results <- data.frame(dataset=c(), pipeline=c(), discriminability=c())
performed_dataset <- c()
for (dataset in datasets) {
  print(dataset)
  dset_path <- paste(basepath, dataset, 'timeseries/roi/desikan-2mm/', sep='/')
  fngs_obj <- fmriu.io.open_timeseries(dset_path)
  signal <- fngs_obj$ts
  if (length(signal) != 0) {
    performed_dataset <- c(performed_dataset, dataset)
    fngsids <- fngs_obj$subjects
    d <- tryCatch({
      discr.time.obs2discr(signal, fngsids, rank=TRUE)$d
    },
    error=function(e) {return(NaN)}
    )
    print(d)
    fngs_results <- rbind(fngs_results, data.frame(dataset=dataset, pipeline='FNGS',
                                                   n=length(fngsids), discriminability=d))
  }
}
