@AbapCatalog.sqlViewName: 'V_COEP_R2'
@ClientDependent: true
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'COEP revised version - part 2'
define view V_Coep_R2_view as 

   select key mandt,
          key kokrs,
          key belnr, 
          key buzei,            
          PERIO,
          WTGBTR, 
          WOGBTR, 
          WKGBTR,
          WKFBTR,
          PAGBTR,
          PAFBTR,
          MEGBTR,
          MEFBTR,
          MBGBTR,
          MBFBTR,        
          LEDNR,   
          
          GJAHR,
          WRTTP,      
          versn,         
          KSTAR, 
          hrkft,
          vrgng,
          PAROB,          
          parob1,
          uspob,
          VBUND,      
          PARGB,         
          beknz,      
          TWAER,
          OWAER,  
          MEINH,
          MEINB,
          muvflg,    
          sgtxt,
          refbz,  
          zlenr, 
          BW_REFBZ,      
          gkont,
          gkoar,
          werks,
          matnr,
          rbest,
          ebeln,
          ebelp,
          zekkn,
          erlkz,
          pernr,
          BTRKL,          --- obsolete?
          objnr_n1,
          objnr_n2,
          objnr_n3,
          paobjnr,
          beltp,
          BUKRS, 
          GSBER,
          FKBER,   
          scope,
          logsyso,
          pkstar,
          pbukrs,
          PFKBER, 
          pscope,
          logsysp,
          dabrz,       
          bwstrat,
          objnr_hk, 
          --- TIMESTMP, 
--- Add Schaltjahre YEAR ---
          case when tsgjahr0 >= 2020 then 8*60*60*24 --- 8 schaltjahre since 1990
                                                       else
          case when tsgjahr0 >= 2016 then 7*60*60*24 --- 7 schaltjahre since 1990
                                                       else
          case when tsgjahr0 >= 2012 then 6*60*60*24 --- 6 schaltjahre since 1990
                                                       else  
          case when tsgjahr0 >= 2008 then 5*60*60*24 --- 5 schaltjahre since 1990
                                                       else
          case when tsgjahr0 >= 2004 then 4*60*60*24 --- 4 schaltjahre since 1990
                                                      else
          case when tsgjahr0 >= 2000 then 3*60*60*24 --- 3 schaltjahre since 1990
                                                       else   
          case when tsgjahr0 >= 1996 then 2*60*60*24 --- 2 schaltjahre since 1990
                                                       else          
          case when tsgjahr0 >= 1992 then 1*60*60*24 --- 1 schaltjahre since 1990
                                                       else 0 
                                                    --- 0 schaltjahre since 1990
          end end end end end end end end as tsgjahradd,  
---  YEAR ---                                                                                                                                                                                                            
          case when tsgjahr0 = 0000 then 0 else cast( (tsgjahr0-1990)*60*24*365 as abap.dec( 16, 0 ) ) end as tsgjahr1,   
--- MONTH ---
          case when tsmonth0 = 1     then 0                            --- JAN = 31
                                                       else            
          case when tsmonth0 = 2     then 60*60*24*31                  --- FEB 31+28 = 59
                                                       else          
          case when tsmonth0 = 3     then 60*60*24*59                  --- MAR 31+28+31 = 90
                                                       else  
          case when tsmonth0 = 4     then 60*60*24*90                  --- APR 31+28+31+30 = 120
                                                       else  
          case when tsmonth0 = 5     then 60*60*24*120                 --- MAY 31+28+31+30+31 = 151
                                                       else                                                         
          case when tsmonth0 = 6     then 60*60*24*151                 --- JUN 31+28+31+30+31+30 = 181
                                                       else                                                        
          case when tsmonth0 = 7     then 60*60*24*181                 --- JUL 31+28+31+30+31+30+31 = 212
                                                       else   
          case when tsmonth0 = 8     then 60*60*24*212                 --- AUG 31+28+31+30+31+30+31+31 = 243
                                                       else                                                        
          case when tsmonth0 = 9     then 60*60*24*243                 --- SEP 31+28+31+30+31+30+31+31+30 = 273
                                                       else 
          case when tsmonth0 = 10    then 60*60*24*273                 --- OCT 31+28+31+30+31+30+31+31+30+31 = 304
                                                       else 
          case when tsmonth0 = 11    then 60*60*24*304                 --- NOV 31+28+31+30+31+30+31+31+30+31+30 = 334
                                                       else 
          case when tsmonth0 = 12    then 60*60*24*334                 --- DEC 31+28+31+30+31+30+31+31+30+31+30+31 = 365 (without Schaltjahr)
                                                       else 0                                                                                                             
          end end end end end end end end end end end end as tsmonth1, 
--- DAY ---        
          case when tsday0 = 00 then 0 else (tsday0-1)*60*60*24 end as tsday1,   
--- HOUR ---             
          tshour0*60*60 as tshour1,
--- MINUTE ---            
          tsminute0*60 as tsminute1, 
 --- SECOND ---            
          tssecond0 as tssecond1,                             
          qmnum,      
          GEBER,      
          PGEBER,     
          GRANT_NBR,  
          PGRANT_NBR, 
          REFBZ_FI, 
          segment,
          psegment,
          posnr, 
          prctr,
          PPRCT,
          BUDGET_PD,                      
          PBUDGET_PD,                      
          prodper,
          // Do not delete this comment
          //<$VF>
zz_ebeln,
zz_ebelp,
zz_taxobj,
zz_taxaut,
zz_anln1,
zz_anln2,
zz_invnr,
zz_vd12ves,
zz_vd12vesrb,
zz_landx,
zz_vptnr,
zz_arbpl,
//<$FIELDS>
//<$VF>                                  
          awtyp,
          AWKEY,  
          awsys,
          KWAER,
          
          accasty,
          case
            when accas <>  ''        then accas          
            when accasty = 'KS'      then kostl
            when accasty = 'KL'      then concat( concat(kostl,'/'), lstar)
            when accasty = 'OR'      then aufnr            
            when accasty = 'PR'      then pspnr
            when accasty = 'VB'      then concat( concat(vbeln,'/'), vbposnr)
            else                          ''
          end as accas,                    
                    
          kostl,
          lstar,
          aufnr,
          autyp,
          pspnr,
          pspid,
          vbeln,
          vbposnr,
          ce4key,
  
          objnr,       
         
          erkrs,
          paccas,
          paccasty,
          PKOSTL,
          plstar,
          paufnr,
          pautyp,
          ppspnr,
          ppspid,
          pvbeln,
          pvbposnr,
          pce4key, 
          quant1,
          quant2,
          quant3,
          qunit1,
          qunit2,
          qunit3
          // Do not delete this comment 2
          //<$VFAPP>
//<$FIELDSAPP>
//<$VFAPP>             
    from V_Coep_R1_view
      ;         
 