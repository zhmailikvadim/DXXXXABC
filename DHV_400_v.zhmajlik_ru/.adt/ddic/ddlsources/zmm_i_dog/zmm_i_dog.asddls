@AbapCatalog.sqlViewName: 'ZMM_IDOG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Договора'

@VDM.viewType: #BASIC

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER

define view ZMM_I_DOG
  as select from    rmps_t_case_attr
    left outer join scmg_t_case_attr     on scmg_t_case_attr.case_guid = rmps_t_case_attr.case_guid
    left outer join t052u                on  t052u.zterm = rmps_t_case_attr.zz_zterm
                                         and t052u.spras = 'R'
    left outer join tcurc                on tcurc.waers = rmps_t_case_attr.zz_waers
    inner join      tcurt                on  tcurt.waers = tcurc.waers
                                         and tcurt.spras = 'R'
    left outer join tcurc         as tcurc_pay   on tcurc_pay.waers = rmps_t_case_attr.zz_waers_pay
    left outer join tcurt         as tcurt_pay   on  tcurt_pay.waers = tcurc_pay.waers
                                                 and tcurt_pay.spras = 'R'
    left outer join ZMM_I_DOG_USR as usr on usr.bname = scmg_t_case_attr.responsible
  //    left outer join ZMM_I_DOG_USR as responsible on responsible.bname = scmg_t_case_attr.responsible
{
  key zext_key,
      cast(ps_active_tstart as abap.dats )                   as ps_active_tstart,
      cast(ps_active_tend as abap.dats )                     as ps_active_tend,
      zz_ndoc,
      created_by,
      //      creator.fio                                      as creator_fio,
      responsible,
      usr.fio                                                as responsible_fio,
      usr.mobile_phone                                       as responsible_phone,
      t052u.text1                                            as zz_zterm,
      concat_with_space(tcurc.altwr, tcurt.ltext, 1)         as zz_waers,
      zz_sumdoc,
      concat_with_space(tcurc_pay.altwr, tcurt_pay.ltext, 1) as zz_waers_pay,
      zz_partner,
      zz_regnum_wd,
      zz_bukrs,
      zz_prdoc
} 
 