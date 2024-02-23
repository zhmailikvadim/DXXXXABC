@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Individual Object Status(JEST)'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
    usageType: {
        sizeCategory: #L,
        serviceQuality: #A,
        dataClass: #TRANSACTIONAL
    }
}
@Analytics:{
    dataExtraction: {
        enabled: true,
        delta.changeDataCapture: {
        automatic: true
        }
    }
}
@VDM.viewType: #BASIC
define view entity ZMM_I_STOCKSNAPF_EX
  as select from zsd_t_sap_snapsh
{

  key     snapshot_date,
  key     plant,
  key     storage_location,
  key     sales_order_no,
  key     sales_order_item,
  key     article,
  key     stock_type,
          sap_timestamp,
          @DefaultAggregation: #SUM
          @Semantics: { quantity : {unitOfMeasure: 'meins'} }
          sap_stock_qnt,
          meins,
          created_by,
          created_at,
          changed_by,
          changed_at,
          last_changed_at
}
