/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* GUPTANI1     | 30.08.2022 | 11675  : BE Dev - Case Lot Management App*
*              |            | DS4K921270                              *
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
************************************************************************
* NAGARSOW     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Projection View Case Lot Item'

@Metadata.allowExtensions: true
@Search.searchable: true


define view entity ZSD_C_CASE_LOT_I
  as projection on zsd_i_case_lot_i
{

  key CaselotHUUID,
  key CaselotIUUID,
      CaselotItem,
      @UI.hidden: true
      SalesDocumentType,
      @UI.hidden: true
      SalesOrganization,
      @UI.hidden: true
      DistributionChannel,
      @UI.hidden: true
      Division,
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Variant Material'
      Material,
      TotalOrderQuantityUnit,
      OrderQuantity,
      ConfdQuantity,
      CaseLotQuantity,
      @EndUserText.label: 'CL Total Qty'
      CLTotalQty,
      ChangedAt,
      @EndUserText.label: 'Check'
      Checkqty,
      Criticality,
      @UI.hidden: true
      PBFieldControlI,
      HigherLevelItem,
      SalesOrderItem,
      ScheduleLine,
      ConfirmedDeliveryDate,
      /* Associations */
      _CaseLotHeader : redirected to parent ZSD_C_CASE_LOT_H

}
