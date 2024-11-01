@AbapCatalog.sqlViewName: 'FAAV_ANEA'
@EndUserText.label: 'Kompatibilitaets-View fuer Tabelle ANEA'
@ClientHandling.type: #CLIENT_DEPENDENT
@ClientHandling.algorithm: #SESSION_VARIABLE
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.serviceQuality: #D
@ObjectModel.usageType.dataClass: #MIXED

// this view is to build table ANEA from view FAA_ANEA3
----------------------------------------------------------------
// in the left part of the UNION ALL we select data from
// a table with the original structure of the former ANEA table.
// this is to get the correct field types in the CDS view.
// the types of CDS-view fields are taken from the first
// select-statement of a UNION ALL
----------------------------------------------------------------
define view Faa_Anea

as select from anea

  { key mandt,
    key bukrs,
    key anln1,
    key anln2,
    key gjahr,
    key lnran,
    key afabe,
    key zujhr,
    key zucod,
    sum ( aufwv ) as aufwv,
    sum ( invzv ) as invzv,
    sum ( nafav ) as nafav,
    sum ( safav ) as safav,
    sum ( aafav ) as aafav,
    sum ( mafav ) as mafav,
    sum ( aufnv ) as aufnv,
    sum ( aufwl ) as aufwl,
    sum ( invzl ) as invzl,
    sum ( nafal ) as nafal,
    sum ( safal ) as safal,
    sum ( aafal ) as aafal,
    sum ( mafal ) as mafal,
    sum ( aufnl ) as aufnl,
    sum ( erlbt ) as erlbt,
            ' '   as anupd,
    sum ( verko ) as verko,
    sum ( sanwv ) as sanwv }

  where bukrs = '0001'
    and bukrs = '0002'

     group by mandt,
              bukrs,
              anln1,
              anln2,
              gjahr,
              lnran,
              afabe,
              zujhr,
              zucod

union all

   select from Faa_Anea3

  { key mandt,
    key bukrs,
    key anln1,
    key anln2,
    key gjahr,
    key lnran,
    key afabe,
    key '0000'    as zujhr,
    key zucod     as zucod,
    sum ( aufwv ) as aufwv,
    sum ( invzv ) as invzv,
    sum ( nafav ) as nafav,
    sum ( safav ) as safav,
    sum ( aafav ) as aafav,
    sum ( mafav ) as mafav,
    sum ( aufnv ) as aufnv,
    sum ( aufwl ) as aufwl,
    sum ( invzl ) as invzl,
    sum ( nafal ) as nafal,
    sum ( safal ) as safal,
    sum ( aafal ) as aafal,
    sum ( mafal ) as mafal,
    sum ( aufnl ) as aufnl,
    sum ( erlbt ) as erlbt,
            ' '   as anupd,
    sum ( verko ) as verko,
    sum ( sanwv ) as sanwv }

   group by mandt,
            bukrs,
            anln1,
            anln2,
            gjahr,
            lnran,
            afabe,
            zucod

union all

// this UNION ALL builts dummy ANEA's for those ANEP's with XANTW=X
// that have NO corresponding records in ACDOCA and FAAT_DOC_IT

  select from     Faa_Anep  as anep

  left outer join Faa_Anea3 as anea
     on anep.bukrs = anea.bukrs
    and anep.anln1 = anea.anln1
    and anep.anln2 = anea.anln2
    and anep.gjahr = anea.gjahr
    and anep.lnran = anea.lnran
    and anep.afabe = anea.afabe
    and anep.zujhr = '0000'
    and anep.zucod = anea.zucod
//    and anep.xantw = 'X'     // 2338124

  { key anep.mandt,
    key anep.bukrs,
    key anep.anln1,
    key anep.anln2,
    key anep.gjahr,
    key anep.lnran,
    key anep.afabe,
    key anep.zujhr,
    key anep.zucod,
    cast( 0 as aufwv ) as aufwv, //AFLE Enablement
    cast( 0 as invzv ) as invzv, //AFLE Enablement
    cast( 0 as nafav ) as nafav, //AFLE Enablement
    cast( 0 as safav ) as safav, //AFLE Enablement
    cast( 0 as aafav ) as aafav, //AFLE Enablement
    cast( 0 as mafav ) as mafav, //AFLE Enablement
    cast( 0 as aufnv ) as aufnv, //AFLE Enablement
    cast( 0 as aufwl ) as aufwl, //AFLE Enablement
    cast( 0 as invzl ) as invzl, //AFLE Enablement
    cast( 0 as nafal ) as nafal, //AFLE Enablement
    cast( 0 as safal ) as safal, //AFLE Enablement
    cast( 0 as aafal ) as aafal, //AFLE Enablement
    cast( 0 as mafal ) as mafal, //AFLE Enablement
    cast( 0 as aufnl ) as aufnl, //AFLE Enablement
    cast( 0 as erlbt ) as erlbt, //AFLE Enablement
            ' '                as anupd,
    cast( 0 as verko_d ) as verko, //AFLE Enablement
    cast( 0 as sanwv ) as sanwv } //AFLE Enablement

    where anea.bukrs is null
      and anep.xantw = 'X'     // 2338124









