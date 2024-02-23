@AccessControl.authorizationCheck: #NOT_REQUIRED
@AbapCatalog.sqlViewName: 'ZZ1_41BD51EA3BFD'
@EndUserText.label: 'Rejection Reason'
@AbapCatalog.compiler.compareFilter: true
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
@DataAging.noAgingRestriction: true
@ObjectModel.representativeKey: 'SalesDocumentRjcnReason'

define view ZZ1_I_RejectionReason_VH

as select from I_SalesDocumentRjcnReason as I_SalesDocumentRjcnReason

{
@EndUserText.label: 'Reason for Rejection'
@ObjectModel.text.element: null
@Semantics: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: '_Text'
@Consumption.labelElement: null
@Consumption.groupWithElement: null
@Consumption.valueHelp: null
@Consumption.hidden: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_SalesDocumentRjcnReason.SalesDocumentRjcnReason as SalesDocumentRjcnReason,

@EndUserText.label: '_Text'
@ObjectModel.association.type: null
@ObjectModel.text.element: null
@Semantics: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@Consumption.labelElement: null
@Consumption.groupWithElement: null
@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_SalesDocumentRjcnReason._Text as _Text
}
