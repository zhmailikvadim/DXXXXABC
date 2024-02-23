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
@EndUserText.label: 'Demo CDS for Harcode consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPE_I_HM_DEMO_01
  as select from seoclasstx
    inner join   ZPE_I_HM( iv_id: '0000000002' ) on seoclasstx.clsname = ZPE_I_HM.field1
{

  key seoclasstx.clsname  as class_name,
      seoclasstx.descript as description
}
where
  seoclasstx.langu = $session.system_language
