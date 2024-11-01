@AbapCatalog.sqlViewName: 'ZHA_IQ_MKT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Matnr''s value help'

define view ZHA_I_MAKT
  as select distinct from /zhm/makt 
  association[1..1] to /zhm/mara as mara on $projection.matnr_ext = mara.matnr_ext 
{
      key matnr_ext,
      maktx,
      mara.meins
} where spras = 'R'
