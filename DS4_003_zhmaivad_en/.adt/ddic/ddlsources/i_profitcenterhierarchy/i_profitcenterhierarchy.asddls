// Comments:
//
// Key fields: please see comment in view I_CostCenterHierarchy
//
@ObjectModel.representativeKey: 'ProfitCenterHierarchy' //Inserted by VDM CDS Suite Plugin
@EndUserText.label: 'Profit Center Hierarchy'
@Analytics: { dataCategory: #DIMENSION }
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IFIPROFITCENTERH'
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE
@Metadata.ignorePropagatedAnnotations:true 

@ObjectModel.modelingPattern: #ANALYTICAL_DIMENSION
@ObjectModel.supportedCapabilities: [ #CDS_MODELING_DATA_SOURCE, #CDS_MODELING_ASSOCIATION_TARGET, #ANALYTICAL_DIMENSION ]
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #XL
@ObjectModel.usageType.dataClass: #MASTER

@Metadata.allowExtensions: true

@Analytics.dataExtraction.enabled: true

//--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
@AccessControl.privilegedAssociations: ['_ControllingAreaText']
// ]--GENERATED

define view I_ProfitCenterHierarchy
  as select from hrrp_directory
  //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
  association [0..1] to I_ControllingArea      as _ControllingAreaText on   $projection.ControllingArea = _ControllingAreaText.ControllingArea
  // ]--GENERATED
  association [*]    to I_ProfitCenterHierarchyText as _Text            on  $projection.ProfitCenterHierarchy = _Text.ProfitCenterHierarchy
                                                                        and $projection.ControllingArea       = _Text.ControllingArea

  association [0..1] to I_ControllingArea           as _ControllingArea on  $projection.ControllingArea = _ControllingArea.ControllingArea

{

      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.valueHelpDefinition: [ 
        { entity:  { name:    'I_ControllingArea',
                     element: 'ControllingArea' }
        }]
      @ObjectModel.text.association: '_ControllingAreaText'
      // ]--GENERATED
      @ObjectModel.foreignKey.association: '_ControllingArea' //Inserted by VDM CDS Suite Plugin
  key cast( hrrp_directory.hrycls as fis_kokrs )                          as ControllingArea,
      @ObjectModel.text.association: '_Text'
  key cast(hrrp_directory.hryid as fis_hryid_prctr)                   as ProfitCenterHierarchy,
      @Semantics.businessDate.to: true
  key cast(hrrp_directory.hryvalto as fis_datbi)                      as ValidityEndDate,
      @Semantics.businessDate.from: true
      cast(hrrp_directory.hryvalfrom as fis_datab)                    as ValidityStartDate,
      @Semantics.user.lastChangedBy: true
      hrrp_directory.upduser                                          as LastChangedByUser,
      @Semantics.systemDate.lastChangedAt: true
      hrrp_directory.updtime                                          as LastChangeTime,
      hrrp_directory.hrysid                                            as HierarchyShortID,
      _Text,
      _ControllingArea,
      //--[ GENERATED:012:29JlHNUf7jY4ipE4XHfNBG
      @Consumption.hidden: true
      _ControllingAreaText
      // ]--GENERATED


}
where
  hrrp_directory.hrytyp = '0106';   
 
