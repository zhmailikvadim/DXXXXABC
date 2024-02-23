//***********************************************************************
// R E V I S I O N   H I S T O R Y                                     *
//***********************************************************************
// AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
//              |            | TRANSPORT REQUESTS                       *
//***********************************************************************
// GUPTANI1     | 12.08.2022 | 13664   : SO Mass Update Tool Enhancemant*
//              |            | DS4K935304                               *
//----------------------------------------------------------------------*
@EndUserText.label: 'Projection View SO Header Text Mass Upd'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZSD_C_SOHDRTXT 
provider contract transactional_query
as projection on ZSD_I_SOHDRTXT {

    key Sohtextuuid,
    Tdobject,
    Tdid,
    Tdspras,
    Text,
    Action,
    changedat,
    
    /* Associations */
    _headertexti: redirected to composition child ZSD_C_SOHDRTXTI,
    _language,
    _textobject
}
