@AbapCatalog.sqlViewName: 'ZFI_IBSEG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Сегмент документа: бухгалтерия'

@VDM.viewType: #BASIC

@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER

define view ZFI_I_BSEG
  with parameters
    p_vertn : ranl,
    p_blart : blart
  as select from bseg
    inner join   bkpf on  bkpf.bukrs = bseg.bukrs
                      and bkpf.belnr = bseg.belnr
                      and bkpf.gjahr = bseg.gjahr
{
  sum(wrbtr) as wrbtr,
  h_budat,
  h_waers
}
where
      bseg.vertn      = $parameters.p_vertn
  and bkpf.blart      = $parameters.p_blart
  and bkpf.xreversing = ''
  and bkpf.xreversed  = ''
group by
  h_budat,
  h_waers 
 