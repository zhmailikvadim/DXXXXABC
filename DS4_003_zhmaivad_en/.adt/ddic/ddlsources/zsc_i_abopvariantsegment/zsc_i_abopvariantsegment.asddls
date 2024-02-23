/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KALSHZHA     | 02.05.2023 | 20252     : Feature - [Build] Event-base *
*              |            | DS4K949975                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ABOP Variant Segments'
@ObjectModel.usageType:{
    serviceQuality: #A,
    sizeCategory: #M,
    dataClass: #MASTER
}
define view entity ZSC_I_ABOPVariantSegment as select from I_ABOPVariantSegment {
     key ABOPVariantSegmentUUID,
     ABOPVariantUUID,
     ABOPSegmentUUID 
}
