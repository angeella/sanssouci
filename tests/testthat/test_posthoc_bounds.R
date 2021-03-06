context("Upper bound of the number of false positives in a selection")

test_that("Upper bound on the number of false positives", {
    m <- 123
    sim <- gaussianSamples(m = m, rho = 0.2, n = 100, pi0 = 0.8, SNR = 3, prob = 0.5)
    X <- sim$X
    cal <- calibrateJER(X, B = 1e3, alpha = 0.2,refFamily="Simes")
    thr <- cal$thr
    stat <- cal$stat
    
    expect_error(maxmaxFP(stat, rev(thr)))  ## thr is not sorted descendingly
    
    sstat <- sort(stat, decreasing=TRUE)
    best <- head(sstat)
    worse <- tail(sstat)
    b1 <- maxFP(best, thr)
    b2 <- maxFP(c(best, worse), thr)
    b3 <- maxFP(worse, thr)
    expect_lt(b1, b2)
    expect_lt(b1, b3)
    expect_lte(b3, b2)
    
    ub <- curveMaxFP(stat = sstat, thr)
    expect_equal(ub[length(best)], b1)
    
    M0 <- maxFP(stat, thr)
    sM0 <- maxFP(sstat, thr)
    expect_equal(M0, sM0)
    expect_equal(M0, ub[m])
})

test_that("curveMaxFP", {
    m <- 123
    sim <- gaussianSamples(m = m, rho = 0.2, n = 100, pi0 = 0.8, SNR = 3, prob = 0.5)
    X <- sim$X
    cal <- calibrateJER(X, B = 1e3, alpha = 0.2, refFamily="Simes")
    thr <- cal$thr
    stat <- cal$stat
    sstat <- sort(stat, decreasing=TRUE)
    
    expect_error(curveMaxFP(sstat, rev(thr)))  ## thr is not sorted descendingly
    expect_error(curveMaxFP(rev(sstat), rev(thr)))  ## stat is not sorted descendingly
    
    ub <- curveMaxFP(sstat, thr)
    expect_length(ub, m)
    expect_identical(ub, sort(ub))
    for (kk in seq_len(m)) {
        bk <- maxFP(sstat[seq_len(kk)], thr)
        expect_equal(bk, ub[kk])
    }
})

test_that("flavors of curveMaxFP", {
    m <- 123
    sim <- gaussianSamples(m = m, rho = 0.2, n = 100, pi0 = 0.8, SNR = 3, prob = 0.5)
    X <- sim$X
    cal <- calibrateJER(X, B = 1e3, alpha = 0.2, refFamily="Simes")
    thr <- cal$thr
    stat <- cal$stat
    sstat <- sort(stat, decreasing=TRUE)
    
    ub <- curveMaxFP(sstat, thr)
    ub16 <- curveMaxFP(sstat, thr, flavor = "BNR2014")
    ub14 <- curveMaxFP(sstat, thr, flavor = "BNR2014") 
    ub06 <- curveMaxFP(sstat, thr, flavor = "Mein2006") 
    expect_identical(ub, ub16)
    expect_identical(ub, ub14)
    expect_identical(ub, ub06)  ## not sure this is always true?
})
