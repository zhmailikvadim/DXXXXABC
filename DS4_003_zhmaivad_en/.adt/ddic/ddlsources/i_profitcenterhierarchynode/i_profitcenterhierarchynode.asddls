// Comments:
//
// Key fields: please see comment in view I_ProfitCenterHierarchy
// Hierarchy type: determined by view I_ProfitCenterHierarchy, no need to define a filter in this view
//
@EndUserText.label: 'Profit Center Hierarchy Node'
@ObjectModel.representativeKey: 'HierarchyNode'
@ObjectModel: { dataCategory: #HIERARCHY }
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IPRFTCTRHNODE'
@hierarchy.parentChild:
{ recurse:          {     parent: 'ParentNode',     child:  'HierarchyNode'     },
  siblingsOrder:    {     by: 'SequenceNumber',      direction: 'ASC'            },
  directory: '_Hierarchy'  }
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true

@ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET, #ANALYTICAL_DIMENSION ]

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER

@Analytics.dataExtraction.enabled: true

@AccessControl.privilegedAssociations: ['_ControllingAreaText']

define view I_ProfitCenterHierarchyNode
  as select from hrrp_node

  association [0..1] to I_ControllingArea            as _ControllingAreaText on  $projection.ControllingArea = _ControllingAreaText.ControllingArea
  association [0..*] to I_ProfitCenterHierarchyNodeT as _Text                on  $projection.ProfitCenterHierarchy = _Text.ProfitCenterHierarchy
                                                                             and $projection.HierarchyNode         = _Text.HierarchyNode
                                                                             and $projection.ControllingArea       = _Text.ControllingArea
                                                                             and $projection.ProfitCenter          = '' // just to show that this association is only to be followed if profitcenter is blank

  association [0..*] to I_ProfitCenter               as _ProfitCenter        on  $projection.ProfitCenter    = _ProfitCenter.ProfitCenter
                                                                             and $projection.ControllingArea = _ProfitCenter.ControllingArea

  association [1..1] to I_ProfitCenterHierarchy      as _Hierarchy           on  $projection.ProfitCenterHierarchy = _Hierarchy.ProfitCenterHierarchy
                                                                             and $projection.ControllingArea       = _Hierarchy.ControllingArea
                                                                             and $projection.ValidityEndDate       = _Hierarchy.ValidityEndDate //Reviewed


  association [0..1] to I_ControllingArea            as _ControllingArea     on  $projection.ControllingArea = _ControllingArea.ControllingArea

{
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ControllingArea',
                     element: 'ControllingArea' }
        }]
      @ObjectModel.text.association: '_ControllingAreaText'
      @Consumption.filter: {mandatory : true, selectionType : #SINGLE, multipleSelections : false }
      @ObjectModel.foreignKey.association: '_ControllingArea'
  key cast( hrrp_node.nodecls as fis_kokrs )         as ControllingArea,
      @Consumption.filter: {mandatory : true, selectionType : #SINGLE, multipleSelections : false }
      @ObjectModel.foreignKey.association: '_Hierarchy'
  key cast(hrrp_node.hryid as fis_hryid_prctr)       as ProfitCenterHierarchy,
      @ObjectModel.text.association: '_Text'
  key hrrp_node.hrynode                              as HierarchyNode,
      @Semantics.businessDate.to: true
      @Consumption.filter: {mandatory : true, selectionType : #SINGLE, multipleSelections : false }
  key cast(hrrp_node.hryvalto as fis_datbi)          as ValidityEndDate,
      hrrp_node.parnode                              as ParentNode,
      hrrp_node.hryver                               as HierarchyVersion,
      @Semantics.businessDate.from: true
      cast(hrrp_node.hryvalfrom as fis_datab)        as ValidityStartDate,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_ProfitCenterStdVH',
                     element: 'ProfitCenter' },
          additionalBinding: [{ localElement: 'ControllingArea',
                                element: 'ControllingArea' }]
        }]
      @ObjectModel.foreignKey.association: '_ProfitCenter'
      cast ( hrrp_node.leafvalue as fis_prctr )      as ProfitCenter,
      @VDM.lifecycle.status:    #DEPRECATED
      @VDM.lifecycle.successor: 'HierarchyNodeSequence'
      concat(hrrp_node.hryseqnbr, hrrp_node.hrynode) as SequenceNumber, // do not use any longer, use HierarchyNodeSequence
      hrrp_node.hryseqnbr                            as HierarchyNodeSequence,
      hrrp_node.hrylevel                             as HierarchyNodeLevel,
      hrrp_node.nodetype                             as NodeType,
      hrrp_node.nodevalue                            as HierarchyNodeVal,

      _Text,
      _ProfitCenter,
      _Hierarchy,
      _ControllingArea,
      @Consumption.hidden: true
      _ControllingAreaText


}
where
      nodetype          <> 'D'
  and hrrp_node.hrytype =  '0106';
