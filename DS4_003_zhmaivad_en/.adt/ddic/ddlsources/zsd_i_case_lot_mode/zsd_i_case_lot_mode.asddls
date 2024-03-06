/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHRYSAND     | 26.09.2022 | 13764     : BE: Case Lot - Sales order List Report A *
*              |            | DS4K930674                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 14.09.2023 | 23489     : Development - Case lot app enhancem*
*              |            | DS4K963105                               *
*----------------------------------------------------------------------*
* BATCHVIN     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Case Lot packing mode'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zsd_i_case_lot_mode
  as select from zsd_t_case_lot_h               as CSHeader

    inner join   ZPE_I_HM( iv_id: '0000000561') as HardCode on HardCode.field1 = CSHeader.caselot_pkmode
                                                            or HardCode.field2 = CSHeader.caselot_pkmode
                                                            or HardCode.field3 = CSHeader.caselot_pkmode
                                                            or HardCode.field4 = CSHeader.caselot_pkmode
    inner join   I_SalesDocument                            on CSHeader.vbeln = I_SalesDocument.SalesDocument
{
  CSHeader.vbeln                    as SalesOrder,
  CSHeader.matnr                    as Material,
  CSHeader.werks                    as Plant,
  CSHeader.edatu                    as RequestedDelDate,
  CSHeader.caselot_pkmode           as PackingMode,
  I_SalesDocument.SalesOrganization as SalesOrganization,
  count(*)                          as PackModeSSPandSSSPCount

}
where
  CSHeader.edatu is not initial
group by
  CSHeader.vbeln,
  CSHeader.matnr,
  CSHeader.werks,
  CSHeader.edatu,
  CSHeader.caselot_pkmode,
  I_SalesDocument.SalesOrganization
