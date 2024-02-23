//***********************************************************************
// R E V I S I O N   H I S T O R Y                                     *
//***********************************************************************
// AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
//              |            | TRANSPORT REQUESTS                       *
//***********************************************************************
// HURTSALE     | 31.07.2023 | 23764   : SO Mass Change further improvements*
//              |            | DS4K959588                               *
//----------------------------------------------------------------------*

@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'View for SO Header RDD Re-determination'

@ObjectModel.representativeKey: 'SalesDocument'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define root view entity ZSD_I_SOHDRRDDREDETERMINATION
  as select from I_SalesDocument
  association [0..1] to E_SalesDocumentBasic as _Extension on $projection.SalesDocument = _Extension.SalesDocument
{
  key SalesDocument,

      DistributionChannel,
      SalesOrganization,
      OrganizationDivision,
      SalesDocumentType,

      _SalesDocumentType,
      _OrganizationDivision,
      _DistributionChannel,
      _SalesOrganization,
      _Extension

}
