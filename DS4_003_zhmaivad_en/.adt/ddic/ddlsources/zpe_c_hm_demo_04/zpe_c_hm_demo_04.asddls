/*
************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* CANOCAR      | 12.08.2022 | 12891      : BRF+ comsumption from RAP   *
*              |            | DS4K926772                               *
*----------------------------------------------------------------------*
*/

@EndUserText.label: 'Demo CDS for Complex hardcode - VDE'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zpe_c_hm_demo_04
  provider contract transactional_query
  as projection on zpe_i_hm_demo_04
{

          @UI.selectionField:   [{ position: 10 }]
          @UI.lineItem:         [{ position: 10 }]
  key     auart,

          @UI.lineItem:         [{ position: 20 }]
          faksk,

          @UI.lineItem:         [{ position: 30 }]
          lifsk,

          @UI.lineItem:         [{ position: 40 }]
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_PE_HM_DEMO_04'
  virtual bukrs : bukrs
}
