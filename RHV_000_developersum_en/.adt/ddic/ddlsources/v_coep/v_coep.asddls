@AbapCatalog.sqlViewName: 'V_COEP'
@EndUserText.label: 'LOCAL: Line Items COEP'

@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.serviceQuality: #X
@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.sizeCategory: #XL

define view v_coep_view as
   select  
          key mandt,
          key kokrs,
          key belnr, 
          key buzei,  
          perio,
          
          wtgbtr, 
          wogbtr, 
          wkgbtr,
          wkfbtr,
          pagbtr,
          pafbtr,
          megbtr,
          mefbtr,
          mbgbtr,
          mbfbtr,  
                
          lednr,   
          objnr,
          gjahr,
          wrttp,  
              
          versn,         
          kstar, 
          hrkft,
          vrgng,
          parob,          
          parob1,
          uspob,
          vbund,      
          pargb,         
          beknz,      
          twaer,
          owaer,  
           
          meinh,
          meinb,
          mvflg,
              
          sgtxt,
          refbz,  
          zlenr, 
          bw_refbz,      
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
          btrkl,  
                 
          objnr_n1,
          objnr_n2,
          objnr_n3,           
          paobjnr,
          beltp,
          bukrs, 
          gsber,
          fkber,   
          scope,
          logsyso,
          pkstar,
          pbukrs,
          pfkber, 
          pscope,
          logsysp,
          dabrz,          
          bwstrat,
          objnr_hk, 
          
          timestmp,          
          qmnum,       
          geber,       
          pgeber,      
          grant_nbr,   
          pgrant_nbr,  
          refbz_fi,  
          segment,
          psegment,
          posnr,
          prctr,
          pprct,                     
          budget_pd,
          pbudget_pd,
          prodper,
          
          // Do not delete this comment
          //<$VF>
//<$FIELDS>
//<$VF>
          awtyp,
          awkey,  
          awsys, 
                             
          kwaer,
          accas,
          accasty,
          kostl,
          lstar,
          aufnr,
          autyp,
          pspnr,
          pspid,          
          vbeln,
          vbposnr,
          ce4key,          
          erkrs,  
          paccas,
          paccasty,          
          pkostl,          
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
          
     from coep 
    where not (   wrttp = '04'
               or wrttp = 'U4'
               or wrttp = 'U1' 
               )                
    
  union all
   select key mandt,
          key kokrs,
          key belnr, 
          key buzei,            
          PERIO,
/*
          cast( WTGBTR as abap.curr(15,2) ) as wtgbtr,
          cast( WOGBTR as abap.curr(15,2) ) as wogbtr, 
          cast( WKGBTR as abap.curr(15,2) ) as wkgbtr,
          cast( WKFBTR as abap.curr(15,2) ) as wkfbtr,
          cast( PAGBTR as abap.curr(15,2) ) as pagbtr,
          cast( PAFBTR as abap.curr(15,2) ) as pafbtr,
          cast( MEGBTR as abap.dec(15,3) ) as megbtr,
          cast( MEFBTR as abap.dec(15,3) ) as mefbtr,    
          cast( MBGBTR as abap.dec(15,3) ) as mbgbtr,
          cast( MBFBTR as abap.dec(15,3) ) as mbfbtr, 
*/           
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
          objnr,                    --cast( objnr as abap.char(22) ) as objnr,
          GJAHR,
          '04'      as  WRTTP,      

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
--          muvflg,
          case when muvflg = '0' then 'X'            -- complete          
               else '' 
          end as mvflg, 
                
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
          '00' as btrkl,     
          
          cast( objnr_n1 as abap.char(22) ) as objnr_n1,
          cast( objnr_n2 as abap.char(22) ) as objnr_n2,
          cast( objnr_n3 as abap.char(22) ) as objnr_n3,           
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
          
--          cast( tstotalsec as abap.dec(16,0) )*10000 as timestmp,          
          cast( tstotalsec*10000 as abap.dec(16,0) ) as timestmp,
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
//<$FIELDS>
//<$VF>    
          awtyp,
          cast( AWKEY as abap.char(20) ) as awkey,            
          awsys,
          
          KWAER,
          accas,
          accasty,
          kostl,
          lstar,
          aufnr,
          autyp,
          pspnr,
          pspid,          
          vbeln,
          vbposnr,
          ce4key,          
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
          cast( quant1 as abap.dec(15,3) ) as quant1,
          cast( quant2 as abap.dec(15,3) ) as quant2,
          cast( quant3 as abap.dec(15,3) ) as quant3,                       
          qunit1,
          qunit2,
          qunit3
          // Do not delete this comment 2
          //<$VFAPP>
//<$FIELDSAPP>
//<$VFAPP>             
    from V_Coep_R3_view    
    ;
             
  
  
  
  
 