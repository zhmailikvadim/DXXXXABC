@AbapCatalog.sqlViewName: 'ZHRICANDIDHEADDR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Header Draft'
define view ZHR_I_CANDIDATE_HEADER_DRAFT
  as select from zhr_pb0002d
{

  uuid                          as Uuid,
  pernr                         as Pernr,
  subty                         as Subty,
  objps                         as Objps,
  sprps                         as Sprps,
  endda                         as Endda,
  begda                         as Begda,
  seqnr                         as Seqnr,
  aedtm                         as Aedtm,
  uname                         as Uname,
  histo                         as Histo,
  itxex                         as Itxex,
  refex                         as Refex,
  ordex                         as Ordex,
  itbld                         as Itbld,
  preas                         as Preas,
  flag1                         as Flag1,
  flag2                         as Flag2,
  flag3                         as Flag3,
  flag4                         as Flag4,
  rese1                         as Rese1,
  rese2                         as Rese2,
  grpvl                         as Grpvl,
  inits                         as Inits,
  nachn                         as Nachn,
  name2                         as Name2,
  nach2                         as Nach2,
  vorna                         as Vorna,
  cname                         as Cname,
  titel                         as Titel,
  titl2                         as Titl2,
  namzu                         as Namzu,
  vorsw                         as Vorsw,
  vors2                         as Vors2,
  rufnm                         as Rufnm,
  midnm                         as Midnm,
  knznm                         as Knznm,
  anred                         as Anred,
  gesch                         as Gesch,
  gbdat                         as Gbdat,
  gblnd                         as Gblnd,
  gbdep                         as Gbdep,
  gbort                         as Gbort,
  natio                         as Natio,
  nati2                         as Nati2,
  nati3                         as Nati3,
  sprsl                         as Sprsl,
  konfe                         as Konfe,
  famst                         as Famst,
  famdt                         as Famdt,
  anzkd                         as Anzkd,
  nacon                         as Nacon,
  permo                         as Permo,
  perid                         as Perid,
  gbpas                         as Gbpas,
  lnamr                         as Lnamr,
  nabik                         as Nabik,
  nabir                         as Nabir,
  gbjhr                         as Gbjhr,
  gbmon                         as Gbmon,
  gbtag                         as Gbtag,
  nchmc                         as Nchmc,
  vnamc                         as Vnamc,
  namz2                         as Namz2,
  stras                         as Stras,
  land1                         as Land1,
  state                         as State,
  ort01                         as Ort01,
  num01_email                   as Num01Email,
  num02_phone1                  as Num02Phone1,
  num02_phone2                  as Num02Phone2,
  hsnmr                         as Hsnmr,
  ort01f                        as Ort01f,
  statef                        as Statef,
  strasf                        as Strasf,
  hsnmrf                        as Hsnmrf,
  is_car_exist                  as IsCarExist,
  is_driver                     as IsDriver,
  is_arm_force                  as IsArmForce,
  arm_reason                    as ArmReason,
  min_salary                    as MinSalary,
  sickness                      as Sickness,
  detail_sickness               as DetailSickness,
  relatives_bn                  as RelativesBn,
  admin_respons                 as AdminRespons,
  crimin_respons                as CriminRespons,
  admin_respons_text            as AdminResponsText,
  crimin_respons_text           as CriminResponsText,
  hobbies                       as Hobbies,
  otype                         as Otype,
  objid                         as Objid,
  plvar                         as Plvar,
  rsign                         as Rsign,
  relat                         as Relat,
  istat                         as Istat,
  priox                         as Priox,
  varyf                         as Varyf,
  useralias                     as Useralias,
  password                      as Password,
  zhr_user                      as ZhrUser,
  zsap_user                     as ZsapUser,
  family_stat_id                as FamilyStatId,
  created_user                  as CreatedUser,
  created_data                  as CreatedData,
  created_time                  as CreatedTime,
  created_tmstmp                as CreatedTmstmp,
  changed_user                  as ChangedUser,
  changed_data                  as ChangedData,
  changed_time                  as ChangedTime,
  changed_tmstmp                as ChangedTmstmp,
  education_type                as EducationType,
  educ_type_numc                as EducTypeNumc,
  comp_level                    as CompLevel,
  comp_programs                 as CompPrograms,
  has_errors                    as HasErrors,
  created_user_reg              as CreatedUserReg,
  created_data_reg              as CreatedDataReg,
  changed_user_reg              as ChangedUserReg,
  changed_data_reg              as ChangedDataReg,
  created_time_reg              as CreatedTimeReg,
  //changed_time_reg              as ChangedTimeReg,
  changed_tmstmp_reg            as ChangedTmstmpReg,
  activeuuid                    as Activeuuid,
  hasactiveentity               as Hasactiveentity,
  draftentitycreationdatetime   as Draftentitycreationdatetime,
  draftentitylastchangedatetime as Draftentitylastchangedatetime,
  draftentityconsistencystatus  as Draftentityconsistencystatus
} 
 