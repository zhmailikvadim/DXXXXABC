/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@EndUserText.label: 'Projection view for Sales Order List'
@AccessControl.authorizationCheck: #CHECK
@UI.presentationVariant: [{ visualizations: [{type: #AS_LINEITEM }],
                            requestAtLeast: [ 'Disablecreatebyauth' ]}]
define root view entity ZSD_C_SALESORDER_RDDPRO
  provider contract transactional_query
  as projection on zsd_c_salesorder_rdd
{
  key          SalesOrder,
  key          IsSSPorSSSPmode,
  key          GenericMaterial as Material,
  key          Plant,
  key          SalesOrderflag,
  key          SDDocumentCategory,
               @EndUserText.label: 'Disable by auth'
               @ObjectModel.virtualElement: true
               @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SD_VE_CASELOT_AUTHCHK'
  virtual      Disablecreatebyauth : abap.char( 1 ),
               RequestedDelDate,
               ConfirmedDeliveryDate,
               SalesDocType,
               DistributionChanel,
               Division,
               HigherLevelItem,
               SalesOrderItem,
               ScheduleLineNumber,
               TotalOrderQty,
               TotalOrderQuantityUnit_1,
               QuantityUnit_2,
               ReferenceSalesOrder,
               PurchaseOrderNumber,
               CaseLotExists,
               CaseLotStatusCriticality,
               SalesOrderStatus,
               ConfirmedQtyStatus,
               ConfirmedQty_4,
               SoldToParty,
               SalesOrganization,
               ArticleDescription,
               PlantName,
               SalesOrganizationDescription,
               caselotno,
               CaseLotStatus,
               PackingMode,
               DeliveryStatus,
               /* Associations */
               _GenericArticleVH,
               _PlantVH,
               _PurOrdAccountAssignment,
               _SalesDocTypeVH,
               _SalesOrder
}
