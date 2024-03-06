/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CHUTLGIO     | 14.06.2022 | 11280     : BE Dev - Case Lot data structure, fields *
*              |            | DS4K919167                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Order Unit Of Measure View Entity'
define view entity zsd_i_so_uom
as select from vbap
{
   key vbeln as SalesOrder,
   key matnr as Material,
   key werks as Plant, 
   key vrkme as UOM
       
}
    group by
        vbeln,
        matnr,
        werks,
        vrkme
