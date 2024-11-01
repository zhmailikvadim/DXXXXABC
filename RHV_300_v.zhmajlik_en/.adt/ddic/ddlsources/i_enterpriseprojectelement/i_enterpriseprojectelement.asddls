
@VDM.viewType: #BASIC
@AbapCatalog.sqlViewName: 'IENTERPROJELE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Enterprise Project Element'

@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@ClientHandling.algorithm: #SESSION_VARIABLE

@ObjectModel: {
   semanticKey:       [ 'ProjectElement' ],
   representativeKey: 'ProjectElementUUID',
//   alternativeKey: [ { id : 'ProjectInternalID', uniqueness: #UNIQUE, element: 'ProjectInternalID' } ],
   usageType: {
     serviceQuality:  #B,
     dataClass:       #MASTER,
     sizeCategory:    #XL
   }
}

@Metadata.ignorePropagatedAnnotations: true

@Analytics.dataExtraction: {
        enabled: true       
}

@VDM.lifecycle.contract.type:  #PUBLIC_LOCAL_API


define view I_EnterpriseProjectElement
  as select from    /s4ppm/task      as task
    inner join      prps             as prps         on prps.pspnr = task.pspnr

  // to make sure parent is empty in case of parent being PST                                                     
    left outer to one join /s4ppm/hierarchy as hiera        on hiera.object_guid = task.guid
                                                      and hiera.hierarchy_type = 'T'
                                                      and task.object_type = 'TTO'

  association [1..1] to I_EnterpriseProject as _Project
          on  _Project.ProjectUUID = $projection.ProjectUUID

 // ---Extension Association
  association [1..1] to E_PPM_Task              as _ProjectElementExtension on  $projection.ProjectElementUUID = _ProjectElementExtension.TaskUUID


  // associations to authorization views
  association [0..*] to I_PPM_AuthznByUsrH      as _AuthUser                on  _AuthUser.ReferencedObjectUUID = $projection.ProjectElementUUID
                                                                            and _AuthUser.UserID               = $session.user
                                                                            and (
                                                                               _AuthUser.Activity              = 'Admin'
                                                                               or _AuthUser.Activity           = 'Write'
                                                                               or _AuthUser.Activity           = 'Read'
                                                                             )
  association [0..*] to I_PPM_AuthznBySubstitH  as _AuthSubst               on  _AuthSubst.ReferencedObjectUUID = $projection.ProjectElementUUID
                                                                            and _AuthSubst.UserID               = $session.user
                                                                            and (
                                                                               _AuthSubst.Activity              = 'Admin'
                                                                               or _AuthSubst.Activity           = 'Write'
                                                                               or _AuthSubst.Activity           = 'Read'
                                                                             )
  association [0..*] to I_PPM_AuthznByUserRoleH as _AuthRole                on  _AuthRole.ReferencedObjectUUID = $projection.ProjectElementUUID
                                                                            and _AuthRole.UserID               = $session.user
                                                                            and (
                                                                               _AuthRole.Activity              = 'Admin'
                                                                               or _AuthRole.Activity           = 'Write'
                                                                               or _AuthRole.Activity           = 'Read'
                                                                             )
  association [0..*] to I_PPM_AuthznByUsrGrpH   as _AuthGroup               on  _AuthGroup.ReferencedObjectUUID = $projection.ProjectElementUUID
                                                                            and _AuthGroup.UserID               = $session.user
                                                                            and (
                                                                               _AuthGroup.Activity              = 'Admin'
                                                                               or _AuthGroup.Activity           = 'Write'
                                                                               or _AuthGroup.Activity           = 'Read'
                                                                             )


{
  key task.guid            as ProjectElementUUID,
      task.external_id     as ProjectElement,
      @ObjectModel.foreignKey.association: '_Project'
      task.project_guid    as ProjectUUID,
      @Semantics.text: true
      task.name            as ProjectElementDescription, 
      task.proc_status_own as ProcessingStatus,
      task.latest_start_date  as PlannedStartDate,
      task.latest_finish_date as PlannedEndDate,
      task.sort_number     as SortingNumber,
      //2008 EPPM Harmonization Start
      task.task_type        as EntProjectElementType,
      @Semantics.booleanIndicator: true
      task.milestone        as IsProjectMilestone,
      prps.txjcd            as TaxJurisdiction,
      prps.tplnr            as FunctionalLocation,
      prps.fakkz            as WBSElementIsBillingElement,
      //2008 EPPM Harmonization End
      cast ( task.pspnr as ps_s4_pspnr preserving type ) as WBSElementInternalID,

      cast ( hiera.up as /s4ppm/tv_parent_entity_guid preserving type ) as  ParentObjectUUID,

      prps.xstat           as WBSIsStatisticalWBSElement,
      prps.pbukr           as CompanyCode,
      prps.pkokr           as ControllingArea,
      prps.kostl           as CostCenter,
      prps.kalsm           as CostingSheet,
      prps.fabkl           as FactoryCalendar,
      prps.func_area       as FunctionalArea,
      prps.imprf           as InvestmentProfile,
      prps.stort           as Location,
      prps.werks           as Plant,
      prps.prctr           as ProfitCenter,
      prps.fkstl           as ResponsibleCostCenter,
      //SO Integration
      prps.abgsl           as ResultAnalysisInternalID,
      prps.vbeln_prps      as LeadingSalesOrder, 
      prps.posnr_prps      as LeadingSalesOrderItem,
      @Semantics.user.createdBy: true                    
      task.created_by      as CreatedByUser,
      @Semantics.systemDateTime.createdAt: true            
      task.created_on      as CreationDateTime, 
      @Semantics.user.lastChangedBy: true
      task.changed_by      as LastChangedByUser, 
      @Semantics.systemDateTime.lastChangedAt: true
      task.changed_on      as LastChangeDateTime,      

      _Project,

      // Authorization Association, do not expose externally
      @Consumption.hidden: true
      _AuthUser,
      @Consumption.hidden: true
      _AuthSubst,
      @Consumption.hidden: true
      _AuthRole,
      @Consumption.hidden: true
      _AuthGroup

}
where
  task.object_type <> 'DPO'
