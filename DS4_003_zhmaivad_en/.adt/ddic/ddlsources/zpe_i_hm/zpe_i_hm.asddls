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
* CANOCAR      | 22.06.2022 | 11751: Feature pack 22-2-6               *
*              |            | DS4K921477                               *
*----------------------------------------------------------------------*
*/

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Hardcode Manager'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPE_I_HM
  with parameters
    iv_id :zpe_hm_id
  as select from zpe_t_hm_d
{
  key id,
  key sequence,
      field1,
      field2,
      field3,
      field4,
      field5
}
where
  id = $parameters.iv_id
