/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHRYSAND     | 07.11.2022 | 14975     : [BUILT] Factory downtime calendar - New *
*              |            | DS4K934846                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Factory downtime calendar: Consumption View'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity zpd_c_downtime_calendar
  provider contract transactional_query
  as projection on zpd_i_downtime_calendar
{
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zpd_i_downtime_factory_cust',
                                                      element: 'Factory' } } ]
  key  Factory,

       @Consumption.filter: { selectionType: #INTERVAL, multipleSelections: false }
  key  FromDate,
       @Consumption.filter: { selectionType: #INTERVAL, multipleSelections: false }
  key  ToDate,
       _Factory.FactoryName as FactoryName,
       Description,
       CreatedBy,
       CreatedOn,
       ChangedBy,
       ChangedOn
}
