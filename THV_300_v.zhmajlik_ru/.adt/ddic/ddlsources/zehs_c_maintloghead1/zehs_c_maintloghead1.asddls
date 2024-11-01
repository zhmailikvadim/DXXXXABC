@AbapCatalog.sqlViewName: 'ZEHSMainHead1'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true


@OData.publish: true

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    writeActivePersistence: 'ZEHS_LOGPWOT_H',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true
    
//    deleteEnabled: true
}
define view zehs_c_maintloghead1

  as select from ZEHS_I_MaintenanceLogHeader
  association [0..*] to ZEHS_C_MAINTLOGPOINT      as _MaintenanceLogPoints on  _MaintenanceLogPoints.IdMaitenanceLogPoint = $projection.IdMaitenanceLogHeader
  association        to zehs_control              as _TypesOfControl       on  _TypesOfControl.id    = $projection.ctrl_type
                                                                           and _TypesOfControl.begda <= $projection.ControlDate
                                                                           and _TypesOfControl.endda >= $projection.ControlDate
  association        to zehs_i_type_of_control_VH as _TypeOfControlVH      on  $projection.ctrl_type = _TypeOfControlVH.ctrl_type

  association [0..*] to zehs_task_i               as _TaskI                on  _TaskI.task_id = $projection.TaskId

  association        to I_CompanyCode             as _CompanyCode          on  $projection.CompanyCode = _CompanyCode.CompanyCode
                                                                           and _CompanyCode.Language   = 'R'
  association        to I_ControllingArea         as _ControllingArea      on  $projection.ControllingArea = _ControllingArea.ControllingArea
  association        to hrp1000                   as _OrgHrp               on  _OrgHrp.objid = $projection.OrganizationUnit
                                                                           and _OrgHrp.otype = 'O'
                                                                           and _OrgHrp.begda <= $projection.ControlDate
                                                                           and _OrgHrp.endda >= $projection.ControlDate
                                                                           and _OrgHrp.langu = 'R'
  association        to hrp1000                   as _WorkHrp              on  _WorkHrp.objid = $projection.WorkerWhoControlled
                                                                           and _WorkHrp.otype = 'S'
                                                                           and _WorkHrp.begda <= $projection.ControlDate
                                                                           and _WorkHrp.endda >= $projection.ControlDate
                                                                           and _WorkHrp.langu = 'R'
  association        to zehs_d_pa001              as _PersonalPernr        on  _PersonalPernr.Pernr = $projection.PersonalNumberPernr
                                                                           and _PersonalPernr.Begda <= $projection.ControlDate
                                                                           and _PersonalPernr.Endda >= $projection.ControlDate

  association        to zehs_i_severity_vh        as _SeverityVH           on  _SeverityVH.id <> '0'


{
            @UI.hidden: true
  key       uuid,
            @ObjectModel.readOnly: true
            id                               as IdMaitenanceLogHeader,
            @ObjectModel.readOnly: true
            task_id                          as TaskId,
            location_id                      as ObjectOfMonitoring,
            cntrl_point                      as ControlPoint,

            @ObjectModel.readOnly: true
            create_data                      as CreateDate,
            bukrs                            as CompanyCode,
            kokrs                            as ControllingArea,
            org_unit                         as OrganizationUnit,
            workr                            as WorkerWhoControlled,
            bname                            as PersonalNumberPernr,
            contr_data                       as ControlDate,
            @ObjectModel.text.element: [ 'DescriptionLong' ]
            //@Consumption.valueHelp: '_TypeOfControlVH'
            ctrl_type,
            @ObjectModel.readOnly: true
            _TypesOfControl.description      as Description,
            @ObjectModel.readOnly: true
            _TypesOfControl.description_long as DescriptionLong,
            @ObjectModel.readOnly: true
            _CompanyCode.CompanyCodeName,
            @ObjectModel.readOnly: true
            _ControllingArea.ControllingAreaName as kokrs_text,
            @ObjectModel.readOnly: true
            _OrgHrp.stext                    as OrganizationName,
            @ObjectModel.readOnly: true
            _WorkHrp.stext                   as WorkerName,
            @ObjectModel.readOnly: true
            _PersonalPernr.Ename             as PernrControlledEname,
            _MaintenanceLogPoints,

            _TaskI,
            _TypeOfControlVH,
            _SeverityVH

} //where zehs_logpwot_h.id like '%472%' 
 