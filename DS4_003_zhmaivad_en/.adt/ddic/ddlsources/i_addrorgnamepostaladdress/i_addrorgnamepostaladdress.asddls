@AbapCatalog.sqlViewName: 'IADDRPOSTALADDR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@ClientHandling.algorithm: #SESSION_VARIABLE
@EndUserText.label: 'Postal Address and Organization Name'
//@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.supportedCapabilities: [#CDS_MODELING_ASSOCIATION_TARGET, #CDS_MODELING_DATA_SOURCE, #SQL_DATA_SOURCE]
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MIXED
//@ObjectModel.representativeKey: 'AddressID'
@VDM: {
  viewType: #BASIC,
  lifecycle.contract.type: #PUBLIC_LOCAL_API
}

define view I_AddrOrgNamePostalAddress
  as select from adrc
  association [0..1] to I_Region             as _Region             on  $projection.Region  = _Region.Region
                                                                    and $projection.Country = _Region.Country

  association [0..1] to I_Country            as _Country            on  $projection.Country = _Country.Country

  association [0..1] to I_FormOfAddress      as _FormOfAddress      on  $projection.FormOfAddress = _FormOfAddress.FormOfAddress

  association [0..1] to I_TransportationZone as _TransportationZone on  $projection.TransportZone = _TransportationZone.TransportZone
                                                                    and $projection.Country       = _TransportationZone.CountryCode

{
  key addrnumber       as AddressID,
  key nation           as AddressRepresentationCode,

      pers_addr        as AddressIsPersonAddress,
      langu            as CorrespondenceLanguage,
      deflt_comm       as PrfrdCommMediumType,
      city_code        as CityNumber,
      city1            as CityName,
      city2            as DistrictName,
      home_city        as VillageName,
      post_code1       as PostalCode,
      post_code3       as CompanyPostalCode,
      po_box           as POBox,
      @EndUserText.label: 'PO Box Address Non-Deliverable Reason'
      dont_use_p       as POBoxAddrNonDeliverableReason,
      po_box_num       as POBoxIsWithoutNumber,
      post_code2       as POBoxPostalCode,
      po_box_lobby     as POBoxLobbyName,
      po_box_loc       as POBoxDeviatingCityName,
      po_box_reg       as POBoxDeviatingRegion,
      po_box_cty       as POBoxDeviatingCountry,
      streetcode       as Street,
      street           as StreetName,
      @EndUserText.label: 'Street Address Non-Deliverable Reason'
      dont_use_s       as StreetAddrNonDeliverableReason,
      str_suppl1       as StreetPrefixName1,
      str_suppl2       as StreetPrefixName2,
      str_suppl3       as StreetSuffixName1,
      location         as StreetSuffixName2,
      house_num1       as HouseNumber,
      house_num2       as HouseNumberSupplementText,
      building         as Building,
      floor            as Floor,
      roomnumber       as RoomNumber,
      @ObjectModel.foreignKey.association: '_Country'
      country          as Country,
      @ObjectModel.foreignKey.association: '_Region'
      region           as Region,
      name_co          as CareOfName,
      @ObjectModel.foreignKey.association: '_FormOfAddress'
      title            as FormOfAddress,
      name1            as AddresseeName1,
      name2            as AddresseeName2,
      name3            as AddresseeName3,
      name4            as AddresseeName4,
      taxjurcode       as TaxJurisdiction,
      @ObjectModel.foreignKey.association: '_TransportationZone'
      transpzone       as TransportZone,
      deli_serv_type   as DeliveryServiceTypeCode,
      deli_serv_number as DeliveryServiceNumber,
      time_zone        as AddressTimeZone,
      county_code      as SecondaryRegion,
      county           as SecondaryRegionName,
      township_code    as TertiaryRegion,
      township         as TertiaryRegionName,
      sort1            as AddressSearchTerm1,
      sort2            as AddressSearchTerm2,
      chckstatus       as RegionalStructureCheckStatus,      
      addr_group       as AddressGroup,
      _Region,
      _Country,
      _FormOfAddress,
      _TransportationZone
}
where
  date_from = '00010101'
