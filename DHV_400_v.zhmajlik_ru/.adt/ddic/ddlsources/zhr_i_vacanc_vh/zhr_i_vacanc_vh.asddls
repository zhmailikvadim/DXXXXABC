@AbapCatalog.sqlViewName: 'ZHRIVACANCVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Вакансии'
@Search.searchable: true

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST
define view ZHR_I_VACANC_VH
  as select from zhr_vacans_vh
{
          @EndUserText.label: 'Вакансии'
          @Search.defaultSearchElement: true
          @Search.fuzzinessThreshold: 0.8
          @Search.ranking: #HIGH
  key     name_vacanc                                      as NameVacanc,
          @UI.hidden: true
          @ObjectModel.text.element: ['NameVacanc']
          objid                                            as Objid,

          @EndUserText.label: 'Адрес'
          city                                             as City,
          @EndUserText.label: 'Предприятие'
          orgname                                          as Orgname,
          @UI.hidden: true
          @EndUserText.label: 'Горящая вакансия'
          hot_job                                          as HotJob,
          @EndUserText.label: 'Горящая вакансия'
          case hot_job when 'X' then 'Горящая' else '' end as job
}
where
      start_date <= $session.system_date
  and end_date   >= $session.system_date 
 