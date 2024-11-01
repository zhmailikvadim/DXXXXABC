@AbapCatalog.sqlViewName: 'ZHA_ITQ_CNT_GRP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Transaction CDS for ZHA_I_CONT_GROUP'

@ObjectModel:{
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZHA_D_CONT_GROUP',
    semanticKey: ['cont_gr_id'],
    representativeKey: 'cont_gr_id',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view ZHA_I_T_CONT_GROUP
  as select from ZHA_I_CONT_GROUP
//   association[0..*] to ZHA_I_T_CONTACT as _contactData on $projection.cont_gr_id = _contactData.cont_gr_id
{
  key cont_gr_id,
      cont_gr_name,
      struct_division,
      description
}
