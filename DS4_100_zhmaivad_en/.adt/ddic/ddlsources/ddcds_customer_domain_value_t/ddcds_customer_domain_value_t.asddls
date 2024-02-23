//@AbapCatalog.sqlViewName: 'DDCDS_CUSTDFVT'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity DDCDS_CUSTOMER_DOMAIN_VALUE_T
  with parameters
    p_domain_name : sxco_ad_object_name --abap.char(30)
  as select from dd07t
    inner join   ARS_OBJECTS_ALL_SW_COMP_SCP on  ARS_OBJECTS_ALL_SW_COMP_SCP.program_id  = 'R3TR'
                                             and ARS_OBJECTS_ALL_SW_COMP_SCP.object_type = 'DOMA'
                                             and ARS_OBJECTS_ALL_SW_COMP_SCP.object_name = dd07t.domname
                                             and ARS_OBJECTS_ALL_SW_COMP_SCP.object_name = $parameters.p_domain_name

{
  key dd07t.domname    as domain_name,
  key dd07t.valpos     as value_position,
  key dd07t.ddlanguage as language,
      dd07t.domvalue_l as value_low,
      dd07t.ddtext     as text
}
where
  dd07t.as4local = 'A'
