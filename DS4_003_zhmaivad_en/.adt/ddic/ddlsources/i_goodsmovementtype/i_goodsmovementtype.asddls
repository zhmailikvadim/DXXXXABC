@AbapCatalog:{
               sqlViewName: 'IGDSMVTTYPE',
               preserveKey: true,
               compiler.compareFilter: true
             }
@EndUserText.label: 'Goods Movement Type'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
                usageType: {
                             sizeCategory: #S,
                             serviceQuality: #A,
                             dataClass:#CUSTOMIZING
                           },
                representativeKey: 'GoodsMovementType',
                modelingPattern: #ANALYTICAL_DIMENSION,
                supportedCapabilities: [#ANALYTICAL_DIMENSION, #CDS_MODELING_ASSOCIATION_TARGET, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE]
              }
@VDM: {
        viewType: #BASIC,
        lifecycle.contract.type: #PUBLIC_LOCAL_API
      }
@Analytics.dataCategory: #DIMENSION
@Metadata: {
             ignorePropagatedAnnotations: true
           }

define view I_GoodsMovementType
  as select from t156
  association [0..*] to I_GoodsMovementTypeT      as _Text                    on $projection.GoodsMovementType = _Text.GoodsMovementType
  association [0..1] to I_DebitCreditCode         as _DebitCreditCode         on $projection.DebitCreditCode = _DebitCreditCode.DebitCreditCode
  association [0..1] to I_ResvnAcctAssgmtCategory as _ResvnAcctAssgmtCategory on $projection.ResvnAcctAssgmtCategory = _ResvnAcctAssgmtCategory.ResvnAcctAssgmtCategory
{
      @ObjectModel.text.association: '_Text'
  key bwart as GoodsMovementType,
      xstbw as IsReversalMovementType,
      @ObjectModel.foreignKey.association: '_DebitCreditCode'
      shkzg as DebitCreditCode,
      @ObjectModel.foreignKey.association: '_ResvnAcctAssgmtCategory'
      rstyp as ResvnAcctAssgmtCategory,
      bustr as BasicMovementTypeReference,

      _Text,
      _DebitCreditCode,
      _ResvnAcctAssgmtCategory
}        
