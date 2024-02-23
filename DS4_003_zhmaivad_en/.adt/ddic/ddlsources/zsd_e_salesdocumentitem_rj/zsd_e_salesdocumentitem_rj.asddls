/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* ZHMAIVAD     | 26.01.2023 | 17218     : Feature - Supply Demand Over *
*              |            | DS4K941347                               *
*----------------------------------------------------------------------*/
@AbapCatalog.sqlViewAppendName: 'ZSDESDSLSDOCITMR'
@EndUserText.label: 'I_SalesDocumentItemBasic Extend View RJ'
extend view I_SalesDocumentItem with zsd_e_salesdocumentitem_rj
  association to zpd_t_mvke_seas as _ArticleSeasonMvke on  $projection.Material            = _ArticleSeasonMvke.matnr
                                                       and $projection.SalesOrganization   = _ArticleSeasonMvke.vkorg
                                                       and $projection.DistributionChannel = _ArticleSeasonMvke.vtweg
                                                       and $projection.ProductSeason       = _ArticleSeasonMvke.fsh_season
                                                       and $projection.ProductSeasonYear   = _ArticleSeasonMvke.fsh_season_year
{
  vbap.zz1_otcdldate_sdi as FulfillmentDate,
  vbap.zz1_delscen_sdi   as FulfillmentScenario,
  vbap.zz1_wwpri_sdi     as PRE_RE_Indicator,
  vbap.zz1_rsd_item      as RequestedShelfDate,
  vbap.kunrg_ana         as Payer,
  vbap.augru_ana         as OrderReason,
  vbkd.bsark             as SoldToPartyPoType,
  vbap.fsh_pqr_uepos     as HigherLevItemPartQuantityRej,
  vbap.eannr             as EAN,
  vbak.gueen             as AgrmtValdtyEndDate,
  _ArticleSeasonMvke
}
