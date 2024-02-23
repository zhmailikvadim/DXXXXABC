/****************************************************************************************************
*  R E V I S I O N   H I S T O R Y                                                                  *
*****************************************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION                                           *
*              |            | TRANSPORT REQUESTS                                                    *
*****************************************************************************************************
* ZAICHART     | 09.10.2023 | FB_25427_SD_Feature - Create a report similar as Z_ADI_INTRASTAT in S4*
*              |            | DS4K966195                                                            *
*---------------------------------------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDEPLANT'
@EndUserText.label: 'Extension for Plant view'
extend view I_Plant with ZSD_E_PLANT
{
    land1 as ZZ_Country
}
