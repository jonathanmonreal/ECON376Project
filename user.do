clear

/* Part 1 */
import delimited ///
"D:\Econometrics Project\yelp_dataset_challenge_academic_dataset\yelp_academic_dataset_user.csv", clear

/* Part 2 */
drop type

foreach x of var * { 
  rename `x' user_`x' 
}
rename user_user_id user_id

save "D:\Econometrics Project\jem177_project\user.dta", replace
