@AbapCatalog.sqlViewName: 'ICUSTSALETAX'
@VDM.viewType: #BASIC
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@Analytics: {
  dataCategory: #DIMENSION,
  dataExtraction: {
    enabled: true,
    delta.changeDataCapture: {
      automatic: true
    }
  }
}
@ObjectModel.representativeKey:'CustomerTaxCategory'
//@ObjectModel.representativeKey:'Division'
@Metadata.allowExtensions:true
@AccessControl.personalData.blocking: #REQUIRED
@AccessControl.personalData.blockingIndicator: '_Customer.IsBusinessPurposeCompleted'

@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.supportedCapabilities: [#SQL_DATA_SOURCE,
                                     #CDS_MODELING_DATA_SOURCE,
                                     #CDS_MODELING_ASSOCIATION_TARGET,
                                     #EXTRACTION_DATA_SOURCE]  
@ObjectModel.modelingPattern:#NONE                                     
@ObjectModel.usageType.serviceQuality: #C
@ObjectModel.usageType.sizeCategory: #XXL
@ObjectModel.usageType.dataClass: #MASTER
@EndUserText.label: 'Customer Sales Area Tax'
@Metadata.ignorePropagatedAnnotations: true

define view I_CustSalesAreaTax as

select distinct 
from tvkwz
inner join tvta on tvta.vkorg = tvkwz.vkorg and tvta.vtweg = tvkwz.vtweg
left outer join t001w on t001w.werks = tvkwz.werks
left outer join knvi on knvi.aland = t001w.land1
inner join I_CustomerSalesArea as sales on knvi.kunnr =  sales.Customer 
                                                               and tvta.vkorg =  sales.SalesOrganization 
                                                               and tvta.vtweg =  sales.DistributionChannel
                                                               and tvta.spart =  sales.Division 

association[1..1] to I_Customer as _Customer on $projection.Customer = _Customer.Customer

association[1..1] to I_CustomerSalesArea as _CustomerSalesArea on $projection.Customer =  _CustomerSalesArea.Customer 
                                                               and $projection.SalesOrganization =  _CustomerSalesArea.SalesOrganization 
                                                               and $projection.DistributionChannel =  _CustomerSalesArea.DistributionChannel
                                                               and $projection.Division =  _CustomerSalesArea.Division 
association[1..1] to  I_Country  as _Country     on  $projection.DepartureCountry = _Country.Country   
association [0..1] to I_SalesOrganization          as _SalesOrganization            on  $projection.SalesOrganization = _SalesOrganization.SalesOrganization  
association [0..1] to I_DistributionChannel        as _DistributionChannel          on  $projection.DistributionChannel = _DistributionChannel.DistributionChannel
association [0..1] to I_Division                   as _Division                     on  $projection.Division = _Division.Division   

//association[0..*]  to I_PricingConditionType as _TaxCategory on $projection.tatyp = _TaxCategory.ConditionType                                                  
{
  @ObjectModel.foreignKey.association: '_Customer'
  key knvi.kunnr  as Customer,  -- Customer Number
  //@ObjectModel.foreignKey.association: '_CustomerSalesArea._SalesOrganization'
  @ObjectModel.foreignKey.association: '_SalesOrganization'
  key tvkwz.vkorg as SalesOrganization, -- Sales Organization
  @ObjectModel.foreignKey.association: '_DistributionChannel'
  key tvkwz.vtweg as DistributionChannel, -- Distribution Channel
  @ObjectModel.foreignKey.association: '_Division'
  key tvta.spart  as Division,  -- Division
  @ObjectModel.foreignKey.association: '_Country'
  key aland       as DepartureCountry, -- Departure Country
 //  @ObjectModel.foreignKey.association: '_TaxCategory'
  key tatyp       as CustomerTaxCategory, -- Tax Category
  taxkd           as CustomerTaxClassification, -- Tax Classification 
  _Customer.AuthorizationGroup,
  _Customer.IsBusinessPurposeCompleted,
  _Customer,
  _CustomerSalesArea,  
  _SalesOrganization,
//  _CustomerSalesArea._SalesOrganization,
 // _SalesOrganization,
  _DistributionChannel,
  _Division,
  _Country
  //_TaxCategory

}
