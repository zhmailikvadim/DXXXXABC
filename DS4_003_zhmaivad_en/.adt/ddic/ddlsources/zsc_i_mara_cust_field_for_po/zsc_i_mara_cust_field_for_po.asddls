/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 01.09.2022 | FB_13368_SC_[Build] - STO division
*              |            | DS4K928951                               *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 20.02.2023 | 16938     : Feature - [Build][CR 20167]  *
*              |            | DS4K940559                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Custom fields for PO'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZSC_I_MARA_CUST_FIELD_FOR_PO
  as select from mara
{
  key matnr,
      fsh_mg_at1
}
