/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* GUPTANI1     | 30.08.2022 | 11675  : BE Dev - Case Lot Management App*
*              |            | DS4K921270                              *
*----------------------------------------------------------------------*
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 19.09.2023 | 23489     : BE: Case Lot -Enhancement *
*              |            | DS4K963105                               *
*----------------------------------------------------------------------*
* BATCHVIN     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View Case Lot Header'
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED }
define root view entity ZSD_C_CASE_LOT_H
  provider contract transactional_query
  as projection on zsd_i_case_lot_h
{

  key CaseLotHUUID,

      SalesOrder,
      @UI.hidden: true
      SalesDocumentType,
      @UI.hidden: true
      SalesOrganization,
      @UI.hidden: true
      DistributionChannel,
      @UI.hidden: true
      Division,
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['CaseLotText']

      @Consumption.valueHelpDefinition: [{entity : { name: 'ZSD_I_CASELOT_VH' , element: 'CaseLotNumber' } } ]
      CaselotNo,

      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_satnr_vh',
                                                          element: 'GenericArticle' } }]
      Material,

      @Search.defaultSearchElement: true
      @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_plant_vh',
                                                 element: 'Plant' } }]
      Plant,

      @Search.defaultSearchElement: true
      RequestedDelDate,

      NumberOfMPB,
      NumberOfMPBPerCnt,

      @Consumption.valueHelpDefinition: [{ entity : {name: 'ZSD_I_PCKNG_MODE', element: 'pkmode'  } }]
      PackingMode,
      CaseLotText,
      TotalActualQty,
      TotalConfirmedQty,
      TotalOrderQuantityUnit,
      NumberOfUnits,
      TotalQtyPerCtn,
      ChangedAt,
      PBFieldControl,
      TotalQuantity,
      CaseLotStatus,
      @UI.hidden: true
      vascutoffflag,
      @UI.hidden: true
      DeliveryStatus,
      SDDocumentCategory,
      /* Associations */

      _CaseLotItem : redirected to composition child ZSD_C_CASE_LOT_I,
      _Pckngmode,
      _SalesOrder

}
