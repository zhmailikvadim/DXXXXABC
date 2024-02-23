/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* PISHCALI     | 07.10.2022 | 13391: FI_BE BUILD - Limit Custom Report *
*              |            | DS4K929386                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Partner Value Help'

@Search.searchable: true

define view entity ZFI_I_LIM_BUSINESS_PARTNER_VH
  as select distinct from bkk45  as _BKK45
    join                  but000 as _BUT000 on _BKK45.partner = _BUT000.partner
{
       @ObjectModel.text.element:  [ 'BusinessPartnerName' ]
       @Search: { defaultSearchElement: true, ranking: #HIGH }
       @EndUserText.label: 'Partner Number'
  key  _BKK45.partner    as BusinessPartnerNumber,

       @Semantics.text: true
       @Search: { defaultSearchElement: true, ranking: #HIGH , fuzzinessThreshold: 0.7 }
       @EndUserText.label: 'Org Name'
       _BUT000.name_org1 as BusinessPartnerName,

       @Semantics.text: true
       @Search: { defaultSearchElement: true, ranking: #HIGH , fuzzinessThreshold: 0.7 }
       @EndUserText.label: 'Group Name'

       _BUT000.name_grp1 as BusinessPartnerGroupName
}
where
  _BKK45.rltyp = 'BKK010' //Account Holder
