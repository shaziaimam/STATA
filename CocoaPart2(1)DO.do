log using cocoa1.log
*Merging Data
merge m:1 farmer_id using "C:\Users\HP\Desktop\coding_challenge\Part 2\A\income.dta"
drop _merge 
merge m:1 crop_id using "C:\Users\HP\Desktop\coding_challenge\Part 2\A\mkt_prices.dta", force
drop _merge 
*Checking if growing cocoa is profitable
mvdecode crop_id plotsize income mkt_price mkt_price, mv(-99)
mvdecode sale_amt, mv(-99)
bys farmer_id: egen total_acre = sum(plotsize)
describe
corr income sale_amt
corr income sale_amt if crop_name == "cocoa"
pwcorr income sale_amt, star(0.05)sig
pwcorr income sale_amt if crop_name == "cocoa", star(0.05)sig
 gen revenue = mkt_price* sale_amt
 gen revsquash = income - revenue
gen price = revsquash/ sale_amt
drop revsquash 
drop price 
save "C:\Users\HP\Desktop\coding_challenge\Part 2\A\CocoaPart2(1).dta"
log close
