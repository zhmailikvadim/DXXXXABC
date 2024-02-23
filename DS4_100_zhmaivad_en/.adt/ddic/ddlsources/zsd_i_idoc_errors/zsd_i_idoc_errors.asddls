/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 29.11.2022 | 13444     : [Build] - Stock reconciliati *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Basic view for IDoc Data'
define view entity zsd_i_idoc_errors
  as select from zsd_i_idoc_header as Header
  association to zsd_i_idoc_item as Item on Header.docnum = Item.docnum
{
  key          docnum                      as IDocNumber,
               Header.ExtStatus            as ExtStatus,
               Header.ExtStatusName        as ErrorName,
               Header.ExtStatusDescription as ErrorDescription,
               Header.IdocCreateDate       as IdocCreateDate,
               Header.IdocCreateTime       as IdocCreateTime,
               Item.Article                as Article,
               Item.Delivery               as DN,
               Item.Quantity               as Quantity,
               Item.Plant                  as Plant,
               Item.Lgort                  as StorageLocation,
               'IDOC'                      as InterfaceType
}
