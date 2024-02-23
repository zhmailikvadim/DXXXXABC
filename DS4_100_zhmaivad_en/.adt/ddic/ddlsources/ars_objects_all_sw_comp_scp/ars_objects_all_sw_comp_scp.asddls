//*************************************************
// The view returns objects which are in the predefined software component
//
// In objects of ABAP language version "SAP Cloud Platform", references to other objects are allowed according to the following rules:
// Customer Objects are stored in Customer Software Component,
//   - in an  "SAP Cloud Platform" system the ABAP_LANGUAGE_VERSION = 5  needs to be configured for all Customer Software Components
//   - this view allowes to retrieved all objects within this configured Software Compoents (e.g. to determine Customer Objects)
//
// Element Definition:
//   - PROGRAM_ID: Program ID of object in software component ('R3TR' as given in field PGMID of table TADIR)
//   - P_OBJECT_TYPE: Object directory type of object in software component (e.g. 'TABLE' as given in field OBJECT of table TADIR)
//   - P_OBJECT_NAME: Object directory name of object in software component (as given in field OBJ_NAME of table TADIR)
//*************************************************
@AbapCatalog.sqlViewName: 'ARS_OBJ_ALL_SWC'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SCP: Objects in all Cust. Software Comp.'
define view ARS_OBJECTS_ALL_SW_COMP_SCP
  as select from tadir
    inner join   tdevc                                      on tdevc.devclass = tadir.devclass
    inner join   ARS_SOFTWARE_COMPONENTS_SCP as abap_config on abap_config.software_component = tdevc.dlvunit
{
  tadir.pgmid                             as program_id,
  tadir.object                            as object_type,
  tadir.obj_name                          as object_name,
  tadir.devclass                          as package_name,
  abap_config.software_component          as software_component,
  abap_config.is_local_software_component as is_local_software_component,
  abap_config.is_installed_component      as is_installed_component
}
