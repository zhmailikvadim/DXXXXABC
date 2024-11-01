@AbapCatalog.sqlViewName: 'zmmicnvsupply'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inventory Supply Consumption'
@OData.publish: true
@VDM.viewType: #CONSUMPTION


@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingDelegated: true,
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true

}
define view ZMM_C_INVENTORY_SUPPLY
  as select from ZMM_I_INVENTORY_SUPPLY
  association [0..*] to ZMM_C_INVENTORY_SUPPLY_ITEM_IN as _InventoryItemIn  on $projection.uuid = _InventoryItemIn.uuid_header
  association [0..*] to ZMM_C_INVENTORY_SUPPLY_ITEM_O  as _InventoryItemOut on $projection.uuid = _InventoryItemOut.uuid_header
{
  key uuid,
      has_error,
      error_id,
      error_number,
      error_message,
      @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
      _InventoryItemIn,
      @ObjectModel.association: {
       type: [ #TO_COMPOSITION_CHILD ]}
      _InventoryItemOut
} 
 