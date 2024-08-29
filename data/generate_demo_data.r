# Generates broad purpose demo data for explaining tidyverse and statistics

# whether watching a movie about journalism can affect trust in journalists.
# - Two repeated measures: trust before and after the intervention
# - Three groups: control, positive about journalism, negative about journalism 
# - Other variables: age, newspaper subscription, news consumption

library(sjPlot)
library(tidyverse)
set.seed(1)

# number of participants. Make sure to use multiple of 3 for equal distribution of groups
n <- 600

# simulate age
age <- round(runif(n, 18, 65))

# assign groups in repetitions to ensure equal distribution (data is random anyway)
experiment_group <- rep(1:3, length.out=n) |> factor(labels = c("control", "negative", "positive"))

# simulate subscription to have likelihood increase with age, using a logistic function
subscription_odds <- 1 / (1 + exp(-0.06*age + 2))
np_subscription <- rbinom(n, 1, subscription_odds)

subscription_prob = subscription_odds / (1 + subscription_odds)
# plot(age ~ as.factor(np_subscription))

# create variable for average hours of news consumption per week, and make it so that it's higher for people with
# newspaper subscription, but people without subscription have higher variance (for showing levene's test)
news_consumption <- rnorm(n, mean = 8 + np_subscription*4, sd = 3 - np_subscription*1.5)
news_consumption[news_consumption < 0] <- 0
news_consumption = round(news_consumption)
# plot(news_consumption ~ as.factor(np_subscription))

# simulate trust_t1 to increase slightly with age. Force 10 pt scale
trust_t1 <- rnorm(n, mean = 3 + 0.05 * age, sd = 1)
trust_t1[trust_t1 < 1] <- 1
trust_t1[trust_t1 > 10] <- 10
# plot(age, trust_t1)


# simulate trust_t2 to:
# - be based on trust_t1
# - be lower in the negative group compared to the neutral group
# - be slightly higher, but not significantly, in the positive group compared to the neutral group
# - make the negative effect weaker for those who are subscribed to the newspaper
# - force 10 pt scale
trust_t2 <- trust_t1 + 
  (experiment_group == "positive") * 0.4 +
  (experiment_group == "negative") * (!np_subscription) * -1.6+
  (experiment_group == "negative") * np_subscription * -0.3 +
  rnorm(n, mean = 0, sd = 1)
trust_t2[trust_t2 < 1] <- 1
trust_t2[trust_t2 > 10] <- 10
# plot(trust_t2 ~ experiment_group)

# create tibble and randomize order
d = tibble(
    age = age,
    np_subscription = factor(np_subscription, labels = c("no", "yes")),
    news_consumption = news_consumption,
    experiment_group = experiment_group,
    trust_t1 = trust_t1,
    trust_t2 = trust_t2
)
d = d[sample(nrow(d)),]
d$id = 1:nrow(d)


function() {
  ### Testing some basic stats

  # T-TEST: we can demonstrate independent samples t-test with np_subscription.
  # variances equal
  car::leveneTest(trust_t1 ~ np_subscription, data = d)
  t.test(trust_t1 ~ np_subscription, var.equal=TRUE, data = d)
  plot(trust_t1 ~ np_subscription, data = d)

  # variances not equal
  car::leveneTest(news_consumption ~ np_subscription, data = d)
  t.test(age ~ np_subscription, var.equal=FALSE, data = d)
  plot(age ~ np_subscription, data = d)

  # ANOVA
  aov(trust_t2 ~ experiment_group, data = d) |> summary()
  plot(trust_t2 ~ experiment_group, data = d)

  # Regression with interaction
  m = lm(trust_t2 ~ experiment_group * np_subscription, data = d)
  plot_model(m, type = "pred", terms = c("experiment_group", "np_subscription"), show.values = TRUE)

  dl <- d |> 
    pivot_longer(cols = c(trust_t1, trust_t2), names_to = "time", values_to = "trust") |>
    mutate(time = ifelse(time == "trust_t1", "t1", "t2"))

  ggplot(dl, aes(x = age, y = trust, color = experiment_group)) +
    geom_point() +
    geom_smooth(method = "lm", se = FALSE) +
    facet_wrap(~time)
}

## adding some missing values and noise, and then saving

# Some people entered age as birthyear, and one person is too young
ds = d
i = sample(1:n, 4)
## we need the specific birthyears to be deterministic for the tutorials
ds$age[i] = c(1987, 1970, 1967, 17)

# some people didnnt enter age
ds$age[sample(1:n, 5)] = NA

# adding a stupid space in news_consumption
colnames(ds)[colnames(ds) == "news_consumption"] = "news consumption"

write_csv(ds, "data/fake_demo_data.csv")

