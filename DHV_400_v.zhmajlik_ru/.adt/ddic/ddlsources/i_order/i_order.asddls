@AbapCatalog.sqlViewName: 'IORDER'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics: {dataCategory: #DIMENSION, dataExtraction.enabled: true}
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel.representativeKey: 'OrderID'
@ObjectModel.semanticKey: 'OrderID'
@ObjectModel.usageType: {serviceQuality: #B, sizeCategory: #L, dataClass: #TRANSACTIONAL}
@VDM.viewType: #BASIC
@EndUserText.label: 'Order'
// basic view for information on orders of any category (AUFTYP); 
// more details on orders are provided e.g. by view like I_LogisticsOrder or I_InternalOrder        

define view I_Order
  as select from    aufk                        as aufk
    left outer join afko                        as afko on afko.aufnr = aufk.aufnr
    
  association [1..1] to I_OrderCategory         as _OrderCategory on $projection.OrderCategory = _OrderCategory.OrderCategory
  association [1..1] to I_OrderType             as _OrderType     on $projection.OrderType     = _OrderType.OrderType

{
  // Key
  key aufk.aufnr                                as  OrderID,

  // Category and Type
  @ObjectModel.foreignKey.association: '_OrderCategory'
  cast(aufk.autyp as pph_autyp preserving type) as  OrderCategory,
  @ObjectModel.foreignKey.association: '_OrderType'
  aufk.auart                                    as  OrderType,

  // Associations
  _OrderCategory,
  _OrderType
};                                                                                           
  
  
  
  
 