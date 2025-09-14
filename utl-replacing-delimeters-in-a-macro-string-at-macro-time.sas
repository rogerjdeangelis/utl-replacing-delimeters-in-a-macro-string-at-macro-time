%let pgm=utl-replacing-delimeters-in-a-macro-string-at-macro-time;

%stop_submission;

Replacing delimeters in a macro string at macro time

 THREE SOLUTIONS (all at macro time)

     1 least klingon (%sysfunc,%quote,&,%str,%str)
       Perhaps we should move away from nested macro operations?

     2 Ted Clay arrays (just 2 satements)

     3 all macro
       Kurt Bresmer
       https://communities.sas.com/t5/user/viewprofilepage/user-id/11562

github
https://tinyurl.com/4wetareu
https://github.com/rogerjdeangelis/utl-replacing-delimeters-in-a-macro-string-at-macro-time

communities.sas
https://tinyurl.com/37bhyv66
https://communities.sas.com/t5/New-SAS-User/extract-each-value-before-a-key-word/m-p/727349#M28192


INPUT
=====
%let meta_Col=businessDataName,reportingArea,reportingDate,reportingPurpose;

1 LEAST KLINGON (%sysfunc,%quote,&,%str,%str)
==============================================

/*-- runs at macro time --*/
%put %dosubl(%nrstr(
  data _null_;
    retain txt "&meta_col";
    res=tranwrd(txt,',',',meta.');
    call symputx('new_col',cats('meta.',res));
  run;quit;)
  ) &new_col;

NEW_COL resolves to meta.businessDataName,meta.reportingArea,meta.reportingDate,meta.reportingPurpose

2 TED CLAY ARRAYS
=================

%array(_m,values=&meta_col);
%put %do_over(_m,phrase=meta.?,delim=%str(,),between=comma);

meta.businessDataName , meta.reportingArea , meta.reportingDate , meta.reportingPurpose

3 ALL MACRO (kLINGON?)
=======================

%put meta.%sysfunc(tranwrd(%quote(&meta_col),%str(,),%str(,meta.)));


RELATED REPOS
=============

https://github.com/rogerjdeangelis/utl-avoiding-klingon-macro-triggers-at-macro-execution-time
https://github.com/rogerjdeangelis/utl-macro-klingon-solution-or-simple-dosubl-you-decide
https://github.com/rogerjdeangelis/utl-using-dosubl-to-avoid-klingon-obsucated-macro-coding
https://github.com/rogerjdeangelis/utl_using_dosubl_to_avoid_klingon_macro_quoting_functions
/*              _
  ___ _ __   __| |
 / _ \ `_ \ / _` |
|  __/ | | | (_| |
 \___|_| |_|\__,_|

*/
