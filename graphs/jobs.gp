#!/usr/bin/env gnuplot

linear(x) = linear_a + linear_b*x
quadratic(x) = quadratic_a + quadratic_b*x + quadratic_c*x**2
power(x) = power_a + power_b*x**power_c

set terminal latex
# set ylabel 'execution time (seconds)' # TODO not rotated (might need different terminal)

SSR(SST) = SST - (FIT_WSSR / (FIT_NDF + 2)) # assuming a function with two variables (i. e. two less degrees of freedom than records)
R2(SST) = SSR(SST) / SST

set datafile separator tab
total_real = '(column("download (real)") + column("r2g (real)") + column("simplify (real)") + column("shex (real)") + column("html (real)"))'

do for [file in 'jobs jobs-without-outliers'] {
  do for [x_axis in 'entities triples P31s classes'] {
    infile = 'graphs/' . file . '.tsv'
    outfile = 'graphs/' . file . '-over-' . x_axis . '.tex'
    linear_a = 1
    linear_b = 1
    quadratic_a = 1
    quadratic_b = 1
    quadratic_c = 1
    power_a = 1
    power_b = 1
    power_c = 1

    fit mean infile using (column(x_axis)):@total_real via mean
    SST = FIT_WSSR / (FIT_NDF + 1)
    fit linear(x) infile using (column(x_axis)):@total_real via linear_a, linear_b
    linear_r2 = R2(SST)
    fit quadratic(x) infile using (column(x_axis)):@total_real via quadratic_a, quadratic_b, quadratic_c
    quadratic_r2 = R2(SST)
    fit power(x) infile using (column(x_axis)):@total_real via power_a, power_b, power_c
    power_r2 = R2(SST)

    set output outfile
    set key left # position
    set key Left # alignment
    set key reverse # sample to the left of text
    plot infile using (column(x_axis)):@total_real title 'data', \
         linear(x) title sprintf('$%.2f %+.2fx$ ($R^2 = %.2f$)', linear_a, linear_b, linear_r2), \
         quadratic(x) title sprintf('$%.2f %+.2fx %+.2fx^2$ ($R^2 = %.2f$)', quadratic_a, quadratic_b, quadratic_c, quadratic_r2), \
         power(x) title sprintf('$%.2f %+.2fx^{%.2f}$ ($R^2 = %.2f$)', power_a, power_b, power_c, power_r2)
  }
}
# TODO probably check the r² calculations
