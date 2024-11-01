@AbapCatalog.sqlViewName: 'ZSDIFIXWBSTRlg1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'WBS Transfer'
@Metadata.ignorePropagatedAnnotations: true
define view ZSD_I_FIXEDASSET_WBS_TR_LOG1
  as select from I_FixedAsset
  association to ZFI_I_WBS_TRANSFER_LOG as _TransferLog on $projection.InvestmentProjectWBSElement = _TransferLog.WbselementParent
{
  key  CompanyCode,
  key  MasterFixedAsset,
  key  FixedAsset,
       InvestmentProjectWBSElement,
       AssetClass,
       AssetDeactivationDate,
       _TransferLog.AssetclassParent,
       _TransferLog.AssetParent,
       _TransferLog.FixedassetParent,
       _TransferLog.WbselementParent,
       _TransferLog.AssetclassChild,
       _TransferLog.AssetChild,
       _TransferLog.FixedassetChild,
       _TransferLog.WbselementChild,
       _TransferLog.Recordcreationdate,
       _TransferLog.Timeofday
}
where
  (
        AssetClass               =  '97200010'
    and AssetDeactivationDate    <= '00000000'
  )
  or    _TransferLog.AssetParent >  '' 
 