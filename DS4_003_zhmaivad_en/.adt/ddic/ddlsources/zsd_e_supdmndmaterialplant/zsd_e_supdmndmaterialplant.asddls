/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BLAGUKAR     | 16.11.2022 | FB_15340_SD_Build - Supply Demand Overview (SDO) Enh*
*              |            | DS4K935546                                *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDESUPDMNDMAT'
@EndUserText.label: 'I_SupDmndMaterialPlant Extend View'
extend view I_SupDmndMaterialPlant with zsd_e_SupDmndMaterialPlant
  association [0..*] to mean as _EANs on  marc.matnr  = _EANs.matnr
                                      and _EANs.eantp = 'UC'
{
  marc.plifz            as PlannedDeliveryTime,
  SupDmndMaterial.eannr as EAN,
  _EANs
}
