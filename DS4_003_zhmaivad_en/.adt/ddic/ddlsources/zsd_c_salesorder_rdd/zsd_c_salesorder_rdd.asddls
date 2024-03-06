/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CHUTLGIO     | 30.06.2022 | 11280     : BE Dev - Case Lot data structure, fields *
*              |            | DS4K919167                               *
*----------------------------------------------------------------------*
* KHRYSAND     | 17.11.2022 | 13764     : BE: Case Lot - Sales order List Report A *
*              |            | DS4K930674                               *
*----------------------------------------------------------------------*
************************************************************************
* SRIKAVEN     | 12.01.2023 | 15915     : BE: Case Lot -Enhancement *
*              |            | DS4K937372                               *
*----------------------------------------------------------------------*
* SRIKAVEN     | 26.04.2023 | 20611     : BE: Case Lot -Enhancement *
*              |            | DS4K950721                               *
*----------------------------------------------------------------------*
* BATCHVIN     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*
* NAGARSOW     | 13.03.2024 | 29721     :[CR] - Case Lot Minor         *
*                                         Enhancements                 *
*              |            | DS4K982272                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Order list connected with Case Lots'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity zsd_c_salesorder_rdd
  as select from zsd_i_salesorder_rdd_group
  association [0..1] to I_SalesOrder            as _SalesOrder              on _SalesOrder.SalesOrder = $projection.SalesOrder
  association [0..*] to ZSD_I_PurOrd            as _PurOrdAccountAssignment on _PurOrdAccountAssignment.Salesorder = $projection.SalesOrder
  association [0..1] to zsd_i_sales_doc_type_vh as _SalesDocTypeVH          on _SalesDocTypeVH.SalesDocType = $projection.SalesDocType
  association [0..1] to zsd_i_satnr_vh          as _GenericArticleVH        on _GenericArticleVH.GenericArticle = $projection.GenericMaterial
  association [0..1] to zsd_i_plant_vh          as _PlantVH                 on _PlantVH.Plant = $projection.Plant

{
       @EndUserText.label: 'Sales Order'
  key  SalesOrder,
  key  case when PackModeSSPandSSSPCount > 0 then 'True'
            else 'False'
            end                                                                                            as IsSSPorSSSPmode,
       @EndUserText.label: 'Generic Article'
       @ObjectModel.text.element: ['ArticleDescription']
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_satnr_vh',
                                                      element: 'GenericArticle' } }]
  key  GenericMaterial,
       @ObjectModel.text.element: ['PlantName']
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_plant_vh',
                                                      element: 'Plant' } }]
  key  Plant,
       @EndUserText.label: 'Flag'
  key  SalesOrderflag                                                                                      as SalesOrderflag,
  key  SDDocumentCategory                                                                                  as SDDocumentCategory,
       @EndUserText.label: 'Requested Delivery Date'
       @Consumption.filter: { selectionType: #INTERVAL, multipleSelections: false }
       RequestedDelDate,
       @EndUserText.label: 'Confirmed Delivery Date'
       @Consumption.filter: { selectionType: #INTERVAL, multipleSelections: false }
       ConfirmedDeliveryDate,
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_sales_doc_type_vh',
                                                      element: 'SalesDocType' } }]
       @EndUserText.label: 'Sales Doc Type'
       SalesDocType,
       @Consumption.valueHelpDefinition: [{ entity: { name:    'ZSC_C_SALES_CHANNEL_VH',
                                                      element: 'Code' } }]
       DistributionChanel,
       @UI.hidden: true
       Division,
       HigherLevelItem,
       SalesOrderItem,
       ScheduleLineNumber,
       @Semantics.quantity.unitOfMeasure : 'QuantityUnit_2'
       @EndUserText.label: 'Total Order Qty'
       TotalOrderQty,
       TotalOrderQuantityUnit_1,
       QuantityUnit_2,
       @EndUserText.label: 'Reference Sales Order'
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_customer_ref_vh',
                                                      element: 'PurchaseOrderByCustomer' } }]
       _SalesOrder.PurchaseOrderByCustomer                                                                 as ReferenceSalesOrder,
       @EndUserText.label: 'Purchase Order'
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_case_lot_po_vh',
                                                      element: 'PurchaseOrder' } }]
       _PurOrdAccountAssignment.PurchaseOrder                                                              as PurchaseOrderNumber,
       @EndUserText.label: 'Case Lot Exists'
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_case_lot_exist_vh',
                                                      element: 'CaseLotExists' } }]
       CaseLotExists,
       case when CaseLotExists = 'Yes' and CaseLotStatus = 'S'  then 'Success'
            when CaseLotExists = 'Yes' and CaseLotStatus = 'E'  then 'Error'
            else 'None'
            end                                                                                            as CaseLotStatusCriticality,
       case when TotalConfirmedQty_SSP = ConfirmedQty_4 and TotalConfirmedQty_MSP is initial then 'Success'
            when TotalConfirmedQty_MSP = ConfirmedQty_4 then 'Success'
            else 'Error'
            end                                                                                            as SalesOrderStatus,
       case when TotalOrderQty = 0                                                            then 0
            when ConfirmedQty_4 / TotalOrderQty =  1                                          then 3
            when ConfirmedQty_4 / TotalOrderQty >= 0.8 and ConfirmedQty_4 / TotalOrderQty < 1 then 2
            else 1
            end                                                                                            as ConfirmedQtyStatus,
       @Semantics.quantity.unitOfMeasure : 'TotalOrderQuantityUnit_1'
       @EndUserText.label: 'Confirmed Qty'
       ConfirmedQty_4,
       _SalesOrder.SoldToParty,

       @EndUserText.label: 'Sales Organisation'
       @ObjectModel.text.element: ['SalesOrganizationDescription']
       @Consumption.valueHelpDefinition: [{ entity: { name:    'zsd_i_sales_organization_vh',
                                                      element: 'SalesOrganization' } }]
       _SalesOrder.SalesOrganization                                                                       as SalesOrganization,
       _GenericArticleVH.GenericArticleDescription                                                         as ArticleDescription,
       _PlantVH.PlantName                                                                                  as PlantName,
       _SalesOrder._SalesOrganization._Text[1: Language = $session.system_language ].SalesOrganizationName as SalesOrganizationDescription,
       _SalesOrder,
       _PurOrdAccountAssignment,
       _SalesDocTypeVH,
       _GenericArticleVH,
       _PlantVH,
       caselotno,
       @EndUserText.label: 'Case Lot Status'
       @Consumption.valueHelpDefinition: [{ entity: { name:    'ZSD_I_CASE_LOT_STATUS',
                                                      element: 'caselotstatus' } }]
       CaseLotStatus,
       @EndUserText.label: 'Packing Mode'
       @Consumption.valueHelpDefinition: [{ entity : {name: 'ZSD_I_PCKNG_MODE', element: 'pkmode'  } }]
       PackingMode,
       @EndUserText.label: 'Delivery Status'
       DeliveryStatus
}
