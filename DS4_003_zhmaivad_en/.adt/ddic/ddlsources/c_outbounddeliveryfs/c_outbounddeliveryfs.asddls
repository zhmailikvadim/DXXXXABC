@AbapCatalog.sqlViewName: 'COUTBDELIVFS'
@ClientHandling.algorithm:#SESSION_VARIABLE
@VDM.viewType: #CONSUMPTION
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck:#CHECK
@AccessControl.privilegedAssociations: [ '_Partner', '_ShipToParty', '_SoldToParty' ]
@AccessControl.personalData.blocking: #BLOCKED_DATA_EXCLUDED
@EndUserText.label: 'Outbound Delivery Object Page'
@Search.searchable: true

@ObjectModel: {
   compositionRoot: true,
   semanticKey: ['OutboundDelivery'],
   representativeKey: 'OutboundDelivery',
   usageType.dataClass: #MIXED,
   usageType.serviceQuality: #D,
   usageType.sizeCategory: #XL
}

@UI.headerInfo: {
     typeName:     'Outbound Delivery',
     typeNamePlural: 'Outbound Deliveries',
     title: {
           type:   #STANDARD,
           value:  'OutboundDelivery'
    },
    description.value: 'DeliveryDocumentTypeName'
}

@Consumption.semanticObject: 'OutboundDelivery'

define view C_OutboundDeliveryFs
  as select from I_OutboundDelivery as OutboundDelivery
  association [0..*] to C_SDDocumentPartnerCard  as _Partner                on  $projection.OutboundDelivery = _Partner.SDDocument
                                                                            and _Partner.SDDocumentItem      = '000000'
  association [0..*] to C_OutboundDeliveryItemFs as _OutboundDeliveryItemFs on  $projection.OutboundDelivery = _OutboundDeliveryItemFs.OutboundDelivery
  association [0..1] to I_OverallPickingStatus   as _OverallPickingStatus   on  $projection.OverallPickingStatus = _OverallPickingStatus.OverallPickingStatus
  association [1]    to E_DeliveryDocument       as _Extension              on  $projection.OutboundDelivery = _Extension.DeliveryDocument


{

      // ********** FACET DEFINITION **********
      @UI.facet:[
        //Filter Facets
        { id:'GenericFilter',
          purpose: #FILTER,
          type: #FIELDGROUP_REFERENCE,
          targetQualifier: 'GenericFilter' },

        //Header Facets
        { id: 'HeaderFacet-Column1',
          purpose: #HEADER ,
          type: #FIELDGROUP_REFERENCE,
          // label: '',
          targetQualifier: 'HeaderColumn1',
          position: 10 },

        { id: 'HeaderFacet-Column2',
          purpose: #HEADER ,
          type: #FIELDGROUP_REFERENCE,
          // label: '',
          targetQualifier: 'HeaderColumn2',
          position: 20 },

        { id: 'HeaderFacet-DeliveryDate',
          purpose: #HEADER ,
          type: #DATAPOINT_REFERENCE,
          // label: 'Delivery Date',
          targetQualifier: 'DeliveryDate',
          position: 30 },

        // Body Facets
        // Facet 'General Infromation' - Parent (collection)
         { id:              'GeneralInformation',
           type:            #COLLECTION,
           label:           'General Information',
           position:        10 },

             // Facet for Fieldgroup 'General Info Block 1' - nested inside 'General Information'
             { id:              'GeneralInfoBlock1-ID',
               type:            #FIELDGROUP_REFERENCE,
               //label:           'Fieldgroup ',
               parentId:        'GeneralInformation', // Places this facet into 'General Information'
               targetQualifier: 'GeneralInfoBlock1',
               position:         10 },

              // Facet for Fieldgroup 'General Info Block 2' - nested inside 'General Information'
             { id:              'GeneralInfoBlock2-ID',
               type:            #FIELDGROUP_REFERENCE,
               //label:           'Fieldgroup ',
               parentId:        'GeneralInformation', // Places this facet into 'General Information'
               targetQualifier: 'GeneralInfoBlock2',
               position:         20 },

              // Facet for Fieldgroup 'General Info Block 3' - nested inside 'General Information'
             { id:              'GeneralInfoBlock3-ID',
               type:            #FIELDGROUP_REFERENCE,
               //label:           'Fieldgroup ',
               parentId:        'GeneralInformation', // Places this facet into 'General Information'
               targetQualifier: 'GeneralInfoBlock3',
               position:         30 },

         // Facet 'Items'
         {  id: 'Items-ID',
            type: #LINEITEM_REFERENCE,
            label: 'Items',
            targetQualifier: 'OBDL_FS_Facet:Items',
            position: 20 ,
            targetElement: '_OutboundDeliveryItemFs' },

         // Facet 'Business Partners'
         {  id: 'BusinessPartners-ID',
            type: #CONTACT_REFERENCE,
            label: 'Business Partners',
            targetQualifier: 'Facet:BusinessPartners',
            position: 30 ,
            targetElement: '_Partner' },

         // Facet 'Output Management'
         {  id: 'OutputManagement',
            type: #COLLECTION,
            label: 'Output',
            position: 40
            }

      ]

      //Header
      //**********************************************************************************************
      @Search.defaultSearchElement: true
      @Search.ranking: #HIGH
      @UI.lineItem:[{position:1}]
      @UI.fieldGroup: { qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }
      @Consumption.semanticObject: 'OutboundDelivery'
  key OutboundDelivery,

      @UI.hidden: true
      cast( OutboundDelivery._DeliveryDocumentType._Text[1: Language=$session.system_language].DeliveryDocumentTypeName as bezei20) as DeliveryDocumentTypeName,

      @UI.fieldGroup: [ { qualifier: 'HeaderColumn1', position: 10, importance: #HIGH },
                        { qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @Consumption.semanticObject: 'Customer'
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer_VH', element: 'Customer' } } ]
      @UI.textArrangement: #TEXT_FIRST
      @ObjectModel.text.element: ['ShipToPartyFullName']
      ShipToParty,

      _ShipToParty._StandardAddress.FullName                                                                                        as ShipToPartyFullName,

      @UI.fieldGroup: [{ qualifier: 'HeaderColumn1', position: 20, importance: #HIGH },
                       { qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @Consumption.semanticObject: 'Customer'
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_Customer_VH', element: 'Customer' } } ]
      @UI.textArrangement: #TEXT_FIRST
      @ObjectModel.text.element: ['SoldToPartyFullName']
      SoldToParty,

      _SoldToParty._StandardAddress.FullName                                                                                        as SoldToPartyFullName,


      @UI.fieldGroup: [{ qualifier: 'HeaderColumn2', position: 20, importance: #MEDIUM},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @Consumption.valueHelpDefinition: [ { entity: { name: 'I_ShippingPointStdVH', element: 'ShippingPoint' } } ]
      @UI.textArrangement: #TEXT_FIRST
      ShippingPoint,

      @UI.fieldGroup: [{qualifier: 'HeaderColumn2', position: 10, importance: #MEDIUM, criticality: 'OvrlSDProcessStatusCriticality'},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      cast(_OverallSDProcessStatus._Text[1: Language=$session.system_language].OverallSDProcessStatusDesc as gbstk_name)            as OverallSDProcessStatusDesc,

      @UI.hidden
      cast(
          case OverallSDProcessStatus
            when '' then 0
            when 'A' then 2
            when 'B' then 2
            when 'C' then 3
            else 0
          end as abap.int1
      )                                                                                                                             as OvrlSDProcessStatusCriticality,


      @UI:{ dataPoint:{ description: 'Delivery Date' , criticality: 'DeliveryDateCriticality', criticalityRepresentation: #WITH_ICON} }
      @UI.fieldGroup: [{qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      DeliveryDate,

      @UI.hidden
      cast(
          case
            when  OutboundDelivery.DeliveryDate < $session.system_date  and OverallSDProcessStatus != 'C' then 1
            else
              case
                when OutboundDelivery.DeliveryDate = $session.system_date  and OverallSDProcessStatus != 'C' then 2
                else
                  case
                    when OutboundDelivery.DeliveryDate > $session.system_date  and OverallSDProcessStatus != 'C' then 3
                    else 0
                  end
              end
          end as abap.int1
      )                                                                                                                             as DeliveryDateCriticality,


      //General Information
      //**********************************************************************************************
      @UI.fieldGroup: [
                       { qualifier: 'GeneralInfoBlock1', position: 10,  importance: #HIGH},
                       //{qualifier: 'HeaderColumn2', position: 20,  importance: #HIGH},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      SalesOrganization,

      @UI.fieldGroup: {qualifier: 'GeneralInfoBlock1', position: 20, importance: #HIGH}
      @Semantics.quantity: { unitOfMeasure: 'HeaderWeightUnit'}
      @Consumption.filter.hidden: true
      cast (HeaderGrossWeight as le_brgew)                                                                                          as HeaderGrossWeight,

      @UI.fieldGroup: {qualifier: 'GeneralInfoBlock1', position: 30, importance: #HIGH}
      @Consumption.filter.hidden: true
      @Semantics.quantity: { unitOfMeasure: 'HeaderWeightUnit'}
      HeaderNetWeight,

      @Semantics.unitOfMeasure: true
      @Consumption.filter.hidden: true
      HeaderWeightUnit,

      @UI.fieldGroup: {qualifier: 'GeneralInfoBlock1', position: 40,  importance: #HIGH}
      @Semantics.quantity: { unitOfMeasure: 'HeaderVolumeUnit'}
      @Consumption.filter.hidden: true
      HeaderVolume,

      @Semantics.unitOfMeasure: true
      @Consumption.filter.hidden: true
      HeaderVolumeUnit,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock2', position: 5, importance: #HIGH},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      DocumentDate,

      @ObjectModel.text.element: ['DeliveryDocumentTypeName']
      @UI.fieldGroup: {qualifier: 'GeneralInfoBlock1', position: 60,  importance: #HIGH}
      OutboundDelivery._DeliveryDocumentType.DeliveryDocumentType                                                                   as DeliveryDocumentType,

      @UI.fieldGroup: [{  qualifier: 'GeneralInfoBlock2',
                          position: 10,
                          importance: #HIGH,
                          criticality: 'PickingDateCriticality',
                          criticalityRepresentation: #WITHOUT_ICON },
                       {  qualifier: 'GenericFilter',
                          groupLabel: 'Outbound Delivery' }
                      ]
      PickingDate,

      @UI.hidden
      cast(
          case
            when OverallPickingStatus = '' then 0
            else
              case
                when  OutboundDelivery.PickingDate < $session.system_date and (OverallPickingStatus = 'A' or OverallPickingStatus = 'B')  then 1
                else
                  case
                    when OutboundDelivery.PickingDate = $session.system_date and (OverallPickingStatus = 'A' or OverallPickingStatus = 'B') then 2
                    else
                      case
                        when OutboundDelivery.PickingDate > $session.system_date and (OverallPickingStatus = 'A' or OverallPickingStatus = 'B') then 3
                        else 0
                      end
                  end
             end
          end as abap.int1
      )                                                                                                                             as PickingDateCriticality,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock2', position: 20, importance: #HIGH},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      cast( TransportationPlanningDate as tddat_plan)                                                                               as TransportationPlanningDate,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock2', position: 30, importance: #HIGH},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      LoadingDate,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock2',
                        position: 40,
                        importance: #HIGH,
                        criticality: 'PlannedGIDateCriticality',
                        criticalityRepresentation: #WITHOUT_ICON },
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      cast(PlannedGoodsIssueDate as wadak_plan)                                                                                     as PlannedGoodsIssueDate,

      @UI.hidden
      cast(
           case
            when OverallGoodsMovementStatus = 'C' then 0
            else
              case
                when OutboundDelivery.PlannedGoodsIssueDate < $session.system_date and OverallGoodsMovementStatus != 'C' then 1
                else
                  case
                    when OutboundDelivery.PlannedGoodsIssueDate = $session.system_date and OverallGoodsMovementStatus != 'C' then 2
                    else
                      case
                        when OutboundDelivery.PlannedGoodsIssueDate > $session.system_date and OverallGoodsMovementStatus != 'C' then 3
                        else 0
                      end
                  end
             end
          end as abap.int1
      )                                                                                                                             as PlannedGIDateCriticality,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock2',
                        position: 50,
                        importance: #HIGH,
                        criticality: 'ActualGIDateCriticality',
                        criticalityRepresentation: #WITHOUT_ICON },
                       {qualifier: 'GenericFilter',
                        groupLabel: 'Outbound Delivery' }
                      ]
      cast(ActualGoodsMovementDate as vdm_actualgmdate)                                                                             as ActualGoodsMovementDate,

      @UI.hidden
      case
        when OutboundDelivery.ActualGoodsMovementDate = '00000000' then 0
        else
          case
            when  OutboundDelivery.ActualGoodsMovementDate > OutboundDelivery.PlannedGoodsIssueDate then 1
            else
              case
                when OutboundDelivery.ActualGoodsMovementDate = OutboundDelivery.PlannedGoodsIssueDate then 2
                else
                  case
                    when OutboundDelivery.ActualGoodsMovementDate < OutboundDelivery.PlannedGoodsIssueDate then 3
                    else 0
                  end
              end
          end
      end                                                                                                                           as ActualGIDateCriticality,

      //Warehouse
      //**********************************************************************************************

      @Consumption.filter.hidden: true
      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 10, importance: #HIGH},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @ObjectModel.foreignKey.association: '_OverallPickingStatus'
      cast(OverallPickingStatus as kostk_code)                                                                                      as OverallPickingStatus,

      @Consumption.filter.hidden: true
      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 20, importance: #HIGH, label: 'Warehouse Management Status'},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @EndUserText.label: 'Warehouse Management Status'
      OverallWarehouseActivityStatus,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 30, importance: #HIGH, label: 'Pick Confirmation Status'},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @EndUserText.label: 'Pick Confirmation Status'
      OverallPickingConfStatus,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 40, importance: #HIGH, label: 'Packing Status'},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @EndUserText.label: 'Packing Status'
      OverallPackingStatus,

      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 50, importance: #HIGH, label: 'Goods Movement Status',  criticality: 'OvrlGdsMovementStsCriticality'},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      @EndUserText.label: 'Goods Movement Status'
      OverallGoodsMovementStatus,

      @UI.hidden
      cast(
          case OverallGoodsMovementStatus
            when '' then 0
            when 'A' then 2
            when 'B' then 2
            when 'C' then 3
            else 0
         end as abap.int1
      )                                                                                                                             as OvrlGdsMovementStsCriticality,


      @ObjectModel.foreignKey.association: '_DelivAdvncdShipgRcvgRlvnce'
      @UI.fieldGroup: [ {qualifier: 'GeneralInfoBlock3', position: 100, importance: #HIGH},
                        {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' } ]
      @EndUserText.label: 'Advanced Shipping and Receiving Relevance'
      @Feature: 'LE_SHP_ASR_SHOW_FIELDS'
      DelivAdvncdShipgRcvgRlvnce,


      @ObjectModel.foreignKey.association: '_WarehouseExecutionStatus'
      @UI.fieldGroup: [ {qualifier: 'GeneralInfoBlock3', position: 110, importance: #HIGH},
                        {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' } ]
      @EndUserText.label: 'Warehouse Execution Status'
      @Feature: 'LE_SHP_ASR_SHOW_FIELDS'
      ReadyForWarehouseExecStatus,

      //Product Compliance Fields
      //**********************************************************************************************

      //Product Marketability
      @ObjectModel.foreignKey.association:'_OverallChmlCmplncStatus'
      @EndUserText.label: 'Product Marketability Status'
      @UI.fieldGroup: [//{qualifier: 'GeneralInfoBlock3',position: 60},
                       {qualifier: 'GeneralInfoBlock3',position: 60, criticality: 'OvrlChmlCmplncStsCriticality', criticalityRepresentation: #WITHOUT_ICON},
                       {qualifier: 'GenericFilter', groupLabel: 'Outbound Delivery' }]
      OverallChmlCmplncStatus,

      @UI.hidden
      cast(
        case OverallChmlCmplncStatus
          when '' then 0  //not relevant
          when 'A' then 3 //Approved
          when 'C' then 1 //Blocked Not Marketable
          when 'D' then 1 //Blocked Not Approved
          else 0
        end as abap.int1)                                                                                                           as OvrlChmlCmplncStsCriticality,

      //Dangerous Goods
      @ObjectModel.foreignKey.association: '_OverallDangerousGoodsStatus'
      @EndUserText.label: 'Dangerous Goods Status'
      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 70, criticality: 'OvrlDngrsGdsStsCriticality', criticalityRepresentation: #WITHOUT_ICON }]
      OverallDangerousGoodsStatus,

      @UI.hidden
      cast(
      case OverallDangerousGoodsStatus
        when '' then 0  //No Dangerous Goods, Not Relevant
        when 'A' then 3 //Ok Dangerous Goods Transport Allowed
        when 'B' then 2 //Warning dangerous Goods Transport Restricted
        when 'D' then 1 //Blocked - Dangerous Goods Transport Forbidden
        else 0
      end as abap.int1 )                                                                                                            as OvrlDngrsGdsStsCriticality,

      //Safety Data Sheet
      @ObjectModel.foreignKey.association: '_OvrlSftyDataSheetSts'
      @EndUserText.label: 'Safety Data Sheet Status '
      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 80 , criticality: 'OvrlSftyDataSheetStsCritlty', criticalityRepresentation: #WITHOUT_ICON}]
      OverallSafetyDataSheetStatus,






      @ObjectModel.foreignKey.association: '_ExternalTCOTimezone'
      @EndUserText.label: 'Time Zone '
      IntcoExtTransfOfCtrlDteTmeTmzn,
      IntcoExtActlTransfOfCtrlDteTme,
      IntcoExtPlndTransfOfCtrlDteTme,

      @ObjectModel.foreignKey.association: '_InternalTCOTimezone'
      @EndUserText.label: 'Time Zone '
      IntcoIntTransfOfCtrlDteTmeTmzn,
      IntcoIntActlTransfOfCtrlDteTme,
      IntcoIntPlndTransfOfCtrlDteTme,

      @EndUserText.label: 'Planned Date'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_FORMAT_TCD'
      cast ('' as char0064)                                                                                                         as ExtPlndTransfOfCtrlFrmdDTVal,

      @EndUserText.label: 'Actual Date'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_FORMAT_TCD'
      cast ('' as char0064)                                                                                                         as ExtActlTransfOfCtrlFrmdDTVal,

      @EndUserText.label: 'Planned Date'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_FORMAT_TCD'
      cast ('' as char0064)                                                                                                         as IntPlndTransfOfCtrlFrmdDTVal,

      @EndUserText.label: 'Actual Date'
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_FORMAT_TCD'
      cast ('' as char0064)                                                                                                         as IntActlTransfOfCtrlFrmdDTVal,





      @UI.hidden
      cast (
      case OverallSafetyDataSheetStatus
        when '' then 0  //Ok - Not Relevant
        when 'A' then 3 //Ok - Approved
        when 'B' then 2 //Warning
        when 'D' then 1 //Blocked
        else 0
      end as abap.int1 )                                                                                                            as OvrlSftyDataSheetStsCritlty,


      //EMCS Integration - Excise Tax
      @UI.fieldGroup: [{qualifier: 'GeneralInfoBlock3', position: 90 }]
      @EndUserText.label: 'Excise Tax ARC Status'
      @ObjectModel.foreignKey.association: '_ExciseTaxStatus'
      EU_DeliveryARCStatus,


      @UI.hidden: true
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_OUTPUT_ACTIVE'
      cast('' as char005)                                                                                                           as IsActive, //is active flag for output control


      @UI.hidden: true
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_EMCS_ACTIVE'
      cast('' as xfeld)                                                                                                             as ExciseMovementIsActive,


      @UI.hidden: true
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_TCD_RELEVANT'
      cast('' as xfeld)                                                                                                             as IntTransfOfCtrlDteAreRelevant,

      @UI.hidden: true
      @ObjectModel.readOnly: true
      @ObjectModel.virtualElement
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:CL_LE_TCD_RELEVANT'
      cast('' as xfeld)                                                                                                             as ExtTransfOfCtrlDteAreRelevant,


      _Partner,
      @Consumption.filter.hidden: true
      _ShipToParty,
      @Consumption.filter.hidden: true
      _SoldToParty,
      @Consumption.filter.hidden: true
      _ShippingPoint,
      @Consumption.filter.hidden: true
      _OverallPickingStatus,
      @Consumption.filter.hidden: true
      _OvrlWarehouseActyStatus,
      @Consumption.filter.hidden: true
      _OverallPickingConfStatus,
      @Consumption.filter.hidden: true
      _OverallPackingStatus,
      @Consumption.filter.hidden: true
      _OverallGoodsMovementStatus,
      _OutboundDeliveryItemFs,
      @Consumption.filter.hidden: true
      _SalesOrganization,

      @Consumption.filter.hidden: true
      _OverallChmlCmplncStatus,
      @Consumption.filter.hidden: true
      _OverallDangerousGoodsStatus,
      @Consumption.filter.hidden: true
      _OvrlSftyDataSheetSts,
      @Consumption.filter.hidden: true
      _ExternalTCOTimezone,
      @Consumption.filter.hidden: true
      _InternalTCOTimezone,
      @Consumption.filter.hidden: true
      _ExciseTaxStatus,
      @Consumption.filter.hidden: true
      _WarehouseExecutionStatus,
      @Consumption.filter.hidden: true
      _DelivAdvncdShipgRcvgRlvnce

}
