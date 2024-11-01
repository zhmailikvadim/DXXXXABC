@EndUserText.label: 'Значения ОС ро сроку эксплуатации '
 @ClientHandling.type: #CLIENT_DEPENDENT
 @ClientHandling.algorithm: #SESSION_VARIABLE

-- Ракурс для расчета стоимостей ОС
define table function ZAA_ASSET_SPI
  with parameters
    @Environment.systemField: #CLIENT
    iv_clnt : abap.clnt,
    iv_date : date -- расчет на дату
    
returns
{
  key CLIENT : mandt;
  key BUKRS  : bukrs; --БЕ
  key ANLN1  : anln1; -- СИСТЕМНЫЙ НОМЕР ОСА
  key ANLN2  : anln2; -- СУБНОМЕР ОС
  key AFABE  : afabe_d; -- ОБЛАСТЬ ОЦЕНКИ
      AFABG  : afabg;
      AFASL  : afasl;  
      NDPER  : ndper; 
      NDJAR  : ndjar; 
      USEP   : ndabp; -- ИСТЕКШИЙ СРОК СЛУЖБЫ В МЕСЯЦАХ
      USEJ   : ndabj; -- ИСТЕКШИЙ СРОК СЛУЖБЫ В ГОДАХ
      RESTP  : ndabp; -- ОСТАВШИЙСЯ СРОК СЛУЖБЫ В МЕСЯЦАХ
      RESTJ  : ndabj; -- ОСТАВШИЙСЯ СРОК СЛУЖБЫ В ГОДАХ
      
}
implemented by method
  zaa_utils_hdb=>get_asset_spi;