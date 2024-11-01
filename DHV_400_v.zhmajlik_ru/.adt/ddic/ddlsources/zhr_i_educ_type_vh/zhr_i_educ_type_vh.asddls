@AbapCatalog.sqlViewName: 'ZHREDUCTYPVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'вид образования'

//@OData.publish: true
@UI.textArrangement: #TEXT_ONLY

define view ZHR_I_EDUC_TYPE_VH
  as select from zt591s
{
       @UI.hidden: true
       @ObjectModel.text.element: ['Description']
  key  subty as ID,
       @EndUserText.label: 'Название вида образования'
       stext as Description

}
where
      sprsl = 'R'
  and infty = '0022' 
 