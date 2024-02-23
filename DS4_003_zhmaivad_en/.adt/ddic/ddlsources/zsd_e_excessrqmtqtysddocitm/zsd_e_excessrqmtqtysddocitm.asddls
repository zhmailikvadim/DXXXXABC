/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* BALUNYAN     | 18.04.2023 | 19971   :  Orderbook Cleansing           *
*              |            | DS4K949526                               *
************************************************************************
* BALUNYAN     | 21.08.2023 | 19971   :  Orderbook Cleansing           *
*              |            | DS4K956197                               *
************************************************************************
* DOCHIIGO     | 18.04.2023 | 24489:  Orderbook Cleansing              *
*              |            | DS4K961658                               *
***********************************************************************/
@AbapCatalog.sqlViewAppendName: 'ZSDEXRQMTSDITM'
@EndUserText.label: 'Extension view for C_ExcessRqmtQtySDDocItm'
extend view C_ExcessRqmtQtySDDocItm with ZSD_E_ExcessRqmtQtySDDocItm
  association        to I_SalesDocument              as _SalesDocument_E        on  $projection.salesdocument = _SalesDocument_E.SalesDocument
  association        to zsc_t_vbep_dates             as _VbepDates              on  $projection.salesdocument     = _VbepDates.vbeln
                                                                                and $projection.salesdocumentitem = _VbepDates.posnr
  association        to mara                         as _Material_E             on  $projection.material = _Material_E.matnr
  association        to ZSD_C_OpenForAssgmtReqQtyGnr as _OpenForAssgmtReqQtyGnr on  $projection.salesdocument = _OpenForAssgmtReqQtyGnr.SalesDocument
  association [0..1] to ZSD_I_ARUN_BDBS_DB_HANA      as _ARUN_BDBS              on  $projection.salesdocument     = _ARUN_BDBS.salesdoc_num
                                                                                and $projection.salesdocumentitem = _ARUN_BDBS.salesdoc_item

{
  @EndUserText.label: 'Valid to'
  _SalesDocument_E.AgrmtValdtyEndDate as ValidTo,
  @EndUserText.label: 'Initial Confirmed Delivery Date'
  _VbepDates.zz1_zcdd_init            as CDD,
  @EndUserText.label: 'DChain Status'
  _Material_E.mstav                   as DChainStatus,
  @EndUserText.label: 'Open Qty for Assigm (%) At Generic Level'
  case when  _OpenForAssgmtReqQtyGnr.RequestedQuantityInBaseUnitSum <> 0
        then

    cast( ( _OpenForAssgmtReqQtyGnr.RequestedQuantityInBaseUnitSum - (_OpenForAssgmtReqQtyGnr.AssignedQuantityInBaseUnitSum + _OpenForAssgmtReqQtyGnr.DeliveredQuantityInBaseUnitSum) ) * 100  as abap.fltp )
       / cast(_OpenForAssgmtReqQtyGnr.RequestedQuantityInBaseUnitSum as abap.fltp)

         else cast( 0 as abap.fltp )
        end                           as OpenForAssgmtReqQtyGnr,
  @EndUserText.label: 'Reason for Rejection'
  @Consumption.valueHelpDefinition: [{ entity: { name:    'I_SalesDocumentRjcnReason',
                                                 element: 'SalesDocumentRjcnReason' } }]
  _Item.SalesDocumentRjcnReason       as ZRjcnReason,
  ----------------------------------------------------------------------------------------------------
  @EndUserText.label: 'Allocation Date'
  @Semantics.businessDate.at: true
  _ARUN_BDBS.creation_time            as ZAllocationDate
  //cast(Left(cast(_ARUN_BDBS.creation_time as abap.char(20)), 15) as abap.dats ) as create_date,
  //  @EndUserText.label: 'Allocation Date'
  //  tstmp_to_dats( _ARUN_BDBS.creation_time,
  //                 abap_system_timezone( $session.client,'NULL' ),
  //                 $session.client, 
  //                 'NULL' ) as ZAllocationDate1
  --------------------------------------------------------------------------------------------------------------

}
