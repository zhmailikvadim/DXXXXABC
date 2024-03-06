@Analytics.technicalName: 'IPASQNC_ASSGMTTP'
@EndUserText.label: 'Product Allocation Sequence Assignment'
                                                    
                                                    
@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #NOT_REQUIRED //or #CHECK
@Search.searchable: true
                                
                                
                                
@ObjectModel.semanticKey: ['ProductAllocationSequence', 'Material', 'Plant']
@ObjectModel.representativeKey: 'ProdAllocSqncAssignmentUUID'
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #M
@ObjectModel.usageType.dataClass: #MASTER
@Metadata.ignorePropagatedAnnotations: true

define view entity I_ProdAllocSqncAssgmtTP
  as select from I_ProdAllocSequenceAssignment as Document
  association to parent I_ProdAllocationSequenceTP as _ProdAllocationSequenceTP on  _ProdAllocationSequenceTP.ProductAllocationSequenceUUID = $projection.ProductAllocationSequenceUUID                                                                            
  association [0..1] to I_Material                 as _Material                 on  _Material.Material = $projection.Material
  association [0..1] to I_Plant                    as _Plant                    on  _Plant.Plant = $projection.Plant
  association [0..1] to I_TimeZone                 as _ValidityStartTimeZone    on  _ValidityStartTimeZone.TimeZoneID = $projection.ValidityStartTimeZone
  association [0..1] to I_TimeZone                 as _ValidityEndTimeZone      on  _ValidityEndTimeZone.TimeZoneID = $projection.ValidityEndTimeZone
{
  key Document.ProdAllocSqncAssignmentUUID,
                                 
      @ObjectModel.foreignKey.association: '_ProdAllocationSequenceTP'
      Document.ProductAllocationSequenceUUID,
                                 
      @Search.defaultSearchElement: true
      Document.ProductAllocationSequence,
                                                      
      @ObjectModel.foreignKey.association: '_Material'
      @Search.defaultSearchElement: true
      Document.Material,
      @Search.defaultSearchElement: true
      @ObjectModel.foreignKey.association: '_Plant'
                                                      
      Document.Plant,
      Document.ValidityStartUTCDateTime,
      @ObjectModel.foreignKey.association: '_ValidityStartTimeZone'
      Document.ValidityStartTimeZone,
      Document.ValidityEndUTCDateTime,
      @ObjectModel.foreignKey.association: '_ValidityEndTimeZone'
      Document.ValidityEndTimeZone,
                                 
      Document.IsDeleted,
                                                                                     
      _ProdAllocationSequenceTP,

      _Material,

      _Plant,

      _ValidityStartTimeZone,

      _ValidityEndTimeZone 

}                
  
  
  
  
  
  
  
  
  
  
 
