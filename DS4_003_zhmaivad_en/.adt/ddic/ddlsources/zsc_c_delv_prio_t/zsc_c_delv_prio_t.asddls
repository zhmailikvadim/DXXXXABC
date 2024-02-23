/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* SRIKAVEN     | 16.08.2022 | 11662     : FB_11662_SC_[Development] STOs additional fields    *
*              |            | DS4K921038                               *
*----------------------------------------------------------------------*
*/

@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.dataCategory: #TEXT
@ObjectModel.representativeKey: 'Code'
@EndUserText.label: 'Text View for Delivery Priority'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZSC_C_DELV_PRIO_T as select from tprit 
association [0..1] to ZSC_C_DELV_PRIO_VH as _Code
     on $projection.Code = _Code.Code
   association [0..1] to I_Language as _Language
     on $projection.Language = _Language.Language{
   @Search.defaultSearchElement: true
 key cast (lprio as abap.char(2))  as Code,
  @Semantics.language: true
   @ObjectModel.foreignKey.association: '_Language'
 key spras as Language,
 @Search.defaultSearchElement: true
   @Semantics.text: true
 bezei as Description   ,
  @ObjectModel.association.type: [#TO_COMPOSITION_ROOT, #TO_COMPOSITION_PARENT]
   _Code,
   _Language
}
