#!/usr/bin/env gnuplot

linear(x) = linear_a + linear_b*x
quadratic(x) = quadratic_a + quadratic_b*x + quadratic_c*x**2
power(x) = power_a + power_b*x**power_c

set terminal latex
# set ylabel 'execution time (seconds)' # TODO not rotated (might need different terminal)

fit linear(x) 'graphs/jobs.tsv' using 3:4 via linear_a, linear_b
fit quadratic(x) 'graphs/jobs.tsv' using 3:4 via quadratic_a, quadratic_b, quadratic_c
fit power(x) 'graphs/jobs.tsv' using 3:4 via power_a, power_b, power_c

set output 'graphs/jobs-over-triples.tex'
set key left # position
set key Left # alignment
set key reverse # sample to the left of text
# set xlabel 'input triples'
plot 'graphs/jobs.tsv' using 3:4 title 'data', \
     linear(x) title sprintf('$%.2f %+.2fx$', linear_a, linear_b), \
     quadratic(x) title sprintf('$%.2f %+.2fx %+.2fx^2$', quadratic_a, quadratic_b, quadratic_c), \
     power(x) title sprintf('$%.2f %+.2fx^{%.2f}$', power_a, power_b, power_c)

fit linear(x) 'graphs/jobs.tsv' using 2:4 via linear_a, linear_b
fit quadratic(x) 'graphs/jobs.tsv' using 2:4 via quadratic_a, quadratic_b, quadratic_c
fit power(x) 'graphs/jobs.tsv' using 2:4 via power_a, power_b, power_c

set output 'graphs/jobs-over-entities.tex'
set key right # position
set key Right # alignment
set key noreverse # sample to the right of text
# set xlabel 'input entities'
plot 'graphs/jobs.tsv' using 2:4 title 'data', \
     linear(x) title sprintf('$%.2f %+.2fx$', linear_a, linear_b), \
     quadratic(x) title sprintf('$%.2f %+.2fx %+.2fx^2$', quadratic_a, quadratic_b, quadratic_c), \
     power(x) title sprintf('$%.2f %+.2fx^{%.2f}$', power_a, power_b, power_c)

# TODO export fit data?
# TODO display r² or something similar?
