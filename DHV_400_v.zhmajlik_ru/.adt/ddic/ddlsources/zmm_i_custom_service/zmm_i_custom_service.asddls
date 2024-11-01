@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'zmmicustomserv'

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Custom Service'

@Metadata.ignorePropagatedAnnotations: true

define view zmm_i_custom_service
  as select from zcs_cust_hcd

{
key declarant_id as DeclarantId,
permission_num as PermissionNum,
date_permitted as DatePermitted,
decl_type as DeclType,
rel_mblnr as RelMblnr,
rel_gjahr as RelGjahr,
cust_proc as CustProc,
total_goods_num as TotalGoodsNum,
tr_country_code as TrCountryCode,
deal_nature_code as DealNatureCode,
deal_featur_code as DealFeaturCode,
del_terms_rbcode as DelTermsRbcode,
contr_curr_code as ContrCurrCode,
total_inv_amount as TotalInvAmount,
person_surname as PersonSurname,
pr_doc_name as PrDocName,
pr_doc_number as PrDocNumber,
//pr_doc_date as PrDocDate,
reg_number_doc as RegNumberDoc,
execution_date as ExecutionDate,
nom_reg as NomReg,
net_weight_q as NetWeightQ,
correct_number as CorrectNumber,
correct_date as CorrectDate,
commentary as Commentary,
mdel as Mdel,
declaration_kind as DeclarationKind,
electr_doc_sign as ElectrDocSign,
total_cust_cost as TotalCustCost,
cor_short_name as CorShortName,
cor_address as CorAddress,
cor_unp as CorUnp,
cor_org_name as CorOrgName,
cee_short_name as CeeShortName,
cee_unp as CeeUnp,
cee_org_name as CeeOrgName,
cee_country_code as CeeCountryCode,
cee_address as CeeAddress,
decl_short_name as DeclShortName,
decl_unp as DeclUnp,
decl_org_name as DeclOrgName,
num_cust_zone as NumCustZone,
cont_indicator as ContIndicator,
dst_country_code as DstCountryCode,
rds_country_code as RdsCountryCode,
dis_country_code as DisCountryCode,
rbd_country_code as RbdCountryCode,
code as Code,
cus_country_code as CusCountryCode,
atrans_mode_code as AtransModeCode,
btrans_mode_code as BtransModeCode,
trans_means_quan as TransMeansQuan,
method_transport as MethodTransport,
contr_curr_rate as ContrCurrRate,
delivery_cond as DeliveryCond,
contract_number as ContractNumber,
contract_date as ContractDate,
appendix_number as AppendixNumber,
appendix_date as AppendixDate,
common_mode_code as CommonModeCode,
statistical_cost as StatisticalCost,
prev_total_cost as PrevTotalCost,
total_cust_cost_waers as TotalCustCostWaers,
statistical_cost_waers as StatisticalCostWaers,
change_list as ChangeList
} 
 