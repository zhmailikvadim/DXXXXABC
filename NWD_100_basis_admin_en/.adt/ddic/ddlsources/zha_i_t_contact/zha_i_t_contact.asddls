@AbapCatalog.sqlViewName: 'ZHA_ITQ_CNTCT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_CONTACT'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_CONTACT',
    semanticKey: ['contact_id'],
    representativeKey: 'contact_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true 
}

define view ZHA_I_T_CONTACT
  as select from ZHA_I_CONTACT
//  association [1..1] to ZHA_I_T_CONT_GROUP as _cont_grData on $projection.cont_gr_id = _cont_grData.cont_gr_id
{
 
  key contact_id,
      contact_name,
      contact_position,
      cont_gr_name,
      struct_division,
      telephon,
      e_mail,
      user_who_changed,
      date_changed,
      time_changed

}
 