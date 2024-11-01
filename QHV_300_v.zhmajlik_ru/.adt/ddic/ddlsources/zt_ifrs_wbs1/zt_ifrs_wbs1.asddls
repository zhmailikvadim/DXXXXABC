@EndUserText.label: 'ZT_IFRS_WBS1'
define table function ZT_IFRS_WBS1
with parameters 
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,  
    p_period: fis_jahrper,
    p_bukrs_low  : bukrs,      // AK_GUBAREVICH #36910 Работы по параметризации источников данных 
    p_bukrs_high : bukrs       // AK_GUBAREVICH #36910 Работы по параметризации источников данных     
      
returns  
  
{
  mandt            : abap.clnt;      -- Мандант
  belnr            : belnr_d;        -- Номер бухгалтерского документа
  bldat            : bldat;          -- Дата документа
  docln            : docln6;         -- Строка проводки по регистру, 6 знаков
  racct            : racct;          -- Номер счета
  gkont            : gkont; 
  gkont1           : gkont;
  gjahr            : gjahr;
  ktopl            : ktopl;         -- № корресп. счета
  co_belnr         : co_belnr;       -- № документа
  rbukrs           : bukrs;          -- Балансовая единица
  ps_posid         : ps_posid;
  pps_posid        : fco_par_posid;
  parob1           : parob1;
  objnr            : j_objnr;        -- Номер объекта
  afabe            : afaber;
  drcrk            : shkzg;
  hsl              : abap.fltp;      -- Сумма в валюте балансовой единицы 
  fiscyearper      : jahrper;        -- Период/год 
  gkont_infl       : gkont;          -- Корр.счет первичного документа
  awtyp            : awtyp;
  date_infl        : abap.dats;      -- Дата возникновения затраты
  belnr_first      : co_belnr;       -- № документа
  buzei_first      : co_buzei;       -- Строка проводки
  cpi              : abap.fltp;      -- Коэффицент инфляциии
  fiscyearper_infl : jahrper;  
  hsl_infl         : abap.fltp;      -- Проинфлированная сумма в валюте балансовой еденицы
  set_name         : abap.char(30);
  bttype           : fins_bttype;
  anln1            : anln1;
  anln2            : anln2;
  budat            : budat;
  vptnr            : jv_part;
  vrgng            : co_vorgang;
  xreversing       : fins_xreversing;
  xreversed        : fins_xreversed;
  awref_rev        : awref_rev;
  sgtxt            : sgtxt;
  aufnr            : aufnr;
  tcode            : tcode;
  gkont2           : gkont;
  buzei_corr       : buzei;
} 

implemented by method ZCL_FI_IFRS_CPI=>ZT_IFRS_WBS1; 