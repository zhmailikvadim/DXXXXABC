@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Справочник Ученая степень'
@ObjectModel.resultSet.sizeCategory: #XS

define view entity ZHR_I_DEGREE_VH_RAP
  as select from t535n
{
         @UI.hidden: true
         @ObjectModel.text.element: ['Name']
  key    titel  as Id,
         @EndUserText.label: 'Ученая степень'
         ttout   as Name
} 
 where art = 'T' 
 