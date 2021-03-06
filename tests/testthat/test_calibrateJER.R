context("JER calibration")

test_that("JER calibration -- vanilla tests", {
    m <- 123
    rho <- 0.2
    n <- 100
    pi0 <- 0.5
    sim <- gaussianSamples(m, rho, n, pi0, SNR = 2, prob = 0.5)
    X <- sim$X
    alpha <- 0.2
    B <- 100

    cal <- calibrateJER(X, B, alpha, refFamily = "Simes")
    expect_length(cal$thr, m)
    expect_length(cal$stat, m)

    cal <- calibrateJER(X, B, alpha, refFamily = "Simes", K = 50)
    expect_length(cal$thr, 50)
    expect_length(cal$stat, m)
})

test_that("Direction of (step-down) lambda-calibration vs alternative: independence", {
    alpha <- 0.2
    alts <- c("two.sided", "greater", "less")
    nb_rep <- 10
    res <- matrix(NA_real_, nrow = nb_rep, ncol = length(alts))
    colnames(res) <- alts
    for (ii in 1:nb_rep) {
        sim <- gaussianSamples(m = 123, rho = 0, n = 100, pi0 = 0.5, SNR = -10, prob = 0.5)
        for (alt in alts) {
            cal <- calibrateJER(X = sim$X, B = 100, alpha = alpha, 
                                refFamily = "Simes", alternative = alt,
                                maxStepsDown = 1L,
                                verbose = TRUE)
            res[ii, alt] <- cal$lambda
        }
    }
    q1 <- matrixStats::colQuantiles(res, probs = 0.25)
    ## expected ordering (whp) for negative SNR 
    ## (could also do a test for positive SNR)
    ## step down catches up
    expect_gte(q1[["two.sided"]], alpha)
    expect_gte(q1[["less"]], alpha)
    expect_gte(q1[["two.sided"]], q1[["greater"]])
    expect_gte(q1[["less"]], q1[["greater"]])
})


test_that("Direction of (single-step) lambda-calibration vs alternative (Gaussian equi-correlation)", {
    alpha <- 0.2
    alts <- c("two.sided", "greater", "less")
    nb_rep <- 10
    
    # SNR = 0
    res <- matrix(NA_real_, nrow = nb_rep, ncol = length(alts))
    colnames(res) <- alts
    for (ii in 1:nb_rep) {
        sim <- gaussianSamples(m = 123, rho = 0.4, n = 100, pi0 = 0.5, 
                               SNR = 10, prob = 0.5)
        for (alt in alts) {
            cal <- calibrateJER(X = sim$X, B = 100, alpha = alpha, 
                                refFamily = "Simes", alternative = alt, 
                                maxStepsDown = 0L, verbose = TRUE)
            res[ii, alt] <- cal$lambda
        }
    }
    q1 <- matrixStats::colQuantiles(res, probs = 0.25)
    expect_gte(q1[["less"]], alpha)
    expect_gte(q1[["two.sided"]], alpha)
    expect_gte(q1[["greater"]], alpha)
})
