clear
/* Part 1 */
import delimited "D:\Econometrics Project\yelp_dataset_challenge_academic_dataset\506788.csv"

/* Part 2 */
gen charlotte = strpos(station_name, "SC US") > 0 | ///
strpos(station_name, "NC US") > 0
gen pittsburgh = strpos(station_name, "PA US") > 0
gen madison = strpos(station_name, "WI US") > 0
gen urbana_champaign = strpos(station_name, "IL US") > 0

drop station station_name psun tsun awnd wsf* fmtm pgtm wt19 tobs
drop if snow == -9999 | snwd == -9999 | tmax == -9999 | tmin == -9999
drop if prcp < 0
foreach x of varlist wt* {
  replace `x' = 0 if `x' == -9999
}

save "D:\Econometrics Project\jem177_project\wx_master.dta", replace

drop if charlotte == 0
collapse prcp s* t* wt* charlotte pittsburgh madison urbana_champaign, by(date)
save "D:\Econometrics Project\jem177_project\wx_charlotte.dta", replace

use "D:\Econometrics Project\jem177_project\wx_master.dta", clear
drop if pittsburgh == 0
collapse prcp s* t* wt* charlotte pittsburgh madison urbana_champaign, by(date)
save "D:\Econometrics Project\jem177_project\wx_pittsburgh.dta", replace

use "D:\Econometrics Project\jem177_project\wx_master.dta", clear
drop if madison == 0
collapse prcp s* t* wt* charlotte pittsburgh madison urbana_champaign, by(date)
save "D:\Econometrics Project\jem177_project\wx_madison.dta", replace

use "D:\Econometrics Project\jem177_project\wx_master.dta", clear
drop if urbana_champaign == 0
collapse prcp s* t* wt* charlotte pittsburgh madison urbana_champaign, by(date)
save "D:\Econometrics Project\jem177_project\wx_urbana_champaign.dta", replace

merge 1:1 date prcp s* t* w* charlotte pittsburgh madison urbana_champaign ///
using "D:\Econometrics Project\jem177_project\wx_charlotte.dta"
drop _merge
merge 1:1 date prcp s* t* w* charlotte pittsburgh madison urbana_champaign ///
using "D:\Econometrics Project\jem177_project\wx_pittsburgh.dta"
drop _merge
merge 1:1 date prcp s* t* w* charlotte pittsburgh madison urbana_champaign ///
using "D:\Econometrics Project\jem177_project\wx_madison.dta"
drop _merge

rename wt09 blowing_snow
rename wt14 drizzle
rename wt07 dust_ash
rename wt01 fog_all
rename wt15 drizzle_freezing
rename wt17 rain_freezing
rename wt06 glaze
rename wt21 fog_ground
rename wt05 hail
rename wt02 fog_heavy
rename wt11 wind_high
rename wt22 fog_ice
rename wt04 hail_small_sleet
rename wt13 mist
rename wt16 rain_all
rename wt08 smoke_haze
rename wt18 snowing
rename wt03 thunder
foreach x of var * { 
  rename `x' wx_`x' 
}
rename wx_date date
rename wx_charlotte charlotte
rename wx_pittsburgh pittsburgh
rename wx_madison madison
rename wx_urbana_champaign urbana_champaign

save "D:\Econometrics Project\jem177_project\wx_master.dta", replace
