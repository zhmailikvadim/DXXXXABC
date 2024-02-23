/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* PISHCALI     | 10.10.2022 | 13391: FI_BE BUILD - Limit Custom Report *
*              |            | DS4K929386                               *
*----------------------------------------------------------------------*/
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Bank Area Value Help'

@Search.searchable: true

define view entity ZFI_I_LIM_BANK_AREA_VH
  as select from tbkk01  as _T01
    inner join   tbkk01t as _T01T on _T01.bkkrs = _T01T.bkkrs
{
      @ObjectModel.text.element:  [ 'BankAreaDescription' ]
      @Search: { defaultSearchElement: true, ranking: #HIGH }
  key _T01.bkkrs    as BankArea,

      @Semantics.text: true
      @Search: { defaultSearchElement: true, ranking: #HIGH, fuzzinessThreshold: 0.7 }
      _T01T.t_bkkrs as BankAreaDescription
}

where
  _T01T.spras = $session.system_language
