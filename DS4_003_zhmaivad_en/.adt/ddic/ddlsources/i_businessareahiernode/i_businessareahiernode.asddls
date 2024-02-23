@EndUserText.label: 'BusinessArea Hier Node'
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IFIBUSAHN'
@Hierarchy.parentChild:
{ recurse:          {   parent: 'ParentNode',   child:  'HierarchyNode'   },
  siblingsOrder:    {   by: 'HierarchyNodeSequence',    direction: 'ASC'   },
  directory:        '_Hierarchy'
  }
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'HierarchyNode'
@ObjectModel.modelingPattern: #ANALYTICAL_PARENT_CHILD_HIERARCHY_NODE
@ObjectModel.supportedCapabilities: #ANALYTICAL_PARENT_CHILD_HIERARCHY_NODE
@AbapCatalog.compiler.compareFilter:true
@Metadata.ignorePropagatedAnnotations:true
@AbapCatalog.preserveKey:true
@ObjectModel: {usageType: {
  dataClass: #MASTER,
  serviceQuality: #A,
  sizeCategory: #XL},
  dataCategory: #HIERARCHY
}

define view I_BusinessAreaHierNode
  as select from hrrp_node


  association [0..*] to I_BusinessAreaHierNodeT as _Text         on  $projection.BusinessAreaHierarchy = _Text.BusinessAreaHierarchy
                                                                 and $projection.HierarchyNode         = _Text.HierarchyNode
                                                                 and $projection.BusinessArea          = '' // just to show that this association is only to be followed if FunctionalArea is blank

  association [0..1] to I_BusinessArea          as _BusinessArea on  $projection.BusinessArea = _BusinessArea.BusinessArea

  association [1..1] to I_BusinessAreaHierarchy as _Hierarchy    on  $projection.BusinessAreaHierarchy = _Hierarchy.BusinessAreaHierarchy
                                                                 and $projection.ValidityEndDate       = _Hierarchy.ValidityEndDate


{
      @Consumption.filter: {mandatory : true, selectionType : #SINGLE, multipleSelections : false }
      @ObjectModel.foreignKey.association: '_Hierarchy'
  key cast(hrrp_node.hryid as fis_hryid_businessarea_42 preserving type ) as BusinessAreaHierarchy,
      @ObjectModel.text.association: '_Text'
  key hrrp_node.hrynode                                                   as HierarchyNode,
      @Semantics.businessDate.to: true
      @Consumption.filter: {mandatory : true, selectionType : #SINGLE, multipleSelections : false }
  key cast(hrrp_node.hryvalto as fis_datbi preserving type )              as ValidityEndDate,
      @Semantics.businessDate.from: true
      cast(hrrp_node.hryvalfrom as fis_datab preserving type )            as ValidityStartDate,
      hrrp_node.parnode                                                   as ParentNode,
      hrrp_node.hryver                                                    as HierarchyVersion,
      @Consumption.valueHelpDefinition: [
        { entity:  { name:    'I_BusinessAreaStdVH',
                     element: 'BusinessArea' }
        }]
      @ObjectModel.foreignKey.association: '_BusinessArea'
      cast ( hrrp_node.leafvalue as gsber )                               as BusinessArea,
      @VDM.lifecycle.status:    #DEPRECATED
      @VDM.lifecycle.successor: 'HierarchyNodeSequence'
      concat(hrrp_node.hryseqnbr, hrrp_node.hrynode)                      as SequenceNumber, // do not use any longer, use HierarchyNodeSequence
      hrrp_node.hryseqnbr                                                 as HierarchyNodeSequence,
      hrrp_node.hrylevel                                                  as HierarchyNodeLevel,
      hrrp_node.nodetype                                                  as NodeType,
      hrrp_node.nodevalue                                                 as HierarchyNodeVal,

      _Text,
      _BusinessArea,
      _Hierarchy

}
where
      nodetype          <> 'D'
  and hrrp_node.hrytype =  'GL04';
