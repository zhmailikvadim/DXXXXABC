/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BATCHVIN     | 04.12.2023 | 27069     : BE: Case Lot -Enhancement    *
*              |            | DS4K971200                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help for Case Lot Status'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
@Search.searchable: true
define view entity ZSD_I_CASE_LOT_STATUS
  as select from dd07l as doma
    inner join   dd07t as doma_text on  doma.domname  = doma_text.domname
                                    and doma.as4local = doma_text.as4local
                                    and doma.valpos   = doma_text.valpos
                                    and doma.as4vers  = doma_text.as4vers
{
  @EndUserText.label: 'Case Lot Status'
  key doma.domvalue_l as caselotstatus,
      @Search: { defaultSearchElement : true,
                   fuzzinessThreshold   : 0.8  }
      @ObjectModel.text.element: ['CaseLotStatus']
  @EndUserText.label: 'Case Lot Status Description'    
      doma_text.ddtext as caselotstatusdesc
}
where
      doma.domname         = 'ZSD_CL_STATUS'
  and doma_text.ddlanguage = $session.system_language
  and doma.as4local        = 'A'
