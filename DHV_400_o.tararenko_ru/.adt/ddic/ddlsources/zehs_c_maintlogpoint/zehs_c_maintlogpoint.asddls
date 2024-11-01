@AbapCatalog.sqlViewName: 'ZEHSCMAINTLOGPOI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Maintenance Log Points'
@Metadata.allowExtensions: true
@OData.publish: true

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    compositionRoot: true,
    writeActivePersistence: 'ZEHS_LOG_TC',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true
   // deleteEnabled: true
}

define view ZEHS_C_MAINTLOGPOINT
  as select from zehs_i_MaintenanceLogPoints
{
  key    uuid,
         @UI.hidden: true
         id                   as IdMaitenanceLogPoint,
         @UI.hidden: true
         ehfnd_location       as ObjectOfMonitoring,
         @UI.hidden: true
         cntrl_point          as ControlPoint,
         @ObjectModel.readOnly: true
         NameOfObjectMonitoring,
         @ObjectModel.readOnly: true
         NameOfControlPoint,
         ctrl_comment         as CommentOffindedInconsistencies,
         @ObjectModel.readOnly: true
         NameOfTypeViolation,
         @ObjectModel.readOnly: true
         DescriptionSeverity,
         action               as CorrectiveAction,
         @ObjectModel.readOnly: true
         ''                   as Responsible,
         dline_dat            as DateOfDedLine,
         @ObjectModel.readOnly: true
         NameOfEliminationStatus,
         stat                 as EliminationStatus,
         date_fin             as EliminationDate,
         chr_fin              as EliminationFlag, //Отметка о выполении
         is_tickout_h_record  as FlagDeleteOfTalon, //Индикатор изъятия талона
         is_discipline_record as FlagDisciplinaryLiability, //Индикатор дисциплинарной ответственности
         is_sanctions_record  as FlagPenalties, //Индикатор штрафных санкция
         is_work_start_record as FlagStartJob,
         is_work_stop_record  as FlagStopJob,

         @ObjectModel.text.element: [ 'DescriptionSeverity' ]
         // @Consumption.valueHelp: '_SeverityVH'
         SeverityOfConsequences,

         //      '/sap/bc/ui5_ui5/sap/zehs_unl_nw2' as Z_EHS_LOGFIX,
         /* Associations */
         _Responsible,
         _SeverityVH
} 
 