/*IMPORT DATA*/

/*UPDATE THE DATAFILE= LINE WITH THE LOCATION AND NAME OF YOUR DATA FILE*/

PROC IMPORT OUT= WORK.harass17
            /*DATAFILE= "C:\Users\jpattershall\Desktop\Online Harassment - Samsara Counts\Samsara data update var names.xlsx"*/
			DATAFILE= "C:\Users\libguest225\Documents\My SAS Files\Samsara_data_update_var_names"
            DBMS=EXCEL REPLACE;
     RANGE="Sheet_1$"; 
     GETNAMES=YES;
     MIXED=NO;
     SCANTEXT=YES;
     USEDATE=YES;
     SCANTIME=YES;
RUN;


/*LIST VARIABLES*/

PROC CONTENTS DATA=HARASS17;
RUN;


/*RECODE RACE*/

DATA HARASS17;
	SET HARASS17;

		IF OTHER_RACE NE ' ' THEN OTHER_RACE_SUM=1;
		IF WHITE NE ' ' THEN WHITE_SUM=1;
		IF AMERICAN_INDIAN_ALASKAN NE ' ' THEN AMER_INDIAN_ALASKAN_SUM=1;
		IF ASIAN NE ' ' THEN ASIAN_SUM=1;
		IF BLACK_OR_AFRICAN_AMERICAN NE ' ' THEN BLACK_SUM=1;
		IF HAWAIIAN_PACIFIC_ISLANDER NE ' ' THEN HAWAIIAN_PACIFIC_SUM=1;

		RACE_SUM=SUM(OTHER_RACE_SUM, WHITE_SUM, AMER_INDIAN_ALASKAN_SUM, ASIAN_SUM, BLACK_SUM, HAWAIIAN_PACIFIC_SUM);
RUN;

DATA HARASS17;
	SET HARASS17;
		IF CITIZENSHIP='International/Foreign' THEN RACE='International/Foreign                                       ';
		ELSE IF HISPANIC='Yes' THEN RACE='Hispanic/Latino';
		ELSE IF RACE_SUM > 1 THEN RACE='Two or more races';
		ELSE IF AMERICAN_INDIAN_ALASKAN NE ' ' THEN RACE='American Indian or Alaskan Native';
		ELSE IF ASIAN NE ' ' THEN RACE='Asian';
		ELSE IF BLACK_OR_AFRICAN_AMERICAN NE ' ' THEN RACE='Black or African American';
		ELSE IF HAWAIIAN_PACIFIC_ISLANDER NE ' ' THEN RACE='Native Hawaiian or Other Pacific Islander';
		ELSE IF WHITE NE ' ' THEN RACE='White';
		ELSE IF OTHER_RACE NE ' ' THEN RACE='Other';
RUN;

DATA HARASS17;
	SET HARASS17;
		IF RACE='White' THEN RACE_COMBINE='White';
		ELSE IF RACE=' ' THEN RACE_COMBINE=' ';
		ELSE RACE_COMBINE='International/Minority';
RUN;


proc freq;
table race;
run;


proc freq;
table gender;
run;


proc freq;
table RACE_COMBINE;
run;



/*INITIAL FREQUENCIES WITH CHI SQUARE TEST*/

proc freq data=harass17;
table Personal_harassed_sustained_peri*gender / missing chisq;
run;

proc freq data=harass17;
table Personal_harassed_sustained_peri*RACE_COMBINE / missing chisq;
run;

proc freq data=harass17;
table Any_online_sexually_harassed*gender / missing chisq;
run;

proc freq data=harass17;
table GW_related_sexually_harassed*gender / missing chisq;
run;

proc freq data=harass17;
table GW_related_stalked*gender / missing chisq;
run;

proc freq data=harass17;
table Online_gaming_men_v_women*gender / chisq ;
run;

proc freq data=harass17;
table Social_network_men_v_women*gender /  chisq;
run;

proc freq data=harass17;
table Any_online_offensive_names*RACE_COMBINE / missing chisq;
run;



proc freq data=harass17;
table Personal_none_of_these / missing ;
run;


/*

THESE ARE PREPARED LINES FOR OTHER PROC FREQ STATEMENTS; MAY NEED TO ADD MISSING DEPENDING ON VARIABLE

table Any_online_not_witnessed_any*gender / chisq;
table Any_online_offensive_names*gender / chisq;
table Any_online_other*gender / chisq;
table Any_online_physically_threatened*gender / chisq;
table Any_online_purposely_embarrass*gender / chisq;
table Any_online_sexually_harassed*gender / chisq;
table Any_online_stalked*gender / chisq;
table Comment_sections_men_v_women*gender / chisq;
table Discussion_sites_Reddit_men_v_wo*gender / chisq;
table Follow_GW_online_sources*gender / chisq;
table GW_related_dimished_mocked*gender / chisq;
table GW_related_harassed_sustained_pe*gender / chisq;
table GW_related_not_witnessed_any*gender / chisq;
table GW_related_offensive_names*gender / chisq;
table GW_related_other*gender / chisq;
table GW_related_physically_threatened*gender / chisq;
table GW_related_purposely_embarrass*gender / chisq;
table GW_related_sexually_harassed*gender / chisq;
table GW_related_stalked*gender / chisq;
table How_often_post_social_media*gender / chisq;
table Hurt_reputation*gender / chisq;
table Ignoring_effective*gender / chisq;
table Make_info_available_online*gender / chisq;
table Messaging_apps_men_v_women*gender / chisq;
table Online_dating_men_v_women*gender / chisq;
table Online_environment_of_harassment*gender / chisq;
table Online_gaming_men_v_women*gender / chisq;
table Online_more_anonymous*gender / chisq;
table Online_more_critical*gender / chisq;
table Online_more_supportive*gender / chisq;
table Person_involved_acquaintance*gender / chisq;
table Person_involved_classmate*gender / chisq;
table Person_involved_coworker*gender / chisq;
table Person_involved_do_not_know_iden*gender / chisq;
table Person_involved_family_member*gender / chisq;
table Person_involved_friend*gender / chisq;
table Person_involved_romantic*gender / chisq;
table Person_involved_roommate*gender / chisq;
table Person_involved_same_university_*gender / chisq;
table Person_involved_stranger*gender / chisq;
table Personal_diminished_mocked*gender / chisq;
table Personal_harassed_sustained_peri*gender / chisq;
table Personal_how_upsetting*gender / chisq;
table Personal_none_of_these*gender / chisq;
table Personal_offensive_names*gender / chisq;
table Personal_other*gender / chisq;
table Personal_physically_threatened*gender / chisq;
table Personal_purposely_embarrass*gender / chisq;
table Personal_sexually_harassed*gender / chisq;
table Personal_stalked*gender / chisq;
table Personal_when_occurred*gender / chisq;
table Personal_which_online_environmen*gender / chisq;
table Prof_network_account*gender / chisq;
table Respond_or_ignore*gender / chisq;
table Social_network_account*gender / chisq;
table Social_network_men_v_women*gender / chisq;
table Steps_taken_effective*gender / chisq;
table When_more_recent_occurred*gender / chisq;


*/
