@VDM.viewType: #BASIC
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK

@ObjectModel:   { usageType: { serviceQuality: #C,
                               sizeCategory:   #XL,
                               dataClass:      #MIXED }
}

@EndUserText.label: 'Supply Protection Time Bucket'
define view entity I_SupplyProtectionTimeBucket
  as select from sup_timebucket

{
  key uuid                                                                                                          as SupProtTimeBucketUUID,
      supcvcuuid                                                                                                    as SupplyProtectionGroupUUID,
      startutcdatetime                                                                                              as SupProtPeriodStartUTCDateTime,
      endutcdatetime                                                                                                as SupProtPeriodEndUTCDateTime,
      protectedquantityunit                                                                                         as UnitOfMeasure,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      protectedquantity                                                                                             as SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) )                                                                                   as SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      cast(0 as abap.quan(15,3) )                                                                                   as SupProtRemainingProtectedQty,
      creationdatetime                                                                                              as CreationDateTime,
      createdbyuser                                                                                                 as CreatedByUser,
      lastchangedatetime                                                                                            as LastChangeDateTime,
      lastchangedbyuser                                                                                             as LastChangedByUser,
      //tstmp_to_dats( endutcdatetime, 'UTC', $session.client, 'NULL' ) as EndUTCDate
      cast(tstmp_to_dats( cast( endutcdatetime as abap.dec(15,0) ), 'UTC', $session.client, 'NULL' ) as abap.dats ) as EndUTCDate
}
