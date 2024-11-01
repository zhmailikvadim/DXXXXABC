@AbapCatalog.sqlViewName: 'FAAV_ANEP'
@EndUserText.label: 'Kompatibilitaets-View fuer Tabelle ANEP'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED


// this view is to build table ANEP from view FAA_ANEP3
----------------------------------------------------------------
// in the left part of the UNION ALL we select data from
// a table with the original structure of the former ANEP table.
// this is to get the correct field types in the CDS view.
// the types of CDS-view fields are taken from the first
// select-statement of a UNION ALL
----------------------------------------------------------------
define view Faa_Anep

as select from anep

  { key mandt,
    key bukrs,
    key anln1,
    key anln2,
    key gjahr,
    key lnran,
    key afabe,
    key zujhr,
    key zucod,
        peraf,
        belnr,
        buzei,
        bzdat,
        bwasl,
        xafar,
        anbtr,
        nafab,
        safab,
        zinsb,
        xantw,
        xawbt,
        lnsan,
        anupd,
        augln }

  where bukrs = '0001'
    and bukrs = '0002'

union all

  select from Faa_Anep3 as v1

  inner join  tabw      as v2
     on v1.bwasl  = v2.bwasl

  inner join  tabwg     as v3
     on v2.bwagrp = v3.bwagrp

  { key v1.mandt as mandt,
    key v1.bukrs as bukrs,
    key v1.anln1 as anln1,
    key v1.anln2 as anln2,
    key v1.gjahr as gjahr,
    key v1.lnran as lnran,
    key v1.afabe as afabe,
    key   '0000' as zujhr,                        // not relevant
    key v1.zucod as zucod,
          '000'  as peraf,                        // not relevant
        v1.belnr as belnr,
        v1.buzei as buzei,
        v1.bzdat as bzdat,
        v1.bwasl as bwasl,
          '0'    as xafar,                        // not relevant
        v1.anbtr as anbtr,
   cast( 0 as nafab) as nafab,           // AFLE Enablement not relevant
   cast( 0 as safab) as safab,           // AFLE Enablement not relevant
   cast( 0 as dzinsb) as zinsb,           // AFLE Enablement not relevant
   case v3.xantei
   when '0' then ''
   else 'X' end  as xantw,
          ' '    as xawbt,                        // not relevant
       v1.lnsan  as lnsan,
          ' '    as anupd,                        // not relevant
       v1.augln  as augln }








