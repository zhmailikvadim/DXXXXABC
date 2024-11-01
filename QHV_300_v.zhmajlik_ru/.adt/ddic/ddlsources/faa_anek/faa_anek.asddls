@AbapCatalog.sqlViewName: 'FAAV_ANEK'
@EndUserText.label: 'Kompatibilitaets-View fuer Tabelle ANEK'

@ClientHandling.algorithm: #SESSION_VARIABLE
@ClientHandling.type: #CLIENT_DEPENDENT
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED

// this view is to build table ANEK from views FAA_ANEK_MSL_AN,
// FAA_ANEK_MSL_GR, FAA_ANEK_ADD_AN, FAA_ANEK_ADD_GR and tables ACDOCA, FAAT_DOC_IT
----------------------------------------------------------------
// in the first select of the UNION ALL we select data from
// a table with the original structure of the former ANEK table.
// this is to get the correct field types in the CDS view.
// the types of CDS-view fields are taken from the first
// select-statement of a UNION ALL
----------------------------------------------------------------
define view Faa_Anek

as select from anek

{ key mandt as mandt,
  key bukrs,
  key anln1,
  key anln2,
  key gjahr,
  key lnran,
--      'ANEK' as rctyp,   // for test only
      bldat,
      budat,
      monat,
      cpudt,
      cputm,
      aedat,
      upddt,
      usnam,
      tcode,
      bvorg,
      xblnr,
      stblg,
      stjah,
      sgtxt,
      menge,
      meins,
      anlu1,
      anlu2,
      anupd,
      glvor,
      vbund,
      pargb,
      bureg,
      auglz,
      abrbup,
      obart,
      objid,
      zuonr,
      mwskz,
      ebeln,
      ebelp,
      matnr,
      augln,
      belnr,
      buzei,
      bzdat,
      xantei,
      awtyp,
      aworg,
      awsys,
      pbukr,
      vorgn,
      ldgrp,
      document_uuid,
      transaction_uuid }

  where bukrs = '0001'
    and bukrs = '0002'

union all

select distinct from acdoca as adoc     // build ANEKs from ACDOCA

inner join Faa_Rep_Ledger   as ldnr
   on adoc.rbukrs = ldnr.bukrs
  and adoc.rldnr  = ldnr.rep_ledger
  and adoc.afabe  = ldnr.lead_afabe
  and ldnr.xstore = 'X'

left outer join      bkpf   as bkpf
   on adoc.rbukrs = bkpf.bukrs
  and adoc.belnr  = bkpf.belnr
  and adoc.gjahr  = bkpf.gjahr
  and adoc.awtyp  = bkpf.awtyp   // 2704559

left outer join  Faa_Anek_Msl_An as msl    // this join is to get the correct quantity
   on adoc.rbukrs = msl.bukrs
  and adoc.anln1  = msl.anln1
  and adoc.anln2  = msl.anln2
//  and adoc.gjahr  = msl.gjahr
  and adoc.ryear  = msl.gjahr
  and adoc.subta  = msl.subta

left outer join  Faa_Anek_Add_An as add_an    // 2383889 this join is to get the additional fields based on anln
   on adoc.rbukrs = add_an.bukrs
  and adoc.anln1  = add_an.anln1
  and adoc.anln2  = add_an.anln2
//  and adoc.gjahr  = add_an.gjahr
  and adoc.ryear  = add_an.gjahr
  and adoc.subta  = add_an.subta


 left outer join anek as anek          // this join is only in order to handle fields of type RAW correctly
   on anek.bukrs = ''                  // e.g. document_uuid, transaction_uuid

{ key adoc.rclnt   as mandt,
  key adoc.rbukrs  as bukrs,
  key adoc.anln1   as anln1,
  key adoc.anln2   as anln2,
//  key adoc.gjahr   as gjahr,
  key adoc.ryear   as gjahr,
  key substring(adoc.subta,2,5) as lnran,
--      'ADOC'       as rctyp,   // for test only
      adoc.bldat   as bldat,
      adoc.budat   as budat,
      substring(adoc.poper,2,2) as monat,
      bkpf.cpudt   as cpudt,
      bkpf.cputm   as cputm,
      bkpf.aedat   as aedat,
      bkpf.upddt   as upddt,
      bkpf.usnam   as usnam,
      bkpf.tcode   as tcode,
      bkpf.bvorg   as bvorg,
      bkpf.xblnr   as xblnr,
      bkpf.stblg   as stblg,
      bkpf.stjah   as stjah,
      add_an.sgtxt as sgtxt,              // 2364948
      msl.menge    as menge,
      msl.meins    as meins,
      adoc.panl1   as anlu1,              // 2743268
      adoc.panl2   as anlu2,              // 2743268
              ''   as anupd,
      bkpf.glvor   as glvor,
      add_an.rassc as vbund,              // 2786685
      add_an.sbusa as pargb,              // 2318123
      adoc.settlement_rule as bureg,
      substring(adoc.awitem,4,3) as auglz,
             '  '  as abrbup,               -- not relevant
//  case when adoc.vorgn = 'ZUCO'         2262073
      case when adoc.awtyp = 'AUAK' or adoc.awtyp = 'AIBU'
           then substring(add_an.parob1,1,2)
           else '' end as obart,
  //    case when adoc.vorgn = 'ZUCO'       2262073
      case when adoc.awtyp = 'AUAK'  or   adoc.awtyp = 'AIBU'
           then substring(add_an.parob1,3,20)
           else '' end as objid,
      add_an.zuonr as zuonr,              // 2324017
      add_an.mwskz as mwskz,              // 2338124
      adoc.ebeln   as ebeln,
      adoc.ebelp   as ebelp,
              ''   as matnr,              -- not relevant
              ''   as augln,              -- not relevant
      adoc.awref   as belnr,
      case when adoc.mig_source = 'A'
           then substring(adoc.awitgrp,4,3)
           else substring(adoc.awitem,4,3) end as buzei,
      add_an.bzdat as bzdat,              // 2324017
      case when adoc.awtyp = 'BKPF'
            and adoc.vorgn = 'ABGA' then '2' else '0' end as xantei,
      adoc.awtyp   as awtyp,
      adoc.aworg   as aworg,
      adoc.awsys   as awsys,
      adoc.pbukrs  as pbukr,
      adoc.vorgn   as vorgn,
      case when adoc.mig_source = 'A'              -- to avoid double ANEK's, 2986850
           then ''
           when bkpf.ldgrp <> ''
           then bkpf.ldgrp
           else ldnr.ldgrp end as ldgrp,
      anek.document_uuid    as document_uuid,      -- not relevant
      anek.transaction_uuid as transaction_uuid }  -- not relevant

  where adoc.anln1   <> ''
    and adoc.awtyp   <> 'AMDP'
    and adoc.vorgn   <> 'AUZF'  // 2704559
    and adoc.afabe   <> '00'
    and adoc.bstat   <> 'C'    // only current year values
    and adoc.slalittype <> '07980'                              -- H2791604: not reporting relevant
    and ( mig_source = 'A' or mig_source = '' )

union all

// the same for group assets
-----------------------------
--> 2383889 change in left outer join to adoc.anlgr and adoc.anlgr2

select distinct from acdoca as adoc     // build ANEKs from ACDOCA

inner join Faa_Rep_Ledger   as ldnr
   on adoc.rbukrs = ldnr.bukrs
  and adoc.rldnr  = ldnr.rep_ledger
  and adoc.afabe  = ldnr.lead_afabe
  and ldnr.xstore = 'X'

left outer join      bkpf   as bkpf
   on adoc.rbukrs = bkpf.bukrs
  and adoc.belnr  = bkpf.belnr
  and adoc.gjahr  = bkpf.gjahr
  and adoc.awtyp  = bkpf.awtyp   // 2704559

left outer join  Faa_Anek_Msl_Gr as msl    // this join is to get the correct quantity
   on adoc.rbukrs = msl.bukrs
  and adoc.anlgr  = msl.anlgr
  and adoc.anlgr2 = msl.anlgr2
//  and adoc.gjahr  = msl.gjahr
  and adoc.ryear  = msl.gjahr
  and adoc.subta  = msl.subta

left outer join  Faa_Anek_Add_Gr as add_gr    // 2383889 this join is to get the additional fields based on anlgr
   on adoc.rbukrs = add_gr.bukrs
  and adoc.anlgr  = add_gr.anlgr
  and adoc.anlgr2 = add_gr.anlgr2
//  and adoc.gjahr  = add_gr.gjahr
  and adoc.ryear  = add_gr.gjahr
  and adoc.subta  = add_gr.subta

left outer join anek as anek           // this join is only in order to handle fields of type RAW correctly
     on anek.bukrs = ''                // e.g. document_uuid, transaction_uuid

{ key adoc.rclnt   as mandt,
  key adoc.rbukrs  as bukrs,
  key adoc.anlgr   as anln1,
  key adoc.anlgr2  as anln2,
//  key adoc.gjahr   as gjahr,
  key adoc.ryear   as gjahr,
  key substring(adoc.subta,2,5) as lnran,
--      'ADOC'       as rctyp,   // for test only
      adoc.bldat   as bldat,
      adoc.budat   as budat,
      substring(adoc.poper,2,2) as monat,
      bkpf.cpudt   as cpudt,
      bkpf.cputm   as cputm,
      bkpf.aedat   as aedat,
      bkpf.upddt   as upddt,
      bkpf.usnam   as usnam,
      bkpf.tcode   as tcode,
      bkpf.bvorg   as bvorg,
      bkpf.xblnr   as xblnr,
      bkpf.stblg   as stblg,
      bkpf.stjah   as stjah,
      add_gr.sgtxt as sgtxt,              // 2364948
      msl.menge    as menge,
      msl.meins    as meins,
      adoc.panl1   as anlu1,              // 2743268
      adoc.panl2   as anlu2,              // 2743268
              ''   as anupd,
      bkpf.glvor   as glvor,
      add_gr.rassc as vbund,              // 2786685
      add_gr.sbusa as pargb,              // 2318123
      adoc.settlement_rule as bureg,
      substring(adoc.awitem,4,3) as auglz,
             '  '  as abrbup,               -- not relevant
//      case when adoc.vorgn = 'ZUCO'
      case when adoc.awtyp = 'AUAK' or adoc.awtyp = 'AIBU'      --Note 2315047
           then substring(add_gr.parob1,1,2)
           else '' end as obart,
//      case when adoc.vorgn = 'ZUCO'
      case when adoc.awtyp = 'AUAK' or adoc.awtyp = 'AIBU'      --Note 2315047
           then substring(add_gr.parob1,3,20)
           else '' end as objid,
      add_gr.zuonr as zuonr,              // 2324017
      add_gr.mwskz as mwskz,              // 2338124
      adoc.ebeln   as ebeln,
      adoc.ebelp   as ebelp,
              ''   as matnr,              -- not relevant
              ''   as augln,              -- not relevant
      adoc.awref   as belnr,
      case when adoc.mig_source = 'A'
           then substring(adoc.awitgrp,4,3)
           else substring(adoc.awitem,4,3) end as buzei,
      add_gr.bzdat as bzdat,              // 2324017
      case when adoc.awtyp = 'BKPF'
            and adoc.vorgn = 'ABGA' then '2' else '0' end as xantei,
      adoc.awtyp   as awtyp,
      adoc.aworg   as aworg,
      adoc.awsys   as awsys,
      adoc.pbukrs  as pbukr,
      adoc.vorgn   as vorgn,
      case when adoc.mig_source = 'A'              -- to avoid double ANEK's, 2986850
           then ''
           when bkpf.ldgrp <> ''
           then bkpf.ldgrp
           else ldnr.ldgrp end as ldgrp,
      anek.document_uuid    as document_uuid,      -- not relevant
      anek.transaction_uuid as transaction_uuid }  -- not relevant

  where adoc.anlgr <> ''
    and (    ( adoc.anlgr  <> adoc.anln1                               )
          or ( adoc.anlgr  =  adoc.anln1 and adoc.anlgr2 <> adoc.anln2 ) )
    and adoc.awtyp <> 'AMDP'
    and adoc.vorgn <> 'AUZF'  // 2704559
    and adoc.afabe <> '00'
    and adoc.bstat <> 'C'    // only current year values
    and adoc.slalittype <> '07980'                              -- H2791604: not reporting relevant
    and ( mig_source = 'A' or mig_source = '' )

union all

---------------------------------------------------------------------------------
// Build ANEK that only occur in table faat_doc_it
---------------------------------------------------------------------------------
select distinct from faat_doc_it as stat    // build ANEKs with BKPF header data

left outer join acdoca as adoc

  inner join Faa_Rep_Ledger   as ldnr      // 2704559
   on adoc.rbukrs = ldnr.bukrs
  and adoc.rldnr  = ldnr.rep_ledger
  and adoc.afabe  = ldnr.lead_afabe
  and ldnr.xstore = 'X'

   on stat.bukrs  = adoc.rbukrs
  and stat.anln1  = adoc.anln1
  and stat.anln2  = adoc.anln2
//  and stat.gjahr  = adoc.gjahr
  and stat.gjahr  = adoc.ryear
  and stat.subta  = adoc.subta

  and adoc.anln1   <> ''
  and adoc.awtyp   <> 'AMDP'
  and adoc.vorgn   <> 'AUZF'  // 2704559
  and adoc.afabe   <> '00'
  and adoc.bstat   <> 'C'    // only current year values
  and ( adoc.mig_source = 'A' or adoc.mig_source = '' )

left outer join     bkpf     as bkpf
   on stat.bukrs  = bkpf.bukrs
  and stat.awref  = bkpf.belnr
  and stat.gjahr  = bkpf.gjahr
  and stat.awtyp  = bkpf.awtyp   // 2704559

left outer join anek as anek           // this join is only in order to handle fields of type RAW correctly
     on anek.bukrs = ''                // e.g. document_uuid, transaction_uuid

{ key stat.mandt   as mandt,
  key stat.bukrs   as bukrs,
  key stat.anln1   as anln1,
  key stat.anln2   as anln2,
  key stat.gjahr   as gjahr,
  key substring(stat.subta,2,5) as lnran,
--      'STAT'       as rctyp,   // for test only
      stat.bldat   as bldat,
      stat.budat   as budat,
      substring(stat.poper,2,2) as monat,
      case when bkpf.cpudt <> '00000000'
           then bkpf.cpudt
           else stat.cpudt end as cpudt,
      case when bkpf.cputm <> '000000'
           then bkpf.cputm
           else stat.cputm end as cputm,
      case when bkpf.aedat <> '00000000'
           then bkpf.aedat
           else '00000000' end as aedat,
      case when bkpf.upddt <> '00000000'
           then bkpf.upddt
           else '00000000' end as upddt,
      case when bkpf.usnam <> ''
           then bkpf.usnam
           else stat.usnam end as usnam,
      case when bkpf.tcode <> ''
           then bkpf.tcode
           else stat.tcode end as tcode,
      case when bkpf.bvorg <> ''
           then bkpf.bvorg
           else ''         end as bvorg,
      case when bkpf.xblnr <> ''
           then bkpf.xblnr
           else stat.xblnr end as xblnr,
      case when bkpf.stblg <> ''
           then bkpf.stblg
           else ''         end as stblg,
      case when bkpf.stjah <> '0000'
           then bkpf.stjah
           else '0000'     end as stjah,
      stat.sgtxt   as sgtxt,
      cast( 0  as abap.quan( 13, 3 )) as menge,
      cast( '' as abap.unit( 3 ))     as meins,
      stat.panl1   as anlu1,              // 2743268
      stat.panl2   as anlu2,              // 2743268
              ''   as anupd,
      case when stat.has_fi_doc = ''
           then 'RFBU'
           else bkpf.glvor end as glvor,
              ''   as vbund,
              ''   as pargb,
            '000'  as bureg,
      substring(stat.awitem,4,3) as auglz,
             '  '  as abrbup,               -- not relevant
//      case when stat.vorgn = 'ZUCO'
      case when stat.awtyp = 'AUAK' or stat.awtyp = 'AIBU'      --Note 2315047
           then stat.obart
           else '' end as obart,
//      case when stat.vorgn = 'ZUCO'
      case when stat.awtyp = 'AUAK' or stat.awtyp = 'AIBU'      --Note 2315047
           then stat.objid
           else '' end as objid,
      stat.zuonr   as zuonr,
              ''   as mwskz,
              ''   as ebeln,
         '00000'   as ebelp,
              ''   as matnr,              -- not relevant
              ''   as augln,
      stat.awref   as belnr,
      substring(stat.awitem,4,3) as buzei,
      stat.bzdat   as bzdat,
             '5'   as xantei,
      stat.awtyp   as awtyp,
      stat.aworg   as aworg,
      stat.awsys   as awsys,
              ''   as pbukr,
      stat.vorgn   as vorgn,
      case when stat.mig_source = 'A'              -- to avoid double ANEK's, 2986850
           then ''
           when bkpf.ldgrp <> ''
           then bkpf.ldgrp
           else stat.ldgrp end as ldgrp,
      anek.document_uuid    as document_uuid,      -- not relevant
      anek.transaction_uuid as transaction_uuid }  -- not relevant

   where stat.anln1  <> ''
     and stat.awtyp  <> 'AMDP'
     and stat.vorgn  <> 'AUZF' // 2704559
     and stat.bwasl  <> '999'  // w/o bcf
     and stat.movcat <> '00'   // w/o bcf
     and adoc.rbukrs is null   //<<< only from faat_doc_it

union all

// the same for group assets
----------------------------
select distinct from faat_doc_it as stat           // build ANEKs with BKPF header data

left outer join acdoca as adoc

  inner join Faa_Rep_Ledger   as ldnr      // 2704559
   on adoc.rbukrs = ldnr.bukrs
  and adoc.rldnr  = ldnr.rep_ledger
  and adoc.afabe  = ldnr.lead_afabe
  and ldnr.xstore = 'X'

   on stat.bukrs  = adoc.rbukrs
  and stat.anln1  = adoc.anln1
  and stat.anln2  = adoc.anln2
//  and stat.gjahr  = adoc.gjahr
  and stat.gjahr  = adoc.ryear
  and stat.subta  = adoc.subta

  and adoc.anlgr <> ''
  and (    ( adoc.anlgr  <> adoc.anln1                               )
        or ( adoc.anlgr  =  adoc.anln1 and adoc.anlgr2 <> adoc.anln2 ) )
  and adoc.awtyp <> 'AMDP'
  and adoc.vorgn <> 'AUZF' // 2704559
  and adoc.afabe <> '00'
  and adoc.bstat <> 'C'    // only current year values
  and ( adoc.mig_source = 'A' or adoc.mig_source = '' )

left outer join     bkpf     as bkpf
   on stat.bukrs  = bkpf.bukrs
  and stat.awref  = bkpf.belnr
  and stat.gjahr  = bkpf.gjahr
  and stat.awtyp  = bkpf.awtyp   // 2704559

left outer join anek as anek           // this join is only in order to handle fields of type RAW correctly
     on anek.bukrs = ''                // e.g. document_uuid, transaction_uuid

{ key stat.mandt   as mandt,
  key stat.bukrs   as bukrs,
  key stat.anlgr   as anln1,
  key stat.anlgr2  as anln2,
  key stat.gjahr   as gjahr,
  key substring(stat.subta,2,5) as lnran,
--      'STAT'       as rctyp,   // for test only
      stat.bldat   as bldat,
      stat.budat   as budat,
      substring(stat.poper,2,2) as monat,
      case when bkpf.cpudt <> '00000000'
           then bkpf.cpudt
           else stat.cpudt end as cpudt,
      case when bkpf.cputm <> '000000'
           then bkpf.cputm
           else stat.cputm end as cputm,
      case when bkpf.aedat <> '00000000'
           then bkpf.aedat
           else '00000000' end as aedat,
      case when bkpf.upddt <> '00000000'
           then bkpf.upddt
           else '00000000' end as upddt,
      case when bkpf.usnam <> ''
           then bkpf.usnam
           else stat.usnam end as usnam,
      case when bkpf.tcode <> ''
           then bkpf.tcode
           else stat.tcode end as tcode,
      case when bkpf.bvorg <> ''
           then bkpf.bvorg
           else ''         end as bvorg,
      case when bkpf.xblnr <> ''
           then bkpf.xblnr
           else stat.xblnr end as xblnr,
      case when bkpf.stblg <> ''
           then bkpf.stblg
           else ''         end as stblg,
      case when bkpf.stjah <> '0000'
           then bkpf.stjah
           else '0000'     end as stjah,
      stat.sgtxt   as sgtxt,
      cast( 0  as abap.quan( 13, 3 )) as menge,
      cast( '' as abap.unit( 3 ))     as meins,
      stat.panl1   as anlu1,              // 2743268
      stat.panl2   as anlu2,              // 2743268
              ''   as anupd,
      case when stat.has_fi_doc = ''
           then 'RFBU'
           else bkpf.glvor end as glvor,
              ''   as vbund,
              ''   as pargb,
            '000'  as bureg,
      substring(stat.awitem,4,3) as auglz,
             '  '  as abrbup,             -- not relevant
//      case when stat.vorgn = 'ZUCO'
      case when stat.awtyp = 'AUAK' or stat.awtyp = 'AIBU'      --Note 2315047
           then stat.obart
           else '' end as obart,
//      case when stat.vorgn = 'ZUCO'
      case when stat.awtyp = 'AUAK' or stat.awtyp = 'AIBU'      --Note 2315047
           then stat.objid
           else '' end as objid,
      stat.zuonr   as zuonr,
              ''   as mwskz,
              ''   as ebeln,
         '00000'   as ebelp,
              ''   as matnr,              -- not relevant
              ''   as augln,
      stat.awref   as belnr,
      substring(stat.awitem,4,3) as buzei,
      stat.bzdat   as bzdat,
             '5'   as xantei,
      stat.awtyp   as awtyp,
      stat.aworg   as aworg,
      stat.awsys   as awsys,
              ''   as pbukr,
      stat.vorgn   as vorgn,
      case when stat.mig_source = 'A'              -- to avoid double ANEK's, 2986850
           then ''
           when bkpf.ldgrp <> ''
           then bkpf.ldgrp
           else stat.ldgrp end as ldgrp,
      anek.document_uuid    as document_uuid,      -- not relevant
      anek.transaction_uuid as transaction_uuid }  -- not relevant

  where stat.anlgr <> ''
    and (    ( stat.anlgr  <> stat.anln1                               )
          or ( stat.anlgr  =  stat.anln1 and stat.anlgr2 <> stat.anln2 ) )
    and stat.awtyp  <> 'AMDP'
    and stat.vorgn  <> 'AUZF'  // 2704559
    and stat.bwasl  <> '999'  // w/o bcf
    and stat.movcat <> '00'   // w/o bcf
    and adoc.rbukrs is null   //<<< only from faat_doc_it















