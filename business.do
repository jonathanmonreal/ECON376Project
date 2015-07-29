clear

/* Part 1 */
insheet using ///
"D:\Econometrics Project\yelp_dataset_challenge_academic_dataset\yelp_academic_dataset_business.csv", clear

/* Part 2 */
gen charlotte = (city == "Charlotte")
gen pittsburgh = (city == "Pittsburgh")
gen madison = (city == "Madison")
gen urbana_champaign = (city == "Urbana" | city == "Champaign")

drop hours* neighborhoods latitude longitude full_address ///
attributesambiencedivey attributesdietaryrestrictionsveg attributeshappyhour ///
attributeshairtypesspecializedin v7 attributesambienceclassy ///
attributespaymenttypesmastercard attributescorkage attributesgoodforbrunch ///
attributespaymenttypesamex name attributesambiencehipster ///
attributesbyobcorkage v29 attributesmusiclive ///
attributesdietaryrestrictionsdai attributesmusicbackground_music ///
attributesgoodfordinner attributesgoodforbreakfast attributesmusickaraoke ///
attributesgoodfordancing attributesacceptscreditcards attributesgoodforlunch ///
attributespaymenttypescash_only attributesmusicvideo ///
attributesdietaryrestrictionshal attributesagesallowed ///
attributesgoodfordessert attributesambiencetrendy ///
attributespaymenttypesdiscover attributeswheelchairaccessible ///
attributesdietaryrestrictionsglu attributespaymenttypesvisa type ///
attributescaters attributesambienceintimate attributesmusicplaylist ///
attributesgoodforlatenight v77 v80 attributesparkingvalidated ///
attributesacceptsinsurance attributesdietaryrestrictionssoy ///
attributesambiencecasual attributesbyappointmentonly ///
attributesdietaryrestrictionskos attributesdogsallowed attributessmoking ///
v98 attributesgoodforgroups attributesambienceromantic v103 ///
attributesmusicjukebox attributesambienceupscale attributesbyob v39 state ///
v49 open v93
drop if (charlotte == 0 & pittsburgh == 0 & madison == 0  & ///
urbana_champaign == 0)

rename attributespricerange pricerange
rename attributesorderatcounter counterserv
rename attributesoutdoorseating outdoorseat
rename attributesambiencetouristy touristy
rename attributestakesreservations reservations

foreach x of var attributes* { 
  replace `x' = "1" if `x' == "True"
  replace `x' = "0" if `x' == "False"
  replace `x' = "1" if `x' == "yes"
  replace `x' = "0" if `x' == "no"
}
foreach x of var * { 
  rename `x' business_`x' 
}
rename business_business_id business_id
rename business_charlotte charlotte
rename business_pittsburgh pittsburgh
rename business_madison madison
rename business_urbana_champaign urbana_champaign

save "D:\Econometrics Project\jem177_project\business.dta", replace
