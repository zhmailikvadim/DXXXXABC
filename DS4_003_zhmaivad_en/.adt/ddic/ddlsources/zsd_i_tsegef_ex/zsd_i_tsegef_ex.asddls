/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************                                                                     *
* MOKHNVAD     |24.11.2023  | FB_27077_SD_Shipment tables extrac VTTK, *
*              |            | VTTP, TSEGE                              *       
*              |            | DS4K971753                               *
*----------------------------------------------------------------------*/
@VDM.viewType: #BASIC
@Analytics.dataCategory:#FACT
@Metadata.allowExtensions: true
@Analytics: {
   internalName: #LOCAL,
    dataExtraction: {
       enabled: true,
       delta.changeDataCapture: {
            automatic : true
            }
      }
}
@ObjectModel: {
   representativeKey: 'HEAD_HDL',
   usageType: {
     dataClass:      #TRANSACTIONAL,
     serviceQuality: #B,
     sizeCategory:   #XL
   }
}
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Time Segment Events'

define view entity ZSD_I_TSEGEF_EX as select from tsege {
        key head_hdl,
        key even,
        key even_cnt,
        key even_verty,
        key even_vernu,
            even_sor,
            even_tstfr,
            even_zonfr,
            even_tstto,
            even_zonto,
            even_flgff,
            even_flgft,
            _dataaging
}
