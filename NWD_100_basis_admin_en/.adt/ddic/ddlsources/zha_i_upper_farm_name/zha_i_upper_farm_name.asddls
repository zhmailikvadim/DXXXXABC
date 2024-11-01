@AbapCatalog.sqlViewName: 'ZHA_I_Q_UP_FRM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Upper farm name''s value help'
@Metadata.allowExtensions: true
define view ZHA_I_UPPER_FARM_NAME
  as select distinct from ZHA_I_PARTNERS
  association [1..1] to zha_d_region as _regDate on ZHA_I_PARTNERS.bland = _regDate.bland
{

  key ZHA_I_PARTNERS.kunnr,
      @UI: {
      lineItem: [ { label: 'Партнёр' } ],
      selectionField: [ { position: 10 }  ],
      identification:[ { position: 30, label: 'Партнёр' } ] }
      @EndUserText.label: 'Партнёр'     
      @EndUserText.quickInfo: 'Партнёр'
      Partner,
      ZHA_I_PARTNERS.landx,
      ort01,
      stras,
      ZHA_I_PARTNERS.land1,
      telf1,
      smtp_addr,
      ZHA_I_PARTNERS.bland,
      _regDate.bezei
}
where
  ZHA_I_PARTNERS.land1 = _regDate.land1
