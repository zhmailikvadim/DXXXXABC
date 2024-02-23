@EndUserText.label: 'Table Function to return next "working day" dates'
@ClientHandling.type: #CLIENT_INDEPENDENT
define table function ZFI_NEXT_WORKINGDAYS_TF
  with parameters
    pbudat : dats
returns
{
  rdate     : abap.dats;
  r_newdate : abap.dats;
  rident    : abap.sstring( 2 );
  rexec     : abap.int2;
}
implemented by method
  zcl_fi_next_workdays=>get_workingday_dates;