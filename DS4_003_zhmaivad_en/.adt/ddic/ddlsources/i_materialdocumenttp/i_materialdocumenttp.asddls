@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Document Interface - TP'
@ObjectModel:{ 
  usageType: {
              serviceQuality: #B, 
              sizeCategory  : #XXL, 
              dataClass     : #TRANSACTIONAL },
              supportedCapabilities: [#TRANSACTIONAL_PROVIDER],
              modelingPattern: #TRANSACTIONAL_INTERFACE 
              }

@VDM.lifecycle.contract.type: #PUBLIC_LOCAL_API
@VDM.viewType: #TRANSACTIONAL  
@Metadata.ignorePropagatedAnnotations: true 
@ObjectModel.sapObjectNodeType.name: 'MaterialDocument'
define root view entity I_MaterialDocumentTP   provider contract transactional_interface
  as projection on R_MATERIALDOCUMENTTP as _MaterialDocument {
    key MaterialDocumentYear,
    key MaterialDocument,
        DocumentDate,
        PostingDate,
        GoodsMovementCode,  
        CreatedByUser,
        CreationDate,
        CreationTime,
        MaterialDocumentHeaderText,
//        ReferenceDocument, ATC
        @Semantics.booleanIndicator
        ManualPrintIsTriggered,
        VersionForPrintingSlip, 
       
       _MaterialDocumentItem: redirected to composition child I_MaterialDocumentItemTP
}
