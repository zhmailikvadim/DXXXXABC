/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
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

define view entity zsd_i_calloffqty_rj
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
group by
  line.SalesOrganization,
  item.PrecedingDocument,
  item.PrecedingDocumentItem,
  line.OrderQuantityUnit;
