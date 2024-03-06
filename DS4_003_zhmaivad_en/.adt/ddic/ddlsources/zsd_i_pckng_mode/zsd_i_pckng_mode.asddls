/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* GUPTANI1     | 05.07.2022 | 13035  :FB_11675_SC_BE Dev - Case Lot Management App  - CDS a    *
*              |            | DS4K921270                               *
*----------------------------------------------------------------------*
*/
@EndUserText.label: 'Packing Mode VH'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@ObjectModel.resultSet.sizeCategory: #XS
 

define view entity ZSD_I_PCKNG_MODE 
as select from zsd_t_pckng_mode as PckngMode {
    
    @Search.defaultSearchElement: true
      @ObjectModel.text.element: ['pkmodetxt']
     key PckngMode.caselot_pkmode as pkmode, 
  
  @Search.defaultSearchElement: true   
  PckngMode.pkmode_text as pkmodetxt    
    
}
