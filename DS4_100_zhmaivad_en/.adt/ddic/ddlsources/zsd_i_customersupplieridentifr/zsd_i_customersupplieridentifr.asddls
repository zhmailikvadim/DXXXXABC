@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@EndUserText.label: 'Customer/Supplier Identifier'
define view entity ZSD_I_CustomerSupplierIdentifr
  as select from    I_DeliveryDocumentItem         as DeliveryDocumentItem
    left outer join I_PurOrdAccountAssignmentAPI01 as PurchaseOrderAccount on  DeliveryDocumentItem.PurchaseOrder     = PurchaseOrderAccount.PurchaseOrder
                                                                           and DeliveryDocumentItem.PurchaseOrderItem = PurchaseOrderAccount.PurchaseOrderItem
    left outer join I_SalesDocument                as SalesDocument        on SalesDocument.SalesDocument = PurchaseOrderAccount.SalesOrder
    left outer join I_CustomerSalesArea            as SalesArea            on  SalesArea.Customer            = SalesDocument.SoldToParty
                                                                           and SalesArea.SalesOrganization   = SalesDocument.SalesOrganization
                                                                           and SalesArea.DistributionChannel = SalesDocument.DistributionChannel
                                                                           and SalesArea.Division            = SalesDocument.OrganizationDivision
    left outer join I_Product                      as Product              on DeliveryDocumentItem.Material = Product.Product

{
  key DeliveryDocumentItem.DeliveryDocument,
  key DeliveryDocumentItem.DeliveryDocumentItem,
  key 'Y'                     as AccountAssignmenCategory,
      DeliveryDocumentItem.Plant,
      DeliveryDocumentItem.Material,
      Product.zz_fsh_sc_mid   as MaterialConversionID,
      SalesArea.ZZ_fsh_sc_cid as CustomerSupplierIdentifier

}

union select from I_DeliveryDocumentItem as DeliveryDocumentItem
  left outer join I_Plant                as Plant     on DeliveryDocumentItem.Plant = Plant.Plant

  left outer join I_CustomerSalesArea    as SalesArea on  SalesArea.SalesOrganization   = Plant.SalesOrganization
                                                      and SalesArea.DistributionChannel = Plant.DistributionChannel
                                                      and SalesArea.Division            = Plant.Division
                                                      and SalesArea.SupplyingPlant      = Plant.Plant
  left outer join I_Product              as Product   on DeliveryDocumentItem.Material = Product.Product
{
  key  DeliveryDocumentItem.DeliveryDocument,
  key  DeliveryDocumentItem.DeliveryDocumentItem,
  key  'N'                     as AccountAssignmenCategory,
       DeliveryDocumentItem.Plant,
       DeliveryDocumentItem.Material,
       Product.zz_fsh_sc_mid   as MaterialConversionID,
       SalesArea.ZZ_fsh_sc_cid as CustomerSupplierIdentifier

}
