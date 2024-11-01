@EndUserText.label: 'ОСы по дате окончания амортизации'
@ClientHandling.type: #CLIENT_DEPENDENT
-- Ракурс для расчета даты окончания амортизации
define table function zaa_asset_calc_dates
  with parameters
    @Environment.systemField: #CLIENT
    iv_clnt : abap.clnt
      
returns
 
{  
  key CLIENT     : mandt;  
  key BUKRS      : bukrs; --БЕ
  key ANLN1      : anln1; -- СИСТЕМНЫЙ НОМЕР ОСА
  key ANLN2      : anln2; -- СУБНОМЕР ОС
  key AFABE      : afabe_d; -- ОБЛАСТЬ ОЦЕНКИ
      AFABG      : afabg; -- Дата начала расчета амортизации 
      NDPER      : ndper; -- Запланированный скор эксплуатации в периодах
      NDJAR      : ndjar; -- Запланированный скор эксплуатации в годах     
      depEndDate : dats; -- Дата окончания начисления амортизации    
}

implemented by method
  zaa_utils_hdb=>get_asset_calc_dates;