/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHADDFAD     | 08.12.2022 | 14094: Markdown Validation app,promotions*
*              |            | projection view                          *
*              |            | DS4K932127                               *
*----------------------------------------------------------------------*/

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Promotions Header View'
@Metadata.allowExtensions: true
 
define root view entity ZSD_C_PROMOTIONS_HEADER_VIEW
  provider contract transactional_query
  as projection on ZSD_I_PROMOTIONS_HEADER_VIEW
{
      @ObjectModel.text.element: ['PromotionText']
      @Consumption.valueHelpDefinition: [{ entity : {name: 'I_RetailPromotion', element: 'RetailPromotion'  } }]
      @EndUserText.label: 'Promotion'
  key Promotion,
      @EndUserText.label: 'Promotion Text'
      PromotionText,
      @Semantics.businessDate.from: true
      @EndUserText.label: 'Valid From'
      ValidFrom,
      @Semantics.businessDate.to: true
      @EndUserText.label: 'Valid To'
      ValidTo,
      @EndUserText.label: 'Created On'
      CreatedOn,
      @EndUserText.label: 'Created By'
      CreatedBy,
      @EndUserText.label: 'Currency'
      Currency,
      @ObjectModel.text.element: ['TouchpointText']
      @EndUserText.label: 'Touchpoint'
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_RetailPromotionCustomerType', element: 'RetailPromotionCustomerType' } }]
      Touchpoint,
      @EndUserText.label: 'TouchpointText'
      TouchpointText,
      @EndUserText.label: 'Happy Hours'
      @ObjectModel.text.element: ['MediaTypeText']
      @Consumption.valueHelpDefinition: [{ entity: { name: 'ZSD_I_MEDIATYPE_VH', element: 'MediaType' } }]
      MediaType,
      @EndUserText.label: 'Happy Hours Text'
      MediaTypeText,
      @EndUserText.label: 'Status Crit.'
      Criticality,
      @EndUserText.label: 'Status'
      Status,
      @Search.defaultSearchElement: false
      @EndUserText.label: 'Price Check'
      CRPCheck,
      @EndUserText.label: 'Articles'
      MaterialNumber,
      @EndUserText.label: 'Distribution Channel'
      DistributionChannel,
      @EndUserText.label: 'Sales Organization'
      SalesOrg,
      _Item : redirected to composition child ZSD_C_ARTICLES_ITEM_VIEW
}
