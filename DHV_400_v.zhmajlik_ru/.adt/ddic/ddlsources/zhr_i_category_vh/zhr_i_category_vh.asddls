@AbapCatalog.sqlViewName: 'ZHRICATEGORYVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Категории ВУ'

@OData.publish: true
@UI.textArrangement: #TEXT_FIRST

define view ZHR_I_CATEGORY_VH
  as select from zhr_category
{
          @EndUserText.label: 'Категория'
  key     name as name,
          @UI.hidden: true
          id   as id


} 
 