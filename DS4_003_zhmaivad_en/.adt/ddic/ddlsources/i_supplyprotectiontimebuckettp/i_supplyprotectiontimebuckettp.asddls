@VDM.viewType: #TRANSACTIONAL
@VDM.lifecycle.contract.type: #SAP_INTERNAL_API
@AccessControl.authorizationCheck: #CHECK
@ObjectModel:   { usageType: { serviceQuality: #C,
                               sizeCategory:   #XL,
                               dataClass:      #MIXED }
}

@EndUserText.label: 'Supply Protection Time Bucket'
define view entity I_SupplyProtectionTimeBucketTP
  as select from I_SupplyProtectionTimeBucket

  association        to parent I_SupplyProtectionGroupTP as _SupplyProtectionGroupTP on $projection.SupplyProtectionGroupUUID = _SupplyProtectionGroupTP.SupplyProtectionGroupUUID
  association [1..1] to I_SupplyProtectionTP             as _SupplyProtectionTP      on $projection.SupplyProtectionUUID = _SupplyProtectionTP.SupplyProtectionUUID

  association [0..1] to I_User                           as _CreatedByUser           on _CreatedByUser.UserID = $projection.CreatedByUser
  association [0..1] to I_User                           as _LastChangedByUser       on _LastChangedByUser.UserID = $projection.LastChangedByUser
  composition [0..*] of I_SupProtPermConsumptionTP       as _SupProtPermConsumptionTP
{
  key SupProtTimeBucketUUID,
      SupplyProtectionGroupUUID,
      SupProtPeriodStartUTCDateTime,
      cast(tstmp_to_dats( cast( SupProtPeriodStartUTCDateTime as abap.dec(15,0) ), 'UTC', $session.client, 'NULL' ) as vdm_v_start_date) as StartDate,
      SupProtPeriodEndUTCDateTime,
      cast(tstmp_to_dats( cast( SupProtPeriodEndUTCDateTime as abap.dec(15,0) ),'UTC', $session.client, 'NULL' ) as vdm_v_end_date)      as EndDate,

      _SupplyProtectionGroupTP.UnitOfMeasure,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtProtectedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtConsumedQuantity,

      @Semantics.quantity.unitOfMeasure: 'UnitOfMeasure'
      SupProtRemainingProtectedQty,
      @Semantics.user.createdBy: true
      CreatedByUser,

      @Semantics.systemDateTime.createdAt: true
      CreationDateTime,

      @Semantics.user.lastChangedBy: true
      LastChangedByUser,

      @Semantics.systemDateTime.lastChangedAt: true
      LastChangeDateTime,

      _SupplyProtectionGroupTP.SupplyProtectionUUID                                                                                      as SupplyProtectionUUID,

      /* Associations */
      _SupplyProtectionGroupTP,
      _SupplyProtectionTP,
      _SupProtPermConsumptionTP,
      _CreatedByUser,
      _LastChangedByUser,
      _SupplyProtectionGroupTP._BaseUnit
}
