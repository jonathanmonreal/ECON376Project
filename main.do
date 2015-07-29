log using "D:\Econometrics Project\jem177_project\log.txt", replace

/* See the relevant files for parts 1 & 2: */
do "D:\Econometrics Project\jem177_project\wx.do"
do "D:\Econometrics Project\jem177_project\user.do"
do "D:\Econometrics Project\jem177_project\business.do"
do "D:\Econometrics Project\jem177_project\review.do"

/* Part 1 */
merge m:m business_id using "D:\Econometrics Project\jem177_project\business.dta"
drop _merge
drop if business_id == ""
drop if (missing(charlotte) & missing(pittsburgh) & missing(madison) & ///
missing(urbana_champaign))
merge m:m user_id using "D:\Econometrics Project\jem177_project\user.dta"
drop _merge
destring, replace
merge m:m date charlotte pittsburgh madison urbana_champaign using ///
"D:\Econometrics Project\jem177_project\wx_master.dta"
save "D:\Econometrics Project\jem177_project\projectdata.dta", replace
drop _merge
drop if business_id == ""
drop if review_id == ""
drop if missing(wx_prcp)
drop if missing(user_review_count)

/* Part 2 */
tostring(date), replace
rename date date_string
gen date = date(date_string, "YMD")
gen month = month(date)
gen monthly = mofd(date)
gen day_of_week = dow(date)
gen restaurant = strpos(business_categories, "Restaurant") > 0
gen logstars = ln(stars)

/* Part 3 */
summarize logstars wx_prcp votescool votesfunny votesuseful business_stars ///
business_review_count charlotte pittsburgh madison user_review_count wx_snwd ///
wx_snow wx_tmax wx_tmin day_of_week monthly

/* Part 4 */
reg logstars wx_prcp votescool votesfunny votesuseful business_stars ///
business_review_count charlotte pittsburgh madison user_review_count wx_tmax ///
wx_tmin day_of_week monthly if (wx_snwd == 0 & wx_snow == 0 & ///
wx_fog_all == 0& wx_hail == 0 & wx_wind_high == 0)

/* Estimated equation:
log(stars)=.8563157 + .0000121wx_prcp + .1141412votescool - .058534votesfunny - 
           (.0551607) (.000027)         (.002039)           (.0018418)
          .0517213votesuseful + .3277315business_stars + 
		  (.0012579)            (.0021537)
		  .0000749business_review_count - .0200394charlotte - .0231518pittsburgh -
		  (9.48e-06)                      (.0370205)          (.0370515)
		  .0240416madison + .000042user_review_count  - .0000124wx_tmax +
		  (.0371135)        (3.81e-06)                  (.0000424)
		  8.52e-06wx_tmin + .0002983day_of_week - .0012905monthly 
		  (.0000431)        (.0006354)            (.00007)

The coefficient on the main variable wx_prcp means that for each tenth of a
millimeter of rain, the number of stars increases by 00.00121%. It is clearly
not statistically significant with t=0.45. */

save "D:\Econometrics Project\jem177_project\projectdata.dta", replace

log close
