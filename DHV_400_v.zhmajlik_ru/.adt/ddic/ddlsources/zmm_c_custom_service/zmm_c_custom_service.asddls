@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'zmmccustomserv'

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Custom Service'

@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true

@OData.publish: true

define view ZMM_C_CUSTOM_SERVICE
  as select from zmm_i_custom_service

{
key DeclarantId,
PermissionNum
//DatePermitted,
//DeclType,
//RelMblnr,
//RelGjahr,
//CustProc,
//TotalGoodsNum,
//TrCountryCode,
//DealNatureCode,
//DealFeaturCode,
//DelTermsRbcode,
//ContrCurrCode,
//TotalInvAmount,
//PersonSurname,
//PrDocName,
//PrDocNumber,
//RegNumberDoc,
//ExecutionDate,
//NomReg,
//NetWeightQ,
//CorrectNumber,
//CorrectDate,
//Commentary,
//Mdel,
//DeclarationKind,
//ElectrDocSign,
//TotalCustCost,
//CorShortName,
//CorAddress,
//CorUnp,
//CorOrgName,
//CeeShortName,
//CeeUnp,
//CeeOrgName,
//CeeCountryCode,
//CeeAddress,
//DeclShortName,
//DeclUnp,
//DeclOrgName,
//NumCustZone,
//ContIndicator,
//DstCountryCode,
//RdsCountryCode,
//DisCountryCode,
//RbdCountryCode,
//Code,
//CusCountryCode,
//AtransModeCode,
//BtransModeCode,
//TransMeansQuan,
//MethodTransport,
//ContrCurrRate,
//DeliveryCond,
//ContractNumber,
//ContractDate,
//AppendixNumber,
//AppendixDate,
//CommonModeCode,
//StatisticalCost,
//PrevTotalCost,
//TotalCustCostWaers,
//StatisticalCostWaers,
//ChangeList
} 
 