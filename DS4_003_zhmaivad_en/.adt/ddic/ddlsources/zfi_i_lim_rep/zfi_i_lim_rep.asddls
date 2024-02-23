/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* PISHCALI     | 13.09.2022 | 13391: FI_BE BUILD - Limit Custom Report *
*              |            | DS4K929386                               *
*----------------------------------------------------------------------*/

/*
Data sources used:
BKK42 - to get Bank Area
ZFI_I_LIM_REP_BKK45 - to get the business partners that are Accont Holders
TBKK01T - to get the description of the Bank Area.

In this development, virtual elements are used, as the calculation of some
fields is very difficult to implement with CDS. And also helper elements are
used, cause CDS does not allow to realize some functions on the fields, which
were calculated by virtual elements.
*/

@AccessControl.authorizationCheck: #CHECK
@AbapCatalog.dataMaintenance : #NOT_ALLOWED
@EndUserText.label: 'Interface for IHB Limit Report'

define view entity ZFI_I_LIM_REP
  with parameters
    @Semantics.dateTime: true
    p_date : dats

  as select from bkk42               as _BKK42
    join         ZFI_I_LIM_REP_BKK45 as _BKK45 on _BKK42.bkkrs = _BKK45.bkkrs
  association [0..1] to I_CalendarDate as _CalendarDate on  _CalendarDate.CalendarDate = $parameters.p_date
  association [0..1] to tbkk01t        as _TBKK01T      on  _BKK42.bkkrs   = _TBKK01T.bkkrs
                                                        and _TBKK01T.spras = $session.system_language
{
  key _BKK42.bkkrs                                as BankArea,
  key _BKK45.partner                              as BusinessPartnerNumber,
      _BKK45._BusinessPartner.BusinessPartnerName as BusinessPartnerName,
      _TBKK01T.t_bkkrs                            as BankAreaDescription,

      _CalendarDate.CalendarDate                  as CurrentDate,

      cast( 'EUR' as abap.cuky )                  as TargetCurrency,

      /*
      The virtual element is used to retrieve the Value Date Balance
      with standard FM 'BKK_COND_BALANCE_VALDATE'
      */
      @Semantics.amount.currencyCode: 'TargetCurrency'
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ZCL_FI_BALANCE_VALDATE'
      cast(0 as abap.curr( 23, 2 ))               as Balance,

      /*
      The virtual element is used to retrieve the Account Limit
      with standard FM 'READ_TEXT'
      */
      @Semantics.amount.currencyCode: 'TargetCurrency'
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ZCL_FI_ACCOUNT_LIMIT'
      cast(0 as abap.curr( 23, 2 ))               as AccountLimit,

      /*
      The helper virtual element is used to pass nessessary data for Chart
      */
      @Semantics.amount.currencyCode: 'TargetCurrency'
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ZCL_FI_BALANCE_VALDATE_C'
      cast(0 as abap.curr( 23, 2 ))               as BalanceForChart,

      /*
      The virtual element is used to calculate the Difference: Account Limit - Balance
      */
      @Semantics.amount.currencyCode: 'TargetCurrency'
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ZCL_FI_DIFFERENCE_CALC'
      cast(0 as abap.curr( 23, 2 ))               as Difference,

      /*
      The virtual element is used to set the Difference Criticality
      */
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ZCL_FI_CRITICALITY'
      0                                           as DifferenceCriticality
}

group by
  _BKK42.bkkrs,
  _BKK45.partner,
  _BKK45._BusinessPartner.BusinessPartnerName,
  _TBKK01T.t_bkkrs,
  _CalendarDate.CalendarDate
