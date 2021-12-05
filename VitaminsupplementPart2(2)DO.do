log using vitaminsupplement.log
use "C:\Users\HP\Desktop\coding_challenge\Part 2\B\vitamins.dta"
describe
*transforming the completion time recorded in MM.SS format to Normal time format
gen floor = floor(time)
gen remaining_seconds = 100*(time - floor)
*minutes and seconds are segregated now. Further, transforming minutes in seconds and adding respectively would give us time in normal (seconds) format.
replace floor = floor * 60
gen total_seconds = floor + remaining_seconds
*for ease we will drop the redundant variables like time and others.
drop time floor remaining_seconds
describe
*We now want to ascertain the impact of treatment i.e. vitamin supplements on the ability to solve math problems fast. We can do this with a simple linear regression.
regress total_seconds treat
ttest total_seconds, by(treat)
*Reconciling the strange supplements
tab supplement
replace supplement = proper(supplement)
tab supplement
drop if supplement == "N" | supplement == "2" | supplement == "3" | supplement == "R"
tab supplement
tab supplement
sort treat
replace supplement = "b" in 262
replace supplement = "B" in 262
replace supplement = "B" in 268
replace supplement = "B" in 277
replace supplement = "B" in 293
replace supplement = "B" in 328
replace supplement = "B" in 352
replace supplement = "B" in 367
replace supplement = "B" in 377
replace supplement = "B" in 399
replace supplement = "B" in 425
replace supplement = "B" in 429
replace supplement = "B" in 475
tab supplement
egen avgagemf=mean( total_seconds ), by( supplement )
tab avgagemf
*Comparing the means, we can say that supplement A is better because the average time is lowest for those who took this supplement.
rename treat treatment
rename avgagemf averagemean
rename supplement treatmenttype
log close
save "C:\Users\HP\Downloads\Vaccinefinalpart2(2).dta"
