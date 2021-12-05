log using part1.log
*Importing .csv file
import delimited "C:\Users\HP\Desktop\coding_challenge\Part 1\New Variables.csv"
describe
rename base_educ educ
merge 1:1 uniqueid using "C:\Users\HP\Desktop\coding_challenge\Part 1\Main Dataset.dta", force
*Merge the new observations
append using "C:\Users\HP\Desktop\coding_challenge\Part 1\New Observations.dta", force
*New onservations are added and the two datasets are merged.
*Average and median values of time spent surveying, considering only completed 
sum surveytime if survey_complete == 1
sum surveytime if survey_complete == 1, d
*Mean seconds is 7206.8 and Median is 7171 seconds
 *Average length of time spent surveying for this surveyor
tab surveyor
egen avgagemf=mean( surveytime ) if survey_complete == 1, by(surveyor)
tab avgagemf
*There are no signifincant observable differences between the surveyors.
*Checking the uniqueness of our ID variables (hhid)
describe hhid
duplicates report hhid
duplicates list hhid
*Removing duplicate values
duplicates drop hhid, force
duplicates report hhid
*Create histograms and overlay them with k-density plots
histogram income, frequency
twoway (kdensity income) (histogram income), name(k1,replace)
histogram surveytime, frequency
twoway (kdensity surveytime ) (histogram surveytime ), name(k2,replace)
*Removing personally identifiable information (PII)
replace surveyor = "1" if surveyor == "Anna"
tab surveyor
replace surveyor = "2" if surveyor == "Benjamin"
replace surveyor = "3" if surveyor == "Caroline"
replace surveyor = "4" if surveyor == "David"
replace surveyor = "5" if surveyor == "Grace"
replace surveyor = "6" if surveyor == "Jane"
replace surveyor = "7" if surveyor == "Joseph"
replace surveyor = "8" if surveyor == "Mary"
replace surveyor = "9" if surveyor == "Peter"
replace surveyor = "10" if surveyor == "John"
replace surveyor = "11" if surveyor == "Sam"
tab surveyor
*recode missing values.
mvdecode burglaryyn vandalismyn trespassingyn, mv(-999)
mvdecode burglaryyn vandalismyn trespassingyn, mv(-997)
log close
save "C:\Users\HP\Downloads\Part1.dta"
