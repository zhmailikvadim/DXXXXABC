@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Candidate Registration'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZHR_I_CANDIDATE_REGISTRATION as select from zhr_cand_registr
{
    key uuid as Uuid,
    pernr as Pernr,
    nachn as Nachn,
    name2 as Name2,
    nach2 as Nach2,
    vorna as Vorna,
    num01_email as Num01Email,
    subty as Subty,
    otype as Otype,
    objid as Objid,
    plvar as Plvar,
    rsign as Rsign,
    relat as Relat,
    istat as Istat,
    priox as Priox,
    begda as Begda,
    endda as Endda,
    varyf as Varyf,
    seqnr as Seqnr,
    useralias as Useralias,
    password as Password,
    zhr_user as ZhrUser,
    zsap_user as ZsapUser,
    sap_otype as SapOtype,
    sap_objid as SapObjid,
    sap_plvar as SapPlvar,
    created_user as CreatedUser,
    created_data as CreatedData,
    changed_user as ChangedUser,
    changed_data as ChangedData,
    created_time as CreatedTime,
    changed_time as ChangedTime,
    has_errors as HasErrors,
    is_run_registration as IsRunRegistration,
    last_changed_at as LastChangedAt,
    changed_by as ChangedBy
    }
