@AbapCatalog.sqlViewName: 'ZHA_ITQ_TTRL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_TUTORIAL'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_TUTORIALS',
    semanticKey: ['tutorial_id'],
    representativeKey: 'tutorial_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_TUTORIAL
  as select from ZHA_I_TUTORIAL
{

  key tutorial_id,
      tutorial_name,
      link,
      description,
      user_who_changed,
      date_changed,
      time_changed

}
