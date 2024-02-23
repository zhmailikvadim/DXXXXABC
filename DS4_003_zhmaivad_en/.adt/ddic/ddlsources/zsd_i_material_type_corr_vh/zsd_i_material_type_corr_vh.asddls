/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.09.2022 | 13444     : [Build] - Stock reconciliation with WMS *
*              |            | DS4K929106                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Difference Material Group'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity zsd_i_material_type_corr_vh
  as select distinct from zsd_i_stock_corr_rprt
  association to I_ProductTypeText_2 as _MaterialTypeTexts on  $projection.MaterialType    = _MaterialTypeTexts.ProductType
                                                           and _MaterialTypeTexts.Language = $session.system_language
{
       @EndUserText.label: 'Material Type'
  key  MaterialType,
       @EndUserText.label: 'Material Type Description'
       _MaterialTypeTexts.ProductTypeName
}
