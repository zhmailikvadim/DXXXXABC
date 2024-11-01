@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'вид образования'
@ObjectModel.resultSet.sizeCategory: #XS



define view entity ZHR_I_EDUC_TYPE_VH_RAP
  as select from zt591s
{
       @UI.hidden: true
       @ObjectModel.text.element: ['Description']
  key  subty as ID,
       @Semantics.text: true
       @EndUserText.label: 'Название вида образования'
       stext as Description

}
where
      sprsl = 'R'
  and infty = '0022'
