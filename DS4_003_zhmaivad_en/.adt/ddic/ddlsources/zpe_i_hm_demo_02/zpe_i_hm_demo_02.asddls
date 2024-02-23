/*
*************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CANOCAR      | 14.02.2022 | 9407      : Hardcode Manager             *
*              |            | DS4K900411                               *
*----------------------------------------------------------------------*
*/

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Demo CDS for Business Switch'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPE_I_HM_DEMO_02
  as select from t001
    inner join   ZPE_I_HM_BS( iv_id: '0000000015' ) on t001.bukrs = ZPE_I_HM_BS.field1
{

  key t001.bukrs,
      t001.butxt

}
