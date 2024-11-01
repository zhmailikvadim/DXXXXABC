@EndUserText.label: 'Соимостные значения ОС'
 @ClientHandling.type: #CLIENT_DEPENDENT
 @ClientHandling.algorithm: #SESSION_VARIABLE
-- Ракурс для расчета стоимостей ОС
define table function zaa_v_val_ng 
  with parameters
    @Environment.systemField: #CLIENT
    p_clnt : abap.clnt  
returns
{  
  key client : mandt;
  key bukrs  : bukrs;   -- БЕ
  key anln1  : anln1;   -- Системный номер ОСА
  key anln2  : anln2;   -- Субномер ОС
  key afabe  : afabe_d; -- Область оценки
      invnr  : invnr;   -- Инвентарный номер
      deakt  : deakt;   -- Дата списания
      budat  : budat;
      bwasl  : bwasl;
      kansw  : kansw;   -- ПС на начало года и все изменения ПС (поступления, выбытия, переоценка) за текущий год до даты отчета
      kaufw  : kaufw;   -- Повышение восстановительной стоимости
      knafa  : knafa;   -- Накопленная амортизация типовая
      kaafa  : kaafa;   -- Внеплановая амортизация
      kaufn  : kaufn;   -- Коррект. амортизации
      netvl  : vtcur12; -- Остаточная стоимость
      lnran  : lnran;
      lnsan  : lnsan;
      monat  : monat;
      belnr  : belnr_d; 
}
implemented by method
  zaa_utils_hdb=>get_asset_val_ng;