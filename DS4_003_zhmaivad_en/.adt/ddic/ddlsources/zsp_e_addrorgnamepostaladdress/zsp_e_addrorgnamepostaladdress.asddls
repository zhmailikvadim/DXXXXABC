/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* DADABBEK     | 05.07.2023 | 22955: PO interface adaptions            *
*              |            | DS4K957434                               *
*----------------------------------------------------------------------*
* DADABBEK     | 15.07.2023 | 20957: SP_[Feature] [PF&E] Create custom *
*              |            | DS4K951468                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSP_T_ADREXT'
@EndUserText.label: 'Extention view for I_ADDRORGNAMEPOSTALADDRESS'
extend view I_AddrOrgNamePostalAddress with ZSP_E_ADDRORGNAMEPOSTALADDRESS
  association [1..1] to adrc as _AddressExtention on  $projection.AddressID                 = _AddressExtention.addrnumber
                                                  and $projection.AddressRepresentationCode = _AddressExtention.nation
{
  _AddressExtention.tel_number as ZZ_TelNumber,
  _AddressExtention.fax_number as ZZ_FaxNumber
}
