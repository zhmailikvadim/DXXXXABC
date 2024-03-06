/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
*----------------------------------------------------------------------*
* SHYDLSIA     | 24.07.2023 |  FB_23241_SD_Change package assignment for ZSD_I_ISAL*
*              |            |  DS4K958086                              *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'All CDS Basic'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBW_I_AllCDSBasic_EX 
  as select from    ddldependency                  as t1
    left outer join      ddldependency                  as t0    on t1.ddlname = t0.ddlname and t0.objecttype = 'VIEW' and t0.state = 'A'
    left outer join dhcdc_auth_cdsextrctndelta     as anno2 on  anno2.strucobjn =    t1.objectname
    left outer join ARS_APIS_RELEASED_C1_OR_GROUPS as c1    on  c1.tadir_object   = 'DDLS'
                                                            and c1.tadir_obj_name = t1.objectname
                                                            and c1.object_key     = t1.objectname
                                                            and c1.object_type    = 'CDS_STOB'
    left outer join ddddlsrc02bt                   as t3    on  t3.ddlname    = t1.ddlname
                                                            and t3.strucobjn  = t1.objectname
                                                            and t3.as4local   = t1.state
                                                            and t3.ddlanguage = $session.system_language
    left outer join dd02b                          as t4    on  t4.strucobjn = t1.ddlname
                                                            and t4.as4local  = t1.state
{
  key cast( t1.objectname as ddstrucobjname preserving type ) as ViewName,
      cast( coalesce( t0.objectname, t1.objectname ) as viewname preserving type ) as SqlViewName,
      t1.ddlname                              as Ddlname,
      @Semantics.text:true
      t3.ddtext                               as DataExtractionViewDescription,
      t3.ddlanguage                           as Ddlanguage,
      cast(
        case
          when c1.state is null then 'NO'
          when c1.state = 'RELEASED' then 'C1'
          when c1.state = 'DEPRECATED' then 'C1'
          else 'NO'
        end as dhbas_cds_release_state preserving type ) as ReleaseState,

      case
         when anno2.cnt > 0 then 'true'
         else 'false'
       end                                    as isDeltaSupported,
      coalesce( t4.strucobjn_raw,
                t1.objectname )               as DataExtractionViewName
}
where
  t1.state      = 'A'
  and t1.objecttype = 'STOB'
