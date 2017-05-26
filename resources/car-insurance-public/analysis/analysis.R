library(dplyr)
library(readr)
library(ggplot2)
library(tidyr)
library(tibble)
library(broom)
library(mgcv)
library(knitr)
library(pander)
library(pixiedust)

# our data
ca <- read_csv("../data/ca-per-zip.csv")
il <- read_csv("../data/il-per-zip.csv")
chicago <- il %>% filter(chicago == TRUE)
mo <- read_csv("../data/mo-per-zip.csv")
tx <- read_csv("../data/tx-per-zip.csv")

# define our functions
plot_graph <- function(data, title) {
  p <- ggplot(data, aes(state_risk, bi_policy_premium + pd_policy_premium, color=ifelse(minority, "Minority", "White"))) + 
    geom_point(size=0.1, alpha=0.5) + 
    geom_smooth(method="gam", method.args = list(family = "gaussian"), formula=y~s(x)) + 
    ggtitle(title) +
    xlab("State Risk") +
    ylab("Liability Premium") +
    labs(color="") +
    theme_minimal() +
    facet_wrap(~ companies_name, ncol=6, scales="free_y", labeller = label_wrap_gen(multi_line=TRUE))
  return(p)
}

make_ratios <- function(data, path, threshhold) {
  results <- data %>% group_by(companies_name) %>% do({
    minorities <- filter(., minority==TRUE)
    whites <- filter(., minority==FALSE)
    minority_fit <- gam(I(pd_policy_premium + bi_policy_premium) ~ s(state_risk), family="gaussian", data=minorities)
    white_fit <- gam(I(pd_policy_premium + bi_policy_premium) ~ s(state_risk), family="gaussian", data=whites)
    out <- select(., name, minority, zipcode, 
                  bi_policy_premium, pd_policy_premium, state_risk, white_non_hisp_pct)
    out <- add_column(out, white_premium=predict(white_fit, .))
    out <- add_column(out, minority_premium=predict(minority_fit, .))
    out <- add_column(out, ratio=out$minority_premium / out$white_premium)
    out <- add_column(out, minority_pct=(100-out$white_non_hisp_pct))
    out
  })
  
  minority_avg <- filter(results, state_risk > threshhold) %>% 
    filter(minority==TRUE) %>% 
    group_by(name, companies_name) %>% 
    summarise(minority_premium=mean(minority_premium))
  
  avg <- filter(results, state_risk > threshhold) %>% 
    filter(minority==FALSE) %>% 
    group_by(name, companies_name) %>% 
    summarise(premium=mean(white_premium))
  joined <- merge(minority_avg, avg)
  joined$ratio <- joined$minority_premium / avg$premium
  write_csv(joined, path)
  return(joined)
}

run_diagnostics <- function(data, path) {
  data %>% group_by(companies_name) %>% do({
    minorities <- filter(., minority==TRUE)
    whites <- filter(., minority==FALSE)
    minority_fit <- gam(I(pd_policy_premium + bi_policy_premium) ~ s(state_risk), family="gaussian", data=minorities)
    white_fit <- gam(I(pd_policy_premium + bi_policy_premium) ~ s(state_risk), family="gaussian", data=whites)
    out <- data_frame(name=.[1,]$name, companies_name=.[1,]$companies_name, 
                      minority=TRUE,
                      rsq=round(summary(minority_fit)$r.sq, 3), 
                      pvalue=pvalString(summary(minority_fit)$s.pv[1]))
    out <- rbind(out, data_frame(name=.[1,]$name, companies_name=.[1,]$companies_name, 
                                 minority=FALSE,
                                 rsq=round(summary(white_fit)$r.sq, 3), 
                                 pvalue=pvalString(summary(white_fit)$s.pv[1])))
    out
  }) %>% arrange(name, companies_name) %>%
    select("Name"=name, "Company Name"=companies_name, 
           "Minority Model"=minority, "P Value of the State Risk Term"=pvalue, 
           "R Squared"=rsq)
}

ca_ratios <- make_ratios(ca, "../data/results/ca-ratios.csv", 250)
il_ratios <- make_ratios(il, "../data/results/il-ratios.csv", 200)
ch_ratios <- make_ratios(chicago, "../data/results/chicago-ratios.csv", 200)
mo_ratios <- make_ratios(mo, "../data/results/mo-ratios.csv", 250)
tx_ratios <- make_ratios(tx, "../data/results/tx-ratios.csv", 250)

companies <- il_ratios %>% mutate(state="IL")
companies <- rbind(companies, ch_ratios %>% mutate(state="Chicago, IL"))
companies <- rbind(companies, mo_ratios %>% mutate(state="MO"))
companies <- rbind(companies, tx_ratios %>% mutate(state="TX"))
companies <- rbind(companies, ca_ratios %>% mutate(state="CA"))

write_csv(unique(companies %>% select(name, companies_name)), "../data/results/companies.csv")

ca_diagnostics <- run_diagnostics(ca, "./data/results/ca-diagnostics.csv")
mo_diagnostics <- run_diagnostics(mo, "./data/results/mo-diagnostics.csv")
il_diagnostics <- run_diagnostics(il, "./data/results/il-diagnostics.csv")
ch_diagnostics <- run_diagnostics(chicago, "./data/results/ch-diagnostics.csv")
tx_diagnostics <- run_diagnostics(tx, "./data/results/tx-diagnostics.csv")

# Nationwide

dfnw <- ca %>% filter(companies_name=="Allied Prop & Cas Ins Co")
nationwide_bi_loss <- read_csv("../data/company-internal/nwpc-internal-bodily-injury.csv")
nationwide_pd_loss <- read_csv("../data/company-internal/nwpc-internal-property-damage.csv")
dfnw <- merge(dfnw, nationwide_bi_loss)
dfnw <- merge(dfnw, nationwide_pd_loss)
dfnw <- mutate(dfnw, nw_risk=nw_bi_frequency*nw_bi_severity + nw_pd_frequency*nw_pd_severity)
dfnw <- mutate(dfnw, state_risk=nw_bi_manual_frequency*nw_bi_manual_severity+nw_pd_manual_frequency*nw_pd_manual_severity)
nw_cor <- cor.test(dfnw$nw_risk, dfnw$state_risk)
nw <- filter(dfnw, nw_risk <= 400 & nw_risk > 25)

# Swap variables to reuse the analysis routine above
tmp <- nw$state_risk
nw$state_risk <- nw$nw_risk
nw_ratio <- make_ratios(nw, "../data/results/nw-ratio.csv", 250)
nw$state_risk <- tmp