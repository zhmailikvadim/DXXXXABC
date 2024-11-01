@AbapCatalog.sqlViewName: 'ZRA_Q_B_ADAP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic CDS for ZRA_D_ADAP Table'
define view ZRA_I_B_ADAP as select from zra_d_adap {
key cmat_item_uuid,
    park_id, 
    farm_id,
    model_adapter,
    batch_adapter,      
    year_of_issue,
    data_of_issue,
    description,       
    user_who_changed,
    date_changed,
    time_changed  
 
 }

