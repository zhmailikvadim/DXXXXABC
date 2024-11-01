@EndUserText.label: 'ZT_CPI_FIAA_00'
define table function ZT_CPI_FIAA_00
with parameters 
@Environment.systemField: #CLIENT
                p_clnt   : abap.clnt,  
                P_date   : dats,
                P_period : poper,
                P_year   : gjahr,
                p_bukrs_low  : bukrs,      // AK_GUBAREVICH #36910 Работы по параметризации источников данных 
                p_bukrs_high : bukrs       // AK_GUBAREVICH #36910 Работы по параметризации источников данных           
returns {

  mandt       : abap.clnt;
  bukrs       : bukrs;
  anln1       : anln1;
  anln2       : anln2; 
  afabe       : afabe_d;
  belnr       : belnr_d; 
  slalittype  : slalittype; 
  name        : rvari_vnam;
  anbwa       : anbwa;
  budat       : budat; 
  kansw       : abap.dec( 16, 2 );
  knafa       : abap.dec( 16, 2 );
  kaafa       : abap.dec( 16, 2 );
  kansw_infl  : abap.dec( 16, 2 );
  knafa_infl  : abap.dec( 16, 2 ); 
  kaafa_infl  : abap.dec( 16, 2 );
  ksafa       : abap.dec( 16, 2 );
  ksafa_infl  : abap.dec( 16, 2 );
  fiscyearper : fis_jahrper;
  cpi_fiaa    : abap.fltp;
  hsl         : abap.fltp; 
  xreversing  : fins_xreversing;
  xreversed   : fins_xreversed;
  
}

implemented by method ZCL_FI_IFRS_CPI=>ZT_CPI_FIAA_00;