@AbapCatalog.sqlViewName: 'FAAV_ANLC'
@EndUserText.label: 'Kompatibilitaets-View fuer Tabelle ANLC'

@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED


// this view is to join values (FAA_ANLC3_SUM)
// and attributes (table FAAT_YDDA) to get the complete ANLC
// this happens in the right part of the UNION ALL
---------------------------------------------------------
// in the left part of the UNION ALL we select data from
// a table with the original structure of the former ANLC table.
// this is to get the correct field types in the CDS view.
// the types of CDS-view fields are taken from the first
// select-statement of a UNION ALL
----------------------------------------------------------------
define view Faa_Anlc

as select
        key mandt,
        key bukrs,
        key anln1,
        key anln2,
        key gjahr,
        key afabe,
            zujhr,
            zucod,
            afblpe,
            afbanz,
            xafar,
            ndabj,
            ndabp,
            andsj,
            andsp,
            rstck,
--          Kummulierte Werte
            kansw,
            kaufw,
            kinvz,
            knafa,
            ksafa,
            kaafa,
            kmafa,
            kzinw,
            kaufn,
            kanza,
            kvost,   // still open
--          Werte laufendes Geschäftsjahr
--          Plan values
            aufwp,
            nafap,
            safap,
            aafap,
            mafap,
            zinsp,
            aufnp,
--          Posted values
            aufwb,
            nafag,
            safag,
            aafag,
            mafag,
            zinsg,
            aufng,
            answl,
            abgan,
            ansaz,
            aufwm,
            invzm,
            nafam,
            safam,
            aafam,
            mafam,
            zinsm,
            aufnm,
            zusna,
            zussa,
            zusaa,
            zusma,
            aufwv,
            invzv,
            nafav,
            safav,
            aafav,
            mafav,
            aufnv,
            aufwl,
            invzl,
            nafal,
            safal,
            aafal,
            mafal,
            aufnl,
            anupd,
            ksans,
            sansl,
            pstbeg,
            pstend,
            pstcalc,
            pstper

  from anlc where bukrs = '0001'
              and bukrs = '0002'

union all

  select from I_AssetYearOpeningValnAttrib as v1
  
  left outer join Faa_Anlc3_Sum   as v2
     on v1.mandt = v2.mandt 
    and v1.CompanyCode           = v2.bukrs
    and v1.MasterFixedAsset      = v2.anln1
    and v1.FixedAsset            = v2.anln2
    and v1.FiscalYear            = v2.gjahr
    and v1.AssetDepreciationArea = v2.afabe

  left outer join Faa_Anlc_Afblpe as v3 // 2650827
     on v1.mandt                 = v3.mandt 
    and v1.CompanyCode           = v3.bukrs
    and v1.MasterFixedAsset      = v3.anln1
    and v1.FixedAsset            = v3.anln2
    and v1.FiscalYear            = v3.gjahr
    and v1.AssetDepreciationArea = v3.afabe
      
    

  {   key v1.mandt as mandt,
      key v1.CompanyCode as bukrs,
      key v1.MasterFixedAsset as anln1,
      key v1.FixedAsset as anln2,
      key v1.FiscalYear as gjahr,
      key v1.AssetDepreciationArea as afabe,
        '0000'   as zujhr,
        '0000'   as zucod,
        v3.poper as afblpe,     // (MAX)ACDOCA-POPER ( if AWTYP = 'AMDP' ) 
        '00'     as afbanz,
        v1.DepreciationErrorStatus as xafar,
        v1.ExpiredUsefulLifeInYrs as ndabj,
        v1.ExpiredUsefulLifeInPerds as ndabp,
        v1.SpclExpiredUsefulLifeInYrs as andsj,
        v1.SpclExpiredUsefulLifeInPerds as andsp,
        v1.DepreciatedUnitsQuantity as rstck,
--      Kummulierte Werte
        v2.kansw as KANSW,
        v2.kaufw as KAUFW,
        v2.kinvz as KINVZ,
        v2.knafa as KNAFA,
        v2.ksafa as KSAFA,
        v2.kaafa as KAAFA,
        v2.kmafa as KMAFA,
        v2.kzinw as KZINW,
        v2.kaufn as KAUFN,
        v2.kanza as KANZA,
        v2.kvost as kvost,
--      Werte laufendes Geschäftsjahr
--      Plan values
        v2.aufwp as AUFWP,
        v2.nafap as NAFAP,
        v2.safap as SAFAP,
        v2.aafap as AAFAP,
        v2.mafap as MAFAP,
        v2.zinsp as ZINSP,
        v2.aufnp as AUFNP,
--      Posted values
        v2.aufwb as AUFWB,
        v2.nafag as NAFAG,
        v2.safag as SAFAG,
        v2.aafag as AAFAG,
        v2.mafag as MAFAG,
        v2.zinsg as ZINSG,
        v2.aufng as AUFNG,
        v2.answl as ANSWL,
        v2.abgan as abgan,
        v2.ansaz as ANSAZ,
        v2.aufwm as AUFWM,
        v2.invzm as INVZM,
        v2.nafam as NAFAM,
        v2.safam as SAFAM,
        v2.aafam as AAFAM,
        v2.mafam as MAFAM,
        v2.zinsm as ZINSM,
        v2.aufnm as AUFNM,
        v2.zusna as ZUSNA,
        v2.zussa as ZUSSA,
        v2.zusaa as ZUSAA,
        v2.zusma as ZUSMA,
        v2.aufwv as AUFWV,
        v2.invzv as INVZV,
        v2.nafav as NAFAV,
        v2.safav as SAFAV,
        v2.aafav as AAFAV,
        v2.mafav as MAFAV,
        v2.aufnv as AUFNV,
        v2.aufwl as AUFWL,
        v2.invzl as INVZL,
        v2.nafal as NAFAL,
        v2.safal as SAFAL,
        v2.aafal as AAFAL,
        v2.mafal as MAFAL,
        v2.aufnl as AUFNL,
            ' '  as anupd,
        v2.ksans as KSANS,
        v2.sansl as SANSL,
          '000'  as pstbeg,
          '000'  as pstend,
            ' '  as pstcalc,
          '000'  as pstper }
 where v1.DepreciationAreaType = ' '
    or v1.DepreciationAreaType = ''
 
