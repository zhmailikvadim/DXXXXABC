@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Vas Lead times'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_zhm_vas_lead_time
  as select from zsd_t_vas_lt
{
  key zvstel     as Zvstel,
  key zvas_code  as ZvasCode,
  key zdatab     as Zdatab,
      zlead_time as ZleadTime,
      created_on as CreatedOn,
      created_at as CreatedAt,
      created_by as CreatedBy,
      changed_on as ChangedOn,
      changed_at as ChangedAt,
      changed_by as ChangedBy
}
