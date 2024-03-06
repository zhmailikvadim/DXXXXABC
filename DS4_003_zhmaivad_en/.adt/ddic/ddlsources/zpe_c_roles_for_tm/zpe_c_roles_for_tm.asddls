/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* RUTKOVIA     | 18.07.2022 | 12218     : [Fiori Launchpad Documentation] AppDocu *
*              |            | DS4K924286                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Roles for target mmppings'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPE_C_ROLES_FOR_TM
  as select distinct from ZPE_I_ROLES_FOR_CATALOGS as roles
    inner join            ZPE_I_BUSINESS_CATALOGS  as bus_cat on roles.tech_name = bus_cat.bus_cat_tech_name
  association [1..1] to ZPE_C_TM_CUSTOM_CATALOGS as _Tm on _Tm.domainid = bus_cat.domainid
{

  key bus_cat.domainid,
  key roles.business_role as busRole,
      roles.text          as busRoleTitle,

      _Tm

}
where
     roles.business_role like 'Y%'
  or roles.business_role like 'Z%'
