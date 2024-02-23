//***********************************************************************
// R E V I S I O N   H I S T O R Y                                     *
//***********************************************************************
// AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
//              |            | TRANSPORT REQUESTS                       *
//***********************************************************************
// HURTSALE     | 31.07.2023 | 23764   : SO Mass Change further improvements*
//              |            | DS4K959588                               *
//----------------------------------------------------------------------*


@EndUserText.label: 'Projection View SO RDD Re-determination'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define root view entity ZSD_C_SOHDRRDDREDETERMINATION
  provider contract transactional_query
  as projection on ZSD_I_SOHDRRDDREDETERMINATION
{
  key SalesDocument,
      DistributionChannel,
      SalesOrganization,
      OrganizationDivision,
      SalesDocumentType,
      /* Associations */
      _DistributionChannel,
      _Extension,
      _OrganizationDivision,
      _SalesDocumentType,
      _SalesOrganization
}
