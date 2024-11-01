@AbapCatalog.sqlViewName: 'ZHRIFACTORYVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Предприятие'

@UI.presentationVariant: [
  {
    sortOrder: [
      {
        by: 'Description',
        direction: #ASC
      }
    ]
  }
]

@OData.publish: true
@UI.textArrangement: #TEXT_ONLY

define view ZHR_I_FACTORY_VH
  as select from zhr_c_org_recr
{
             @UI.hidden: true
             @ObjectModel.text.element: ['Description']
  key        orgid  as ID,
             @EndUserText.label: 'Название предприятия'
             orgname                                                                       as Description



} 
 