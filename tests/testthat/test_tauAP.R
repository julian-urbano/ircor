context("tauAP")

test_that("tauAP", {
  expect_equal(tauAP(set1$x, set1$y), .8519, tolerance = 5e-5)
  expect_equal(tauAP(set2$x, set2$y), .2504, tolerance = 5e-5)
  expect_equal(tauAP(set3$x, set3$y), -.6971, tolerance = 5e-5)
})

test_that("tauAP_a", {
  # check that it's the same as tauAP when there are no ties
  expect_equal(tauAP_a(set1$x, set1$y), .8519, tolerance = 5e-5)
  expect_equal(tauAP_a(set2$x, set2$y), .2504, tolerance = 5e-5)
  expect_equal(tauAP_a(set3$x, set3$y), -.6971, tolerance = 5e-5)

  # now with ties in y
  expect_equal(tauAP_a(set1$x, set1$y.ties), .7454, tolerance = 5e-5)
  expect_equal(tauAP_a(set2$x, set2$y.ties), .2692, tolerance = 5e-5)
  expect_equal(tauAP_a(set3$x, set3$y.ties), -.5558, tolerance = 5e-5)
})

test_that("tauAP_b", {
  # check that it's the same as symmetric tauAP when there are no ties
  expect_equal(tauAP_b(set1$x, set1$y), .8333, tolerance = 5e-5)
  expect_equal(tauAP_b(set2$x, set2$y), .2880, tolerance = 5e-5)
  expect_equal(tauAP_b(set3$x, set3$y), -.668, tolerance = 5e-5)

  # now with ties
  expect_equal(tauAP_b(set1$x.ties, set1$y.ties), .7321, tolerance = 5e-5)
  expect_equal(tauAP_b(set2$x.ties, set2$y.ties), .297, tolerance = 5e-5)
  expect_equal(tauAP_b(set3$x.ties, set3$y.ties), -.7047, tolerance = 5e-5)
  # and symmetry
  expect_equal(tauAP_b(set1$y.ties, set1$x.ties), .7321, tolerance = 5e-5)
  expect_equal(tauAP_b(set2$y.ties, set2$x.ties), .297, tolerance = 5e-5)
  expect_equal(tauAP_b(set3$y.ties, set3$x.ties), -.7047, tolerance = 5e-5)
})
