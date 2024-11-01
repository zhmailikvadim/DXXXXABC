@AbapCatalog.sqlViewName: 'zcoicska'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'KSTAR 308* for Kontur'
define view ZCO_I_CSKA_KONTUR
  as select from cska
    inner join   csku as a on  a.ktopl = cska.ktopl
                           and a.kstar = cska.kstar
{
  key cska.ktopl,
  key cska.kstar as code,
      ltext      as name
} 
where
      spras = $session.system_language
 //cska.kstar like '308%' 
 