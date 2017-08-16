context("tau")

test_that("tau", {
  expect_equal(tau(set1$x, set1$y), .9111, tolerance = 5e-5)
  expect_equal(tau(set2$x, set2$y), .2889, tolerance = 5e-5)
  expect_equal(tau(set3$x, set3$y), -.6889, tolerance = 5e-5)

  # check symmetry
  expect_equal(tau(set1$y, set1$x), .9111, tolerance = 5e-5)
  expect_equal(tau(set2$y, set2$x), .2889, tolerance = 5e-5)
  expect_equal(tau(set3$y, set3$x), -.6889, tolerance = 5e-5)
})

test_that("tau_a", {
  # check that it's the same as tau when there are no ties
  expect_equal(tau_a(set1$x, set1$y), .9111, tolerance = 5e-5)
  expect_equal(tau_a(set2$x, set2$y), .2889, tolerance = 5e-5)
  expect_equal(tau_a(set3$x, set3$y), -.6889, tolerance = 5e-5)
  # and symmetry
  expect_equal(tau_a(set1$y, set1$x), .9111, tolerance = 5e-5)
  expect_equal(tau_a(set2$y, set2$x), .2889, tolerance = 5e-5)
  expect_equal(tau_a(set3$y, set3$x), -.6889, tolerance = 5e-5)

  # now with ties in y
  expect_equal(tau_a(set1$x, set1$y.ties), .8889, tolerance = 5e-5)
  expect_equal(tau_a(set2$x, set2$y.ties), .3333, tolerance = 5e-5)
  expect_equal(tau_a(set3$x, set3$y.ties), -.6222, tolerance = 5e-5)
})

test_that("tau_b", {
  # check that it's the same as tau when there are no ties
  expect_equal(tau_b(set1$x, set1$y), .9111, tolerance = 5e-5)
  expect_equal(tau_b(set2$x, set2$y), .2889, tolerance = 5e-5)
  expect_equal(tau_b(set3$x, set3$y), -.6889, tolerance = 5e-5)
  # and symmetry
  expect_equal(tau_b(set1$y, set1$x), .9111, tolerance = 5e-5)
  expect_equal(tau_b(set2$y, set2$x), .2889, tolerance = 5e-5)
  expect_equal(tau_b(set3$y, set3$x), -.6889, tolerance = 5e-5)

  # now with ties
  expect_equal(tau_b(set1$x.ties, set1$y.ties), .9398, tolerance = 5e-5)
  expect_equal(tau_b(set2$x.ties, set2$y.ties), .3765, tolerance = 5e-5)
  expect_equal(tau_b(set3$x.ties, set3$y.ties), -.6510, tolerance = 5e-5)
  # and symmetry
  expect_equal(tau_b(set1$y.ties, set1$x.ties), .9398, tolerance = 5e-5)
  expect_equal(tau_b(set2$y.ties, set2$x.ties), .3765, tolerance = 5e-5)
  expect_equal(tau_b(set3$y.ties, set3$x.ties), -.6510, tolerance = 5e-5)
})
