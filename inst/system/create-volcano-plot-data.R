dataSets <- c("bourgon", "golub", "hedenfalk", "loi", "rosenwald")
dataSets <- dataSets[-4] ## Dropping Loi: too weak signal

getStats <- function(dataSet) {
    filename <- sprintf("%s.rds", dataSet)
    pathname <- file.path("data", filename)
    dat <- readRDS(pathname)
    rm(pathname)
    
    res <- rowWelchTests(dat, colnames(dat))
    mres <- Reduce(cbind, res)
    colnames(mres) <- names(res)
    
    m <- nrow(mres)
    gid <- rownames(mres)
    if (is.null(gid)) {
        gid <- paste("gene", 1:m, sep = "-")
    }
    p <- mres[ ,"p.value"]
    logp <- -log10(p)
    adjp <- p.adjust(p, method = "BH")
    dat <- data.frame(id = gid, 
                 dataSet = dataSet, 
                 meanDiff = round(mres[, "meanDiff"], 3), 
                 p.value = p,
                 adjp.BH = round(adjp, 3),
                 row.names = NULL,
                 stringsAsFactors = FALSE)
    dat
}

dfList <- lapply(dataSets, getStats)
volcano <- Reduce(rbind, dfList)
save(volcano, file = "data/volcano.rda")
tools::resaveRdaFiles("data/volcano.rda")  ## why isn't this the default in 'save'?
