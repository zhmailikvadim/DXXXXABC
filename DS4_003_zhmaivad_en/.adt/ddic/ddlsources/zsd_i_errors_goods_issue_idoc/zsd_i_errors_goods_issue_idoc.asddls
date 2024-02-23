/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 19.03.2023 | 18988     : [Build] - Stock reconciliati *
*              |            | DS4K946765                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 14.04.2023 | 19610     : FB_19610_SD_Feature - DEFECT - Stock Reconciliation *
*              |            | DS4K949060                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 17.04.2023 | 19611     : [Build] - Stock reconciliati *
*              |            | DS4K950069                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Basic view for IDoc Data'
@UI.presentationVariant: [
  {
    sortOrder: [
      {
        by: 'IdocCreateDate',
        direction: #DESC
      },
      {
        by: 'IdocCreateTime',
        direction: #DESC
      }
    ]
  }
]
define view entity zsd_i_errors_goods_issue_idoc
  as select from zsd_i_idoc_header      as Header
    join         zsd_i_idoc_item        as Item                 on Header.docnum = Item.docnum
    join         I_DeliveryDocumentItem as DeliveryDocumentItem on  Item.Delivery     = DeliveryDocumentItem.DeliveryDocument
                                                                and Item.DeliveryItem = DeliveryDocumentItem.DeliveryDocumentItem

{
  key                     rtrim(Item.Article,'' )                                                                          as Article,
  key                     DeliveryDocumentItem.Plant                                                                       as Plant,
  key                     DeliveryDocumentItem.StorageLocation                                                             as StorageLocation,
  key                     Header.IntStatus,
  key                     Header.docnum                                                                                    as IDocNumber,
                          Header.ExtStatus                                                                                 as ExtStatus,
                          Header.ExtStatusName                                                                             as ErrorName,
                          Header.ExtStatusDescription                                                                      as ErrorDescription,
                          Header.IdocCreateDate                                                                            as IdocCreateDate,
                          Header.IdocCreateTime                                                                            as IdocCreateTime,

                          Item.Delivery,
                          Item.DeliveryItem,
                          @Semantics.quantity.unitOfMeasure: 'BaseUnit'
                          cast(case when Item.Quantity = '' then  '0.000' else Item.Quantity end  as abap.quan( 13, 3 )  ) as Quantity,
                          Item.BaseUnit,
                          'IDOC'                                                                                           as InterfaceType
}
