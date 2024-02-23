/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Params for Stock Snapshot'
define abstract entity zsd_d_stock_snapshot_params
{
  @Consumption.valueHelpDefinition: [{ entity : { name : 'zsd_c_plant_valuehelp', element : 'Plant'}}]
  @Consumption.filter:{ selectionType:#INTERVAL,multipleSelections: true}
  @EndUserText.label: 'Plant'
  plant            : zsd_snapshot_plant;
  @Consumption.valueHelpDefinition: [{ entity : { name    : 'zsd_c_st_location_valuehelp',
                                                element : 'Lgort'}
                                  }]
  @EndUserText.label: 'Storage Location'
  storage_location : zsd_snapshot_sloc;
}
