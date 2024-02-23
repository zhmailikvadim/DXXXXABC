@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'CustomerGroup'
@ObjectModel.dataCategory: #TEXT
@ObjectModel.usageType.dataClass: #CUSTOMIZING
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory: #S
@EndUserText.label: 'Customer Group - Text'
@VDM.viewType: #BASIC
@Analytics.dataExtraction.enabled: true
@AccessControl.authorizationCheck:  #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ISDCUSTGRPT'
@AbapCatalog.buffering.status: #ACTIVE
@AbapCatalog.buffering.type: #FULL
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Metadata.ignorePropagatedAnnotations: true

@Search.searchable: true
@ObjectModel.modelingPattern:           #LANGUAGE_DEPENDENT_TEXT
@ObjectModel.supportedCapabilities:  [  #SQL_DATA_SOURCE,
                                        #CDS_MODELING_DATA_SOURCE,
                                        #CDS_MODELING_ASSOCIATION_TARGET,
                                        #LANGUAGE_DEPENDENT_TEXT,
                                        #EXTRACTION_DATA_SOURCE,
                                        #SEARCHABLE_ENTITY   ]
define view I_CustomerGroupText
  as select from t151t

  association [0..1] to I_CustomerGroup as _CustomerGroup on $projection.CustomerGroup = _CustomerGroup.CustomerGroup
  association [0..1] to I_Language      as _Language      on $projection.Language = _Language.Language
{

      @ObjectModel.foreignKey.association: '_CustomerGroup'
  key kdgrp as CustomerGroup,
      @Semantics.language:true
      @ObjectModel.foreignKey.association: '_Language'
  key spras as Language,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Search.ranking: #HIGH
      @Semantics.text:true
      ktext as CustomerGroupName,

      //Associations
      _CustomerGroup,
      _Language
};
