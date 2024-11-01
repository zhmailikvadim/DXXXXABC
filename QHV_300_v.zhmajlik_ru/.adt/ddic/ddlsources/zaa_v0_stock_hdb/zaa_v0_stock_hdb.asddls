@AbapCatalog.sqlViewName: 'ZAA_V0_STOCK'
@AbapCatalog.compiler.compareFilter: true
@ClientHandling.type: #CLIENT_DEPENDENT
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Запас ОСна дату'
define view Zaa_V0_Stock_Hdb
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt,
    p_date : date -- расчет на дату
  as select from Zaa_V2_Stock(  p_clnt: $parameters.p_clnt, p_date:$parameters.p_date, p_amnt: '' ) as z
    inner join   t001 on t001.bukrs = z.bukrs
{
  z.client,
  z.bukrs, --БЕ
  z.anln1, -- Системный номер ОСА
  z.anln2, -- Субномер ОС
  z.afabe, -- Область оценки
  @Semantics.currencyCode
  t001.waers as waers,
  @Semantics.amount.currencyCode: 'waers'
  z.kansw, -- ПС на начало года и все изменения ПС (поступления, выбытия, переоценка) за текущий год до даты отчета
  @Semantics.amount.currencyCode: 'waers'
  z.kaufw, -- Повышение восстановительной стоимости
  @Semantics.amount.currencyCode: 'waers'
  z.knafa, -- Накопленная амортизация типовая
  @Semantics.amount.currencyCode: 'waers'
  z.kaafa, -- Внеплановая амортизация
  @Semantics.amount.currencyCode: 'waers'
  z.kaufn, -- Коррект. амортизации
  @Semantics.amount.currencyCode: 'waers'
  z.netvl  -- Остаточная стоимость

} 
 