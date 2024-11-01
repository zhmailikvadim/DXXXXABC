@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'вид образования'
@ObjectModel.dataCategory: #TEXT
@UI.textArrangement: #TEXT_FIRST

define view entity ZHR_I_EDUC_TYPE_VH_RAP
  as select from zt591s
{
       @ObjectModel.text.element: ['Description']
  key  subty as ID,
       @EndUserText.label: 'Название вида образования'
       stext as Description

}
where
      sprsl = 'R'
  and infty = '0022' 
 