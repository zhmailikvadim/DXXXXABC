/***********************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KONRANAR     | 31.10.2023 | 26244 : HU CR 63689                      *
*              |            | DS4K968189                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'STO UD Messages'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSD_I_STO_UD_Message as select from zsd_t_sto_ud_msg
    association [1..1] to I_PurchaseOrderAPI01          as _PurchaseOrder            on  $projection.UnderDeliveredSto = _PurchaseOrder.PurchaseOrder
{
    key under_delivered_sto as UnderDeliveredSto,
    key under_delivered_sto_item as UnderDeliveredStoItem,
    key under_delivered_dn as UnderDeliveredDn,
    key under_delivered_dn_item as UnderDeliveredDnItem,
    key step as Step,
    key msg_id as MsgId,
    key msg_no as MsgNo,
    msg_type as MsgType,
    msg_text as MsgText,
    message_v1 as MessageV1,
    message_v2 as MessageV2,
    message_v3 as MessageV3,
    message_v4 as MessageV4,
    creation_date as CreationDate,
    creation_time as CreationTime,
    _PurchaseOrder
}
