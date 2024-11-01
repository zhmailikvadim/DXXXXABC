@AbapCatalog.sqlViewName: 'ZEHS_UNL'
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true
@EndUserText.label: 'Выгрузка объектов мониторинга'
//@Analytics:{ dataExtraction.enabled: true, query: true }
@ObjectModel.representativeKey: 'db_key'
@Metadata.allowExtensions: true
@UI: {
  headerInfo: { typeName: 'Записи',
                typeNamePlural: 'Записи'
               } }

@OData.publish: true
define view zehs_c_unload_om
  as select from zehs_i_unload_om
  // association [0..1] to zehs_i_struct_unit_vh as _StructUnitVH on $projection.butxt = _StructUnitVH.butxt
{
  key db_key,
  key PointDbKey,
  key mandt,


      @EndUserText.label: 'Обособленное подразделение'
      //   @AnalyticsDetails.query.axis: #COLUMNS
      @Search: { defaultSearchElement: true }
      //   @AnalyticsDetails.query.sortDirection: #DESC
      //  @Consumption.valueHelp: '_StructUnitVH'
      //   @ObjectModel.foreignKey.association: '_StructUnitVH'
      butxt,
      @Search: { defaultSearchElement: true, ranking: #MEDIUM, fuzzinessThreshold: 0.9 }
      //@Consumption.valueHelp: '_StructUnitVH'
      org_unit,
      @EndUserText.label: 'Структурное подразделение'
      @Search: { defaultSearchElement: true, fuzzinessThreshold: 0.9 }
      //  @Consumption.valueHelp: '_StructUnitVH'
      name_org,
      @EndUserText.label: 'Объект мониторинга'
      @Search: { defaultSearchElement: true }
      name_om,
      @EndUserText.label: 'Точка контроля'
      @Search: { defaultSearchElement: true }
      name_tk,
      @EndUserText.label: 'Способ идентификации'
      @Search: { defaultSearchElement: true }
      zz_kindc,
      @Search: { defaultSearchElement: true }
      zz_kind,
      @Search: { defaultSearchElement: true }
      zz_pkind,
      @Search: { defaultSearchElement: true }
      zz_nfc_fixed
      //  _StructUnitVH

} 
 