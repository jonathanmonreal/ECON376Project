clear

/* Part 1 */
import delimited ///
"D:\Econometrics Project\yelp_dataset_challenge_academic_dataset\yelp_academic_dataset_review.modified.csv", ///
varnames(1) clear

/* Part 2 */
drop v9-v12
replace date = subinstr(date, "-", "",.)
save "D:\Econometrics Project\jem177_project\review.dta", replace
