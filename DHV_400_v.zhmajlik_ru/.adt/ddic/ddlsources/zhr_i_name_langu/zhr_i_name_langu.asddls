@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AbapCatalog.sqlViewName: 'ZHRINAMELANGU'

@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'Наименование языка'

@UI.textArrangement: #TEXT_FIRST
@OData.publish: true

define view ZHR_I_NAME_LANGU
  as select from zhrp1000        as hrp1000

    inner join   ZHR_I_HRP1001_Q as hrp1001 on hrp1001.sobid = hrp1000.objid

{
      @EndUserText.label: 'Наименование'
  key mc_stext as Description,

      @ObjectModel.text.element: [ 'Description' ]
      @UI.hidden: true
      objid    as objid
}

where langu = $session.system_language 
 