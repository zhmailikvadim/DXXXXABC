/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* DEREVOLE     | 21.10.2022 | T4MTEMP-846 [Build] BE -                 *
*              |            | Pricing Mass Upload Tool                 *
*              |            | DS4K929425, Change number 13489          *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewName: 'ZISLSPRCGKEYCFLD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@ClientHandling.algorithm: #SESSION_VARIABLE

@VDM.viewType: #BASIC

@ObjectModel:{
   usageType:{
     dataClass: #CUSTOMIZING,
     serviceQuality: #C,
     sizeCategory: #S
   }
}

@EndUserText.label: 'Field from Condition Table for Pricing in Sales'
define view ZI_SlsPrcgKeyCombinationField
  as select from    t682i
    inner join      t685                  on  t682i.kvewe = t685.kvewe
                                          and t682i.kappl = t685.kappl
                                          and t682i.kozgf = t685.kozgf
                                          and t682i.kvewe = 'A'
                                          and t682i.kappl = 'V'
                                          and t685.kozgf != ''
    inner join      t681                  on  t682i.kvewe   = t681.kvewe
                                          and t682i.kotabnr = t681.kotabnr
    inner join      t682z                 on  t682i.kvewe = t682z.kvewe
                                          and t682i.kappl = t682z.kappl
                                          and t682i.kozgf = t682z.kozgf
                                          and t682i.kolnr = t682z.kolnr
                                          and t682z.zifna != 'KFRST'
                                          and t682z.zifna != 'KBSTAT'
  //Standard key fields mapping
    left outer join wlf_mp_fields         on  t682z.zifna           = wlf_mp_fields.int_fieldname
                                          and wlf_mp_fields.bor_obj = 'BUS30110'
    left outer join dd03nd as st_dd03nd   on  st_dd03nd.strucobjn         = 'ZC_SLSPRICINGCONDITIONRECORDTP'
                                          and st_dd03nd.nodename          = '.NODE1'
                                          and st_dd03nd.as4local          = 'A'
                                          and wlf_mp_fields.ext_fieldname = st_dd03nd.fieldname

  //Custom key fields mapping
    left outer join dd03nd as cust_dd03nd on  cust_dd03nd.strucobjn = 'ZC_SLSPRICINGCONDITIONRECORDTP'
                                          and cust_dd03nd.nodename  = '.NODE1'
                                          and cust_dd03nd.as4local  = 'A'
                                          and t682z.zifna           = cust_dd03nd.fieldname

{
  key t685.kschl                          as ConditionType,
  key cast(t682i.kotabnr as kotabnr_char) as ConditionTable,
  key t682i.kolnr                         as AccessNumberOfAccessSequence,
  key t682z.zaehk                         as NumberOfConditions,
      // t682z.qudiw                             as ConstantValueSource,
      t682z.kzini                         as PrcgCndnValueInitialIsAllowed,
      // t682z.fstst                             as ProcessingType,
      case
      when st_dd03nd.fieldname_raw is null or st_dd03nd.fieldname_raw is initial then cust_dd03nd.fieldname_raw
      else st_dd03nd.fieldname_raw
       end                                as ConditionFieldName
}
