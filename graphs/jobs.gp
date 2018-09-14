#!/usr/bin/env gnuplot

linear(x) = linear_a + linear_b*x
quadratic(x) = quadratic_a + quadratic_b*x + quadratic_c*x**2
power(x) = power_a + power_b*x**power_c

set terminal latex
# set ylabel 'execution time (seconds)' # TODO not rotated (might need different terminal)

SSR(SST) = SST - (FIT_WSSR / (FIT_NDF + 2)) # assuming a function with two variables (i. e. two less degrees of freedom than records)
R2(SST) = SSR(SST) / SST

fit mean 'graphs/jobs.tsv' using 3:4 via mean
SST = FIT_WSSR / (FIT_NDF + 1)
fit linear(x) 'graphs/jobs.tsv' using 3:4 via linear_a, linear_b
linear_r2 = R2(SST)
fit quadratic(x) 'graphs/jobs.tsv' using 3:4 via quadratic_a, quadratic_b, quadratic_c
quadratic_r2 = R2(SST)
fit power(x) 'graphs/jobs.tsv' using 3:4 via power_a, power_b, power_c
power_r2 = R2(SST)

set output 'graphs/jobs-over-triples.tex'
set key left # position
set key Left # alignment
set key reverse # sample to the left of text
# set xlabel 'input triples'
plot 'graphs/jobs.tsv' using 3:4 title 'data', \
     linear(x) title sprintf('$%.2f %+.2fx$ ($r^2 = %.2f$)', linear_a, linear_b, linear_r2), \
     quadratic(x) title sprintf('$%.2f %+.2fx %+.2fx^2$ ($r^2 = %.2f$)', quadratic_a, quadratic_b, quadratic_c, quadratic_r2), \
     power(x) title sprintf('$%.2f %+.2fx^{%.2f}$ ($r^2 = %.2f$)', power_a, power_b, power_c, power_r2)

fit mean 'graphs/jobs.tsv' using 2:4 via mean
SST = FIT_WSSR / (FIT_NDF + 1)
fit linear(x) 'graphs/jobs.tsv' using 2:4 via linear_a, linear_b
linear_r2 = R2(SST)
fit quadratic(x) 'graphs/jobs.tsv' using 2:4 via quadratic_a, quadratic_b, quadratic_c
quadratic_r2 = R2(SST)
fit power(x) 'graphs/jobs.tsv' using 2:4 via power_a, power_b, power_c
power_r2 = R2(SST)

set output 'graphs/jobs-over-entities.tex'
set key right # position
set key Right # alignment
set key noreverse # sample to the right of text
# set xlabel 'input entities'
plot 'graphs/jobs.tsv' using 2:4 title 'data', \
     linear(x) title sprintf('$%.2f %+.2fx$ ($r^2 = %.2f$)', linear_a, linear_b, linear_r2), \
     quadratic(x) title sprintf('$%.2f %+.2fx %+.2fx^2$ ($r^2 = %.2f$)', quadratic_a, quadratic_b, quadratic_c, quadratic_r2), \
     power(x) title sprintf('$%.2f %+.2fx^{%.2f}$ ($r^2 = %.2f$)', power_a, power_b, power_c, power_r2)

# TODO export fit data?
# TODO probably check the r² calculations
