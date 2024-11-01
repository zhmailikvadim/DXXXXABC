@AbapCatalog.sqlViewName: 'ZEHSIMaintLogPnt'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Log Control Points'
@Metadata.allowExtensions: true
@ClientDependent: true

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    compositionRoot: true,
    writeActivePersistence: 'ZEHS_LOG_TC',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}

define view zehs_i_MaintenanceLogPoints
  as select from zehs_log_tc as MaintenanceLogPoint
  association        to ehfndd_loc_text    as _ehfnddloctext on  _ehfnddloctext.parent_key = MaintenanceLogPoint.ehfnd_location
  association        to zehs_pointinfo     as _pointinfo     on  _pointinfo.db_key = MaintenanceLogPoint.cntrl_point
  association        to zehs_severity      as _severity      on  _severity.id = MaintenanceLogPoint.levels
  association        to zehs_violation     as _violation     on  _violation.id    =  MaintenanceLogPoint.typev
                                                             and _violation.begda <= MaintenanceLogPoint.create_data
                                                             and _violation.endda >= MaintenanceLogPoint.create_data
  association [0..*] to zehs_i_responsible as _Responsible   on  _Responsible.IdOfMaintenanceLog = $projection.id
                                                             and _Responsible.ObjectOfMonitoring = $projection.ehfnd_location
                                                             and _Responsible.ControlPoint       = $projection.cntrl_point
  association        to zehs_i_severity_vh as _SeverityVH    on  $projection.SeverityOfConsequences = _SeverityVH.id
{
  key      uuid,
           id,             //as IdMaitenanceLogPoint,
           ehfnd_location, //as ObjectOfMonitoring,
           cntrl_point,    //as ControlPoint,
           @ObjectModel.readOnly: true
           _ehfnddloctext.text        as NameOfObjectMonitoring,
           @ObjectModel.readOnly: true
           _pointinfo.atwrt           as NameOfControlPoint,
           @ObjectModel.readOnly: true
           _pointinfo.type            as TypeOfViolationPoint,
           create_data                as CreateDate,
           typev                      as TypeOfViolation,
           @ObjectModel.readOnly: true
           _violation.description     as NameOfTypeViolation,
           levels                     as SeverityOfConsequences,
           @ObjectModel.readOnly: true
           _severity.description      as DescriptionSeverity,
           @ObjectModel.readOnly: true
           _severity.description_long as DescriptionSeverityLong,
           @ObjectModel.readOnly: true
           _severity.need_to_stop     as FlagStopJobSeverity,
           @ObjectModel.readOnly: true
           action,    //as CorrectiveAction,
           dline_dat, //as DateOfDedLine,
           stat,      //as EliminationStatus,
           date_fin,  //as EliminationDate,
           chr_fin,              // as EliminationFlag,
           is_tickout_h_record,  // as FlagDeleteOfTalon,
           is_discipline_record, // as FlagDisciplinaryLiability,
           is_sanctions_record,  // as FlagPenalties,
           is_work_start_record, // as FlagStartJob,
           is_work_stop_record,  // as FlagStopJob,
           ctrl_comment,         // as CommentOffindedInconsistencies,
           @ObjectModel.readOnly: true

           case when stat = '0'  then 'не устранено'
                when stat = '1'  then 'устранено'
                when stat = '2'  then 'на доработку'
                when stat = '3'  then 'продлен срок'
                else ' '
           end                        as NameOfEliminationStatus,

           _Responsible,
           _SeverityVH


} 
 