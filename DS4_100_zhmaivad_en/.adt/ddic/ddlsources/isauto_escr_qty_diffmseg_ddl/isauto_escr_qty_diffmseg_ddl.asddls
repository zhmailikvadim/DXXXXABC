@AbapCatalog.sqlViewAppendName: 'ISAUTOESCRQDIFV'
@EndUserText.label: 'Extension for Append ISAUTO_ESCR_QTY_DIFFMSEG on MSEG'
/*
This extension view is used to ensure compatibility of the CDS view source NSDM_DDL_MSEG with the data base table MSEG
where the DDL source -  respectively it's view - is used as proxy object.
Those proxy objects have been introduced to ensure compatibility with the MM-IM data model change in S/4HANA.
Even if this extend has been created by MM-IM development, the responsibility is still at the component owners.
*/
/*
Fields of appends with default values in this extend view do not have their correspondence in table MATDOC
just because the functionality behind the appended/extended fields is right now not available in S/4HANA.
As soon as the functionality shall be available the fields need to be appended to structure NSDM_S_ITEM which is part
of table MATDOC and this source need to be adjusted. Again, this is in the responsibility of the affected area
*/
extend view nsdm_e_mseg with ISAUTO_ESCR_QTY_DIFFMSEG_E {
    fzgls_mark,
    etanp_mark,
    popup_mark
}           
  
  
  
 