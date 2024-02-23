/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZUJSKAS      | 18.01.2023 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Call-off quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_CallOffQty
  as select from I_SDDocumentMultiLevelProcFlow as item
    inner join   I_SalesDocumentItem            as line on  item.SubsequentDocument     = line.SalesDocument
                                                        and item.SubsequentDocumentItem = line.SalesDocumentItem

{
  key item.PrecedingDocument     as SalesDocument,
  key item.PrecedingDocumentItem as SalesDocumentItem,
      line.SalesOrganization,
      @Semantics.quantity.unitOfMeasure: 'CallOffQuantityUnit'
      sum(line.OrderQuantity)    as CallOffQuantity,
      line.OrderQuantityUnit     as CallOffQuantityUnit

}
where
      item.SubsequentDocumentCategory = 'C'
  and item.PrecedingDocumentCategory  = 'G'
  and line.SalesDocumentRjcnReason    = ''
group by
  line.SalesOrganization,
  item.PrecedingDocument,
  item.PrecedingDocumentItem,
  line.OrderQuantityUnit;
