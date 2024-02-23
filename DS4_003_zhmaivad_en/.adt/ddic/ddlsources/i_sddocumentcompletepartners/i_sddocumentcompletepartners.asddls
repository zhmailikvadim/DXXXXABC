@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'SD Document Complete Partners'
@VDM.viewType: #BASIC
@AccessControl: {
  authorizationCheck: #NOT_REQUIRED,
  personalData.blocking: #NOT_REQUIRED,
  privilegedAssociations: [ '_Address', '_DfltAddrRprstn','_PersonWorkplaceAddrDfltRprstn' ]
}
@AbapCatalog: {
  sqlViewName: 'ISDDOCCMPLTPART',
  compiler.compareFilter: true,
  preserveKey: true
}
@ObjectModel: {
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #A,
     sizeCategory:   #XL
   }
}

define view I_SDDocumentCompletePartners
  as
  select from P_SDDocumentCompletePartners

  association [0..1] to I_PartnerFunction as _PartnerFunction
    on $projection.PartnerFunction = _PartnerFunction.PartnerFunction
  association [0..1] to I_ContactPerson as _ContactPerson
    on $projection.ContactPerson = _ContactPerson.ContactPerson
    
  association [0..1] to I_Address as _Address
    on $projection.AddressID = _Address.AddressID
    
  // The address IDs from I_Address_2 are for customers and suppliers
  association [0..1] to I_Address_2 as _DfltAddrRprstn
    on $projection.AddressID = _DfltAddrRprstn.AddressID
       and $projection.AddressPersonID = _DfltAddrRprstn.AddressPersonID
       and _DfltAddrRprstn.AddressRepresentationCode is initial
  
  association [0..1] to I_BusPartAddress as _BusinessPartnerAddress
    on $projection.ReferenceBusinessPartner   = _BusinessPartnerAddress.BusinessPartner
       and $projection.AddressID = _BusinessPartnerAddress.AddressID
       and $projection.SDDocPartnerAddressRefType = 'H'
       
  association [0..1] to I_BusPartAddress as _BPRefAddressForDocSpcfcAddr
    on $projection.ReferenceBusinessPartner = _BPRefAddressForDocSpcfcAddr.BusinessPartner
       and $projection.BPRefAddressIDForDocSpcfcAddr = _BPRefAddressForDocSpcfcAddr.AddressID
       
  // The address IDs from I_PersonWorkplaceAddress are for contact persons                                                                              
  association [0..1] to I_PersonWorkplaceAddress as _PersonWorkplaceAddrDfltRprstn
    on $projection.AddressID = _PersonWorkplaceAddrDfltRprstn.AddressID
       and $projection.AddressPersonID = _PersonWorkplaceAddrDfltRprstn.AddressPersonID
       and _PersonWorkplaceAddrDfltRprstn.AddressRepresentationCode is initial
{
  key SDDocument,
  key SDDocumentItem,
  @ObjectModel.foreignKey.association: '_PartnerFunction'
  key PartnerFunction,

  Customer,
  Supplier,
  Personnel,
  @ObjectModel.foreignKey.association: '_ContactPerson'
  ContactPerson,

  ReferenceBusinessPartner,

  @ObjectModel.foreignKey.association: '_Address'
  AddressID,
  AddressPersonID,
  SDDocPartnerAddressRefType,
  AddressObjectType,
  BPAddrDeterminationTransaction,
  BPRefAddressIDForDocSpcfcAddr,
  SDDocPartnerAddrIsDocSpecific,

  PartnerIsOneTimeAccount,
  VATRegistration,
  @Semantics.text: true
  UnloadingPointName,
  
  CountryCode,
  CustomerHierarchyType,
  CustIsPrcDetnRlvt,
  CustomerIsRebateRelevant,
  CustomerHierarchyLevel,
  CustomerHierarchyFixedLevel,
  TransportZone,
  
  _PartnerFunction,
  _ContactPerson,

  _Address,
  _DfltAddrRprstn,
  _BusinessPartnerAddress,
  _PersonWorkplaceAddrDfltRprstn,
  _BPRefAddressForDocSpcfcAddr
};
