@AbapCatalog.sqlViewName: 'zsdibpstatus'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Get Status for bussines partner'
@ClientDependent:true
define view zsd_i_bp_status
  as select distinct from ZFI_I_DocumentItemManualEntry as Status
    join                  zsd_i_bp_status_max           as MaxPayment on Status.Erdat = MaxPayment.MaxEnteredData
  association to zfi_i_BpStatusIsoMain as _BpIsoStatus on Status.ZzStatBenef = _BpIsoStatus.Status
{
  Lifnr             as BussinesPartner,
  ZzStatBenef       as BussPartnStatus,
  _BpIsoStatus.Name as BussPartnStatusText
} 
where ZzStatBenef <> ''
 