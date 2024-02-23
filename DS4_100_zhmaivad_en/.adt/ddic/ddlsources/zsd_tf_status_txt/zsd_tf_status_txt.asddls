@EndUserText.label: 'Get latest create date/time of IDoc'
@AccessControl.authorizationCheck: #CHECK
define table function zsd_tf_status_txt
returns
{
  client : mandt;
  docnum : edi_docnum;
  status : edi_status;
  statxt : edi_statx_;
  credat : edi_credat;
  cretim : edi_cretim;
  stapa1 : edi_stapa1;
  stapa2 : edi_stapa2;
  stapa3 : edi_stapa3;
  stapa4 : edi_stapa4;
}
implemented by method
  zcl_sd_idoc_status_txt=>get_latest_status_txt;