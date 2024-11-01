@AbapCatalog.sqlViewName: 'ZHA_ITQ_RQST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_REQUEST'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_REQUEST',
    semanticKey: ['matnr'],
    representativeKey: 'matnr',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_REQUEST
  as select from ZHA_I_REQUEST 
{ 

  key req_id,
      matnr,
      maktx,
      qnt,
      meins,
      zyear,
      zmonth,
      kunnr,
      name1,
      user_who_changed,
      date_changed,
      time_changed,
      lower_name1
}
