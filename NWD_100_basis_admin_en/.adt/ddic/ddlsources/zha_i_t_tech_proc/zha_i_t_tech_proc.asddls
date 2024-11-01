@AbapCatalog.sqlViewName: 'ZHA_ITQ_TCH_PRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_TECH_PROC'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_TECH_PROC',
    semanticKey: ['tech_proc_id'],
    representativeKey: 'tech_proc_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_TECH_PROC
  as select from ZHA_I_TECH_PROC
{
  key tech_proc_id,
      tech_proc_name,
      model,
      tech_proc_date,
      link,
      tech_proc_number,
      description,
      user_who_changed,
      date_changed,
      time_changed      
}
