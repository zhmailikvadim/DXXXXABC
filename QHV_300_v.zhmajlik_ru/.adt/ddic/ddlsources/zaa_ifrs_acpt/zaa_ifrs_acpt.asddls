@EndUserText.label: 'Признается по МСФО'
@ClientHandling.type: #CLIENT_DEPENDENT

define table function zaa_ifrs_acpt
returns {
  client : abap.clnt;
  bukrs  : bukrs;
  anln1  : anln1;
  anln2  : anln2;
  ifrs_x : char1;
  adatu  : budat;
  bwasl  : bwasl;
  bwatxt : bwatxt;
  storno : char1;
  }
implemented by method zaa_utils_hdb=>get_ifrs_acpt ;