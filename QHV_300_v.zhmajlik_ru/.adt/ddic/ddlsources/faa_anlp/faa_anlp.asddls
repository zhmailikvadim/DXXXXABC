@AbapCatalog.sqlViewName: 'FAAV_ANLP'
@EndUserText.label: 'Kompatibilitaets-View fuer Tabelle ANLP'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED


// this view is to build table ANLP from view FAA_ANLP4
----------------------------------------------------------------
// in the left part of the UNION ALL we select data from
// a table with the original structure of the former ANLP table.
// this is to get the correct field types in the CDS view.
// the types of CDS-view fields are taken from the first
// select-statement of a UNION ALL
----------------------------------------------------------------
define view Faa_Anlp

as select from anlp

{ key mandt,
  key bukrs,
  key gjahr,
  key peraf,
  key afbnr,        -- note 2246616
  key anln1,
  key anln2,
  key afaber,
  key zujhr,
  key zucod,
      aufwp,
      aufwb,
      aufwz,
      nafap,
      nafag,
      nafaz,
      safap,
      safag,
      safaz,
      aafap,
      aafag,
      aafaz,
      mafap,
      mafag,
      mafaz,
      zinsp,
      zinsg,
      zinsz,
      aufnp,
      aufng,
      aufnz,
      answl,
      invzm,
      ktogr,
      afasl,
      kostl,
      gsber,
      caufn,
      xunul,
      anupd,
      fkber,
      belnr,
      lstar,
      geber,
      grant_nbr,
      geber2,
      fkber2,
      grant_nbr2,
      fistl2,
      imkey,
      ps_psp_pnr2,
      budget_pd,
      budget_pd2,
      segment,
      prctr,
      fistl }

      where bukrs = '0001'
        and bukrs = '0002'

union all

   select from Faa_Anlp4 as anlp

//   inner join  anla      as anla
//           on  anlp.mandt = anla.mandt
//          and  anlp.bukrs = anla.bukrs
//          and  anlp.anln1 = anla.anln1
//          and  anlp.anln2 = anla.anln2
     inner join  I_FixedAsset  as anla
           on  anlp.mandt = anla.mandt
          and  anlp.bukrs = anla.CompanyCode
          and  anlp.anln1 = anla.MasterFixedAsset
          and  anlp.anln2 = anla.FixedAsset

{ key anlp.mandt,
  key anlp.bukrs,
  key gjahr,
  key peraf,
  key afbnr,         -- note 2246616
  key anlp.anln1,
  key anlp.anln2,
  key afaber,
  key '0000'       as zujhr,       -- not relevant
  key '0000'       as zucod,       -- not relevant
      aufwp,
      aufwb,
      aufwz,
      nafap,
      nafag,
      nafaz,
      safap,
      safag,
      safaz,
      aafap,
      aafag,
      aafaz,
      mafap,
      mafag,
      mafaz,
      zinsp,
      zinsg,
      zinsz,
      aufnp,
      aufng,
      aufnz,
      cast( 0  as answl ) as answl, //AFLE Enablement
      cast( 0  as invzm ) as invzm, //AFLE Enablement
//      anla.ktogr as ktogr,
      anla.AssetAccountDetermination as ktogr,
      ''         as afasl,                 -- not relevant
------------------------------------------------------
      kostl      as kostl,                // note 2196768
      ''         as gsber,
      ''         as caufn,
      ''         as xunul,                 -- aussitzen
      ''         as anupd,
      ''         as fkber,
      ''         as belnr,
      ''         as lstar,
      ''         as geber,
      ''         as grant_nbr,
      ''         as geber2,
      ''         as fkber2,
      ''         as grant_nbr2,
      ''         as fistl2,
      ''         as imkey,
      '00000000' as ps_psp_pnr2,
      ''         as budget_pd,
      ''         as budget_pd2,
      ''         as segment,
      ''         as prctr,
      ''         as fistl }
------------------------------------------------------
//                    kostl,
//                    gsber,
//                    caufn,
//      ''         as xunul,                 -- aussitzen
//      ''         as anupd,
//      ''         as fkber,
//                    belnr,
//                    lstar,
//      ''         as geber,
//      ''         as grant_nbr,
//                    geber2,
//                    fkber2,
//                    grant_nbr2,
//                    fistl2,
//      ''         as imkey,
//      '00000000' as ps_psp_pnr2,
//      ''         as budget_pd,
//                    budget_pd2,
//                    segment,
//                    prctr,
//      ''         as fistl }








