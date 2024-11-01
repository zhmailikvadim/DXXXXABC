@EndUserText.label: 'Functional Area'
@Analytics:{
    dataCategory: #DIMENSION,
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IFIFUNCAREA'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.representativeKey: 'FunctionalArea'
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
  dataClass: #CUSTOMIZING,
  serviceQuality: #A,
  sizeCategory: #S
}
@AbapCatalog.buffering:{
  status: #ACTIVE,
  type: #FULL
}
@AbapCatalog.preserveKey:true
define view I_FunctionalArea
  as select from tfkb
  association [0..*] to I_FunctionalAreaText          as _Text                        on $projection.FunctionalArea = _Text.FunctionalArea
  association [0..*] to I_FunctionalAreaHierNode as _FunctionalAreaHierarchyNode on $projection.FunctionalArea = _FunctionalAreaHierarchyNode.FunctionalArea

{
      @ObjectModel.text.association: '_Text'
      @ObjectModel.hierarchy.association: '_FunctionalAreaHierarchyNode'
  key fkber as FunctionalArea,
      _Text,
      _FunctionalAreaHierarchyNode
}
