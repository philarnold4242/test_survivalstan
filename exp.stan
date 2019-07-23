data {
  // dimensions
  int<lower=0> N;             // number of observations
  
  // observations
  vector[N] y;                // time for observation n
  vector[N] event;            // event status (1:event, 0:censor) for obs n
}

parameters {
  real<lower=0> alpha;
}

model {
  // priors
  target += normal_lpdf(alpha | 0.0, 1.0);

  // likelihood
  for (n in 1:N) {
      if (event[n]==1)
          target += exponential_lpdf(y[n] | alpha);
      else
          target += exponential_lccdf(y[n] | alpha);
  }
}
