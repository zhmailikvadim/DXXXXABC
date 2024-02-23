@AbapCatalog.viewEnhancementCategory: [#NONE]
@EndUserText.label: 'RAP MATDOC Header'
@AccessControl: {
                    authorizationCheck: #CHECK,
                    personalData.blocking: #NOT_REQUIRED,
                    privilegedAssociations: ['_User']
                 }
@ObjectModel: {
                usageType: {
                             sizeCategory: #XXL,
                             serviceQuality: #B,
                             dataClass:#TRANSACTIONAL
                           },
                           sapObjectNodeType.name: 'MaterialDocument'
               }
@VDM: {
        viewType: #TRANSACTIONAL,
        lifecycle.contract.type: #SAP_INTERNAL_API
      }
define root view entity R_MaterialDocumentTP
  as select from P_MaterialDocumentHeader

composition [1..*] of R_MaterialDocumentItemTP as _MaterialDocumentItem
{
  key MaterialDocumentYear,
  key MaterialDocument,
      MaterialDocumentHeaderText,
  
      PostingDate,
      DocumentDate,
      
      
      TransactionCode,     
      GoodsMovementCode,

      AccountingDocumentType,
      InventoryTransactionType,      
      
      CreatedByUser,
      CreationDate,
      CreationTime,
      
//      ReferenceDocument,
      CtrlPostgForExtWhseMgmtSyst,
      ManualPrintIsTriggered,
      VersionForPrintingSlip,
      

      //associations
      _MaterialDocumentItem,
      _MaterialDocumentYear,

      _User
}
