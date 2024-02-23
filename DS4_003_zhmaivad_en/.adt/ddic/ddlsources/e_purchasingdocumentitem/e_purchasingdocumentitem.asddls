@ObjectModel.usageType.dataClass: #TRANSACTIONAL
@ObjectModel.usageType.serviceQuality: #A 
@ObjectModel.usageType.sizeCategory: #L
@AbapCatalog.sqlViewName: 'EMMPURDOCITM'
@VDM.viewType: #EXTENSION
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY 
@EndUserText.label: 'Extension view for Purchasing Document Item'
define view E_PurchasingDocumentItem as select from ekpo as Persistence {
  key Persistence.ebeln as PurchasingDocument,
  key Persistence.ebelp as PurchasingDocumentItem
}   
 