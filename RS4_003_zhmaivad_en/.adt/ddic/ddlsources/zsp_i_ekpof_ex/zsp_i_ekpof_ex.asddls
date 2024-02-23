/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
*----------------------------------------------------------------------*
* TKEBUEKA     | 24.10.2022 |  FB_14286_FI_PO/AR Compliance Extraction from  S4   *
*              |            |  DS4K932366                           *
*----------------------------------------------------------------------*
* ZHMAIVAD     | 24.02.2023 |  FB_18221_SD_Feature - DEFECT - [6162] - Caselot data  *
*              |            |  DS4K944432                          *
*----------------------------------------------------------------------*
* DOLYADMI     | 08.06.2023 |  FB_22116_SD_Feature - [Defect] - Preceding Document  *
*              |            |  DS4K954929                          *
*----------------------------------------------------------------------*/

@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AccessControl.authorizationCheck: #CHECK
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel: {
    usageType: {
        sizeCategory: #XXL,
        serviceQuality: #B,
        dataClass: #TRANSACTIONAL
    },
    representativeKey: 'ebeln'}
@Analytics:{
        dataExtraction: {
         enabled: true,
        delta.changeDataCapture: {  
        mapping : [ {
           table:'EKPO',
           role:#MAIN,
           viewElement : ['ebeln','ebelp'],
           tableElement: ['ebeln','ebelp']
         },
                     {
                       table : 'ekpo',
                       role :#LEFT_OUTER_TO_ONE_JOIN,
                       viewElement : ['EBELN','EBELP'],
                       tableElement: ['EBELN','EBELP']
                                            
                     }
            
        ]
      }
   }
}
@VDM.viewType: #BASIC
@EndUserText.label:'PurchasingDocumentItem'
define view entity ZSP_I_EKPOF_EX as select from  ekpo
left outer join ekko
on ekpo.ebeln=ekko.ebeln    
{
    key ekpo.ebeln                                                ,
    key ekpo.ebelp                                                ,
    ekpo.uniqueid   , //    Concatenation of EBELN and EBELP
    ekpo.loekz   , //    Deletion indicator in purchasing document
    ekpo.statu   , //    Origin of a Purchasing Document Item
    ekpo.aedat   , //    Purchasing Document Item Change Date
    ekpo.txz01   , //    Short Text
    ekpo.matnr   , //    Material Number
    ekpo.ematn   , //    Material number
    ekpo.bukrs   , //    Company Code
    ekpo.werks   , //    Plant
    ekpo.lgort   , //    Storage location
    ekpo.bednr   , //    Requirement Tracking Number
    ekpo.matkl   , //    Material Group
    ekpo.infnr   , //    Number of purchasing info record
    ekpo.idnlf   , //    Material Number Used by Supplier
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.ktmng   , //    Target Quantity
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.menge   , //    Purchase Order Quantity
    ekpo.meins   , //    Purchase Order Unit of Measure
    ekpo.bprme   , //    Order Price Unit (Purchasing)
    ekpo.bpumz   , //    Numerator for Conversion of Order Price Unit into Order Unit
    ekpo.bpumn   , //    Denominator for Conv. of Order Price Unit into Order Unit
    ekpo.umrez   , //    Numerator for Conversion of Order Unit to Base Unit
    ekpo.umren   , //    Denominator for Conversion of Order Unit to Base Unit
    ekko.waers,
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.netpr   , //    Net Price in Purchasing Document (in Document Currency)
    ekpo.peinh   , //    Price unit
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.netwr   , //    Net Order Value in PO Currency
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.brtwr   , //    Gross order value in PO currency
    ekpo.agdat   , //    Deadline for Submission of Bid/Quotation
    ekpo.webaz   , //    Goods receipt processing time in days
    ekpo.mwskz   , //    Tax on sales/purchases code
    ekpo.txdat_from  , //    Valid-From Date of the Tax Rate
    ekpo.txdat   , //    Date for Determining Tax Rates
    ekpo.tax_country , //    Tax Reporting Country/Region
    ekpo.bonus   , //    Settlement Group 1 (Purchasing)
    ekpo.insmk   , //    Stock Type
    ekpo.spinf   , //    Indicator: Update Info Record
    ekpo.prsdr   , //    Price Printout
    ekpo.schpr   , //    Indicator: Estimated Price
    ekpo.mahnz   , //    Number of Reminders/Expediters
    ekpo.mahn1   , //    Number of Days for First Reminder/Expediter
    ekpo.mahn2   , //    Number of Days for Second Reminder/Expediter
    ekpo.mahn3   , //    Number of Days for Third Reminder/Expediter
    ekpo.uebto   , //    Overdelivery Tolerance
    ekpo.uebtk   , //    Unlimited Overdelivery Allowed
    ekpo.untto   , //    Underdelivery Tolerance
    ekpo.bwtar   , //    Valuation Type
    ekpo.bwtty   , //    Valuation Category
    ekpo.abskz   , //    Rejection Indicator
    ekpo.agmem   , //    Internal Comment on Quotation
    ekpo.elikz   , //    Delivery Completed Indicator
    ekpo.erekz   , //    Final Invoice Indicator
    ekpo.pstyp   , //    Item category in purchasing document
    ekpo.knttp   , //    Account Assignment Category
    ekpo.kzvbr   , //    Consumption posting
    ekpo.vrtkz   , //    Distribution Indicator for Multiple Account Assignment
    ekpo.twrkz   , //    Partial invoice indicator
    ekpo.wepos   , //    Goods Receipt Indicator
    ekpo.weunb   , //    Goods Receipt, Non-Valuated
    ekpo.repos   , //    Invoice receipt indicator
    ekpo.webre   , //    Indicator: GR-Based Invoice Verification
    ekpo.kzabs   , //    Order Acknowledgment Requirement
    ekpo.labnr   , //    Order Acknowledgment Number
    ekpo.konnr   , //    Number of principal purchase agreement
    ekpo.ktpnr   , //    Item number of principal purchase agreement
    ekpo.abdat   , //    Reconciliation date for agreed cumulative quantity
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.abftz   , //    Agreed Cumulative Quantity
    ekpo.etfz1   , //    Firm Zone (Go-Ahead for Production)
    ekpo.etfz2   , //    Trade-Off Zone (Go-Ahead for Materials Procurement)
    ekpo.kzstu   , //    Firm/Trade-Off Zones Binding with Regard to Mat. Planning
    ekpo.notkz   , //    Exclusion in Outline Agreement Item with Material Class
    ekpo.lmein   , //    Base Unit of Measure
    ekpo.evers   , //    Shipping Instructions
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.zwert   , //    Target Value for Outline Agreement in Document Currency
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.navnw   , //    Non-deductible input tax
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.abmng   , //    Standard release order quantity
    ekpo.prdat   , //    Date of Price Determination
    ekpo.bstyp   , //    Purchasing Document Category
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.effwr   , //    Effective value of item
    ekpo.xoblr   , //    Item affects commitments
    ekpo.kunnr   , //    Customer
    ekpo.adrnr   , //    Manual address number in purchasing document item
    ekpo.ekkol   , //    Condition Group with Supplier
    ekpo.sktof   , //    Item Does Not Qualify for Cash Discount
    ekpo.stafo   , //    Update Group for statistics update
    ekpo.plifz   , //    Planned Delivery Time in Days
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'GEWEI'} }
    ekpo.ntgew   , //    Net Weight
    ekpo.gewei   , //    Unit of Weight
    ekpo.txjcd   , //    Tax Jurisdiction
    ekpo.etdrk   , //    Indicator: Print-relevant schedule lines exist
    ekpo.sobkz   , //    Special Stock Indicator
    ekpo.arsnr   , //    Settlement reservation number
    ekpo.arsps   , //    Item number of the settlement reservation
    ekpo.insnc   , //    Quality inspection indicator cannot be changed
    ekpo.ssqss   , //    Control Key for Quality Management in Procurement
    ekpo.zgtyp   , //    Certificate Type
    ekpo.ean11   , //    International Article Number (EAN/UPC)
    ekpo.bstae   , //    Confirmation Control Key
    ekpo.revlv   , //    Revision Level
    ekpo.geber   , //    Fund
    ekpo.fistl   , //    Funds Center
    ekpo.fipos   , //    Commitment Item
    ekpo.ko_gsber    , //    Business area reported to the partner
    ekpo.ko_pargb    , //    assumed business area of the business partner
    ekpo.ko_prctr    , //    Profit Center
    ekpo.ko_pprctr   , //    Partner Profit Center
    ekpo.meprf   , //    Price Determination (Pricing) Date Control
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'GEWEI'} }
    ekpo.brgew   , //    Gross weight
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'VOLEH'} }
    ekpo.volum   , //    Volume
    ekpo.voleh   , //    Volume unit
    ekpo.inco1   , //    Incoterms (Part 1)
    ekpo.inco2   , //    Incoterms (Part 2)
    ekpo.vorab   , //    Advance procurement: project stock
    ekpo.kolif   , //    Prior Supplier
    ekpo.ltsnr   , //    Supplier Subrange
    ekpo.packno  , //    Package number
    ekpo.fplnr   , //    Invoicing plan number
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.gnetwr  , //    Currently not used
    ekpo.stapo   , //    Item is statistical
    ekpo.uebpo   , //    Higher-Level Item in Purchasing Documents
    ekpo.lewed   , //    Latest Possible Goods Receipt
    ekpo.emlif   , //    Supplier to be Supplied/Who is to Receive Delivery
    ekpo.lblkz   , //    Subcontracting Supplier
    ekpo.satnr   , //    Cross-Plant Configurable Material
    ekpo.attyp   , //    Material Category
    ekpo.vsart   , //    Shipping Type
    ekpo.handoverloc , //    Location for a physical handover of goods
    ekpo.kanba   , //    Kanban Indicator
    ekpo.adrn2   , //    Number of delivery address
    ekpo.delivery_address_type   , //    Purchasing Delivery Address Type
    ekpo.cuobj   , //    Configuration (internal object number)
    ekpo.xersy   , //    Evaluated Receipt Settlement (ERS)
    ekpo.eildt   , //    Start Date for GR-Based Settlement
    ekpo.drdat   , //    Last Transmission
    ekpo.druhr   , //    Time
    ekpo.drunr   , //    Sequential Number
    ekpo.aktnr   , //    Promotion
    ekpo.abeln   , //    Allocation Table
    ekpo.abelp   , //    Allocation Table Item
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'PUNEI'} }
    ekpo.anzpu   , //    Number of Points
    ekpo.punei   , //    Points Unit
    ekpo.saiso   , //    Season Category
    ekpo.saisj   , //    Season Year
    ekpo.ebon2   , //    Settlement Group 2 (Rebate Settlement, Purchasing)
    ekpo.ebon3   , //    Settlement Group 3 (Rebate Settlement, Purchasing)
    ekpo.ebonf   , //    Item Relevant to Subsequent (Period-End Rebate) Settlement
    ekpo.mlmaa   , //    Material Ledger Activated at Material Level
    ekpo.mhdrz   , //    Minimum Remaining Shelf Life
    ekpo.anfnr   , //    RFQ Number
    ekpo.anfps   , //    Item Number of RFQ
    ekpo.kzkfg   , //    Origin of Configuration
    ekpo.usequ   , //    Quota arrangement usage
    ekpo.umsok   , //    Special stock indicator for physical stock transfer
    ekpo.banfn   , //    Purchase Requisition Number
    ekpo.bnfpo   , //    Item number of purchase requisition
    ekpo.mtart   , //    Material type
    ekpo.uptyp   , //    Subitem Category, Purchasing Document
    ekpo.upvor   , //    Subitems Exist
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.kzwi1   , //    Subtotal 1 from Pricing Procedure for Price Element
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.kzwi2   , //    Subtotal 2 from Pricing Procedure for Price Element
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.kzwi3   , //    Subtotal 3 from Pricing Procedure for Price Element
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.kzwi4   , //    Subtotal 4 from Pricing Procedure for Price Element
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.kzwi5   , //    Subtotal 5 from Pricing Procedure for Price Element
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.kzwi6   , //    Subtotal 6 from Pricing Procedure for Price Element
    ekpo.sikgr   , //    Processing key for sub-items
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.mfzhi   , //    Maximum Cumulative Material Go-Ahead Quantity
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.ffzhi   , //    Maximum Cumulative Production Go-Ahead Quantity
    ekpo.retpo   , //    Returns Item
    ekpo.aurel   , //    Relevant to Allocation Table
    ekpo.bsgru   , //    Reason for Ordering
    ekpo.lfret   , //    Delivery Type for Returns to Supplier
    ekpo.mfrgr   , //    Material freight group
    ekpo.nrfhg   , //    Material qualifies for discount in kind
    ekpo.j_1bnbm , //    Brazilian NCM Code
    ekpo.j_1bmatuse  , //    Usage of the material
    ekpo.j_1bmatorg  , //    Origin of the material
    ekpo.j_1bownpro  , //    Produced in-house
    ekpo.j_1bindust  , //    Material CFOP category
    ekpo.abueb   , //    Release Creation Profile
    ekpo.nlabd   , //    Next Forecast Delivery Schedule Transmission
    ekpo.nfabd   , //    Next JIT Delivery Schedule Transmission
    ekpo.kzbws   , //    Valuation of Special Stock
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.bonba   , //    Rebate Basis 1
    ekpo.fabkz   , //    Indicator: Item Relevant to JIT Delivery Schedules
    ekpo.loadingpoint    , //    Loading/Unloading Point
    ekpo.j_1aindxp   , //    Inflation Index
    ekpo.j_1aidatep  , //    Inflation Index Date
    ekpo.mprof   , //    Mfr part profile
    ekpo.eglkz   , //    Outward Delivery Completed Indicator
    ekpo.kztlf   , //    Partial Delivery at Item Level (Stock Transfer)
    ekpo.kzfme   , //    Units of measure usage
    ekpo.rdprf   , //    Rounding Profile
    ekpo.techs   , //    Parameter Variant/Standard Variant
    ekpo.chg_srv , //    Configuration changed
    ekpo.chg_fplnr   , //    No invoice for this item although not free of charge
    ekpo.mfrpn   , //    Manufacturer Part Number
    ekpo.mfrnr   , //    Manufacturer number
    ekpo.emnfr   , //    External manufacturer code name or number
    ekpo.novet   , //    Item blocked for SD delivery
    ekpo.afnam   , //    Name of requisitioner/requester
    ekpo.tzonrc  , //    Time zone of recipient location
    ekpo.iprkz   , //    Period Indicator for Shelf Life Expiration Date
    ekpo.lebre   , //    Indicator for Service-Based Invoice Verification
    ekpo.berid   , //    MRP Area
    ekpo.xconditions , //    Conditions for item although no invoice
    ekpo.apoms   , //    APO as Planning System
    ekpo.ccomp   , //    Posting Logic in the Case of Stock Transfers
    ekpo.grant_nbr   , //    Grant
    ekpo.fkber   , //    Functional Area
    ekpo.status  , //    Status of Purchasing Document Item
    ekpo.reslo   , //    Issuing Storage Location for Stock Transport Order
    ekpo.kblnr   , //    Document Number for Earmarked Funds
    ekpo.kblpos  , //    Earmarked Funds: Document Item
    ekpo.ps_psp_pnr  , //    Work Breakdown Structure Element (WBS Element)
    ekpo.kostl   , //    Cost Center
    ekpo.sakto   , //    G/L Account Number
    ekpo.weora   , //    Acceptance At Origin
    ekpo.srv_bas_com , //    Service-Based Commitment
    ekpo.prio_urg    , //    Requirement Urgency
    ekpo.prio_req    , //    Requirement Priority
    ekpo.empst   , //    Receiving Point
    ekpo.diff_invoice    , //    Differential Invoicing
    ekpo.trmrisk_relevant    , //    Risk Relevancy in Purchasing
    ekpo.creationdate    , //    Purchasing Document Creation Date
    ekpo.creationtime    , //    Purchasing Document Creation Time
    ekpo.vcm_chain_category  , //    Value Chain Category
    ekpo.spe_abgru   , //    Reason for rejection of quotations and sales orders
    ekpo.spe_crm_so  , //    CRM Sales Order Number for TPOP Process
    ekpo.spe_crm_so_item , //    CRM Sales Order Item Number in TPOP Process
    ekpo.spe_crm_ref_so  , //    CRM Reference Order Number for TPOP Process
    ekpo.spe_crm_ref_item    , //    CRM Reference Sales Order Item Number in TPOP Process
    ekpo.spe_crm_fkrel   , //    Billing Relevance CRM
    ekpo.spe_chng_sys    , //    Last Changer's System Type
    ekpo.spe_insmk_src   , //    Stock Type of Source Storage Location in STO
    ekpo.spe_cq_ctrltype , //    CQ Control Type
    ekpo.spe_cq_nocq , //    No Transmission of Cumulative Quantities in SA Release
    ekpo.reason_code , //    Goods Receipt Reason Code
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.cqu_sar , //    Cumulative Goods Receipts from Redirected Purchase Orders
    ekpo.anzsn   , //    Number of serial numbers
    ekpo.spe_ewm_dtc , //    EWM Delivery Based Tolerance Check
    ekpo.exlin   , //    Hierarchy Number
    ekpo.exsnr   , //    External Sort Number
    ekpo.ehtyp   , //    External Hierarchy Category
    ekpo.retpc   , //    Retention in Percent
    ekpo.dptyp   , //    Down Payment Indicator
    ekpo.dppct   , //    Down Payment Percentage
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.dpamt   , //    Down Payment Amount in Document Currency
    ekpo.dpdat   , //    Due Date for Down Payment
    ekpo.fls_rsto    , //    Store Return with Inbound and Outbound Delivery
    ekpo.ext_rfx_number  , //    Document Number of External Document
    ekpo.ext_rfx_item    , //    Item Number of External Document
    ekpo.ext_rfx_system  , //    Logical System
    ekpo.srm_contract_id , //    Central Contract
    ekpo.srm_contract_itm    , //    Central Contract Item Number
    ekpo.blk_reason_id   , //    Blocking Reason - ID
    ekpo.blk_reason_txt  , //    Blocking Reason - Text
    ekpo.itcons  , //    Real-Time Consumption Posting of Subcontracting Components
    ekpo.fixmg   , //    Delivery Date and Quantity Fixed
    ekpo.wabwe   , //    Indicator for GI-based goods receipt
    ekpo.cmpl_dlv_itm    , //    Complete Delivery Requested for Purchase Order Item
    ekpo.inco2_l , //    Incoterms Location 1
    ekpo.inco3_l , //    Incoterms Location 2
    ekpo.inco2_key   , //    Incoterm Location 1 - Place of Destination
    ekpo.inco3_key   , //    Incoterm Location 2 - Place of Delivery
    ekpo.inco4_key   , //    Incoterm - Deviating Place of Destination
    ekpo.stawn   , //    Commodity Code
    ekpo.isvco   , //    Intrastat Service Code
    ekko.grwcu,
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'GRWCU'}}
    ekpo.grwrt   , //    Statistical value for foreign trade
    ekpo.serviceperformer    , //    Service Performer
    ekpo.producttype , //    Product Type Group
    ekpo.gr_by_ses   , //    Are GRs posted by using Service Entry Sheet
    ekpo.requestforquotation , //    Identifier for Request for Quotation
    ekpo.requestforquotationitem , //    Item Number for Request for Quotation
    ekpo.status_pcs  , //    Product Compliance Supplier Check Status (Item)
    ekpo.status_pma  , //    Product Marketability Status (Item)
    ekpo.status_dg   , //    Dangerous Goods Status (Item)
    ekpo.status_sds  , //    Safety Data Sheet Status (Item)
    ekpo.extmaterialforpurg  , //    Material of External System
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.target_value    , //    Target Value at Item Level in Procurement Hub
    ekpo.externalreferenceid , //    External Reference ID
    ekpo.tc_aut_det  , //    Tax Code Automatically Determined
    ekpo.manual_tc_reason    , //    Manual Tax Code Reason
    ekpo.fiscal_incentive    , //    Tax Incentive Type
    ekpo.tax_subject_st  , //    Tax Subject to Substituição Tributária
    ekpo.fiscal_incentive_id , //    Incentive ID
    ekpo.sf_txjcd    , //    Jurisdiction Code of the Point of Origin
    ekpo.dummy_ekpo_incl_eew_ps  , //    Data Element for Extensibility of Purchasing Document Item
    ekpo.zz1_delay_conf_pdi  , //    Delay reason code for Confirmation
    ekpo.zz1_mm_exfactorydt_pdi  , //    Ex-Factory Date
    ekpo.zz1_prior_ind_pdi   , //    Inbound Priority Indicator
    ekpo.zz1_lprod_da_pdi    , //    LPD (Last production date)
    ekpo.zz1_abgru_pdi   , //    Rejection Reason
    ekpo.zz1_form_pdi    , //    HTS Form Type
    ekpo.zz1_adi_req_avail_pdi   , //    Requested  Availability Date
    //ekpo.zz1_tradco_prec_item_pdi    , //    Preceding Market PO Item
    ekpo.zz1_hts_code_pdi    , //    HTS Codes
    ekpo.zz1_grp_id_pdi  , //    Group ID
    ekpo.zz1_duty_rate_pdi   , //    Custom Duty Rate
    ekpo.zz1_ori_eligibility_pdi , //    Origin Eligibility
    ekpo.zz1_zfsh_mg_at_1_pdi , //    Material Division as in SO
    ekpo.zz1_idd_da_pdi  , //    IDD - Intended Delivery Date
    ekpo.zz1_hts_eligibility_pdi , //    HTS Eligibility
    ekpo.zz1_custin_pdi  , //    Customization Indicator
    ekpo.zz1_fprod_da_pdi    , //    FPD (First production date)
    ekpo.zz1_ordprio_pdi , //    Order Priority Indicator
    ekpo.zz1_pref_rate_pdi   , //    Preferential Duty Rate
    ekpo.zz1_fexfct_da_pdi   , //    First Confirmed ex-factory date
    ekpo.zz1_adi_m_leadtimeplan_pdi  , //    Manufacturing Lead time
    ekpo.zz1_mm_siden_pdi    , //    Shipment Aggregator
    ekpo.zz1_packpln_da_pdi  , //    Pack plan date (Expected)
    ekpo.zz1_delay_pln_conf_pdi  , //    Delay reason code for Plnd PO confirm.
    ekpo.zz1_hts_scope_pdi   , //    In-scope Indicator
    ekpo.zz1_hts_curr_pdi    , //    Currency Key
    ekpo.zz1_adi_m_planned_pdi   , //    Planned Date
    ekpo.zz1_mm_vascutoffdate_pdi    , //    VAS Cut-Off Date
    ekpo.zz1_custom_stat_pdi , //    Customization status
    //ekpo.zz1_tradco_prec_no_pdi  , //    Preceding Market PO No
    ekpo.zz1_rerout_ind_pdi  , //    Rerouting indicator
    ekpo.zz1_postat_pdi  , //    Status
    ekpo.zz1_lexfct_da_pdi   , //    Last confirmed ex factory date
    ekpo.zz1_mm_scmsegment_pdi   , //    SC Segmentation
    ekpo.zz1_adi_m_promoflag_pdi , //    Promo Price Factor
    ekpo.zz1_load_typ_pdi    , //    Load type
    ekpo.zz1_mdd_da_pdi  , //    Market Delivery Date
    ekpo.zz1_delay_pln_wip_pdi   , //    Delay reason code for Plnd PO DlvDate
    ekpo.zz1_delay_po_pdi    , //    Delay reason code for PO Delivery Date
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.expected_value  , //    Expected Value of Overall Limit
    @DefaultAggregation:#SUM
    @Semantics:{amount:{currencyCode:'WAERS'}}
    ekpo.limit_amount    , //    Overall Limit
    ekpo.contract_for_limit  , //    Purchase Contract for Enhanced Limit
    ekpo.enh_date1   , //    Start date of WKA working period
    ekpo.enh_date2   , //    End date of WKA working period
    ekpo.enh_percent , //    WKA: Percentage of wages
    ekpo.enh_numc1   , //    Working time in hours
    ekpo._dataaging  , //    Data Filter Value for Data Aging
    ekpo.cupit   , //    CUP Italy Codice Unico di Progetto - Unique Project Code
    ekpo.cigit   , //    CIG Italy : Competition Identification Number
    ekpo.txs_business_transaction    , //    Tax Service Business Transaction
    ekpo.txs_material_usage  , //    Tax Service Material Usage
    ekpo.txs_usage_purpose   , //    Tax Service Usage Purpose
    ekpo./bev1/negen_item    , //    Indicator: Item Is Generated
    ekpo./bev1/nedepfree , //    Indicator: Dependent Items Are Free of Charge
    ekpo./bev1/nestruccat    , //    Structure Category for Material Relationship
    ekpo.advcode , //    Advice Code
    ekpo.budget_pd   , //    Budget Period
    ekpo.excpe   , //    Acceptance Period
    ekpo.fmfgus_key  , //    United States Federal Government Fields
    ekpo.iuid_relevant   , //    IUID-Relevant
    ekpo.mrpind  , //    Max. Retail Price Relevant
    ekpo.sgt_scat    , //    Stock Segment
    ekpo.sgt_rcat    , //    Requirement Segment
    ekpo.tms_ref_uuid    , //    Reference UUID of Transportation Management
    ekpo.tms_src_loc_key , //    Location GUID (004) with Conversion Exit
    ekpo.tms_des_loc_key , //    Location GUID (004) with Conversion Exit
    ekpo.wrf_charstc1    , //    Characteristic Value 1
    ekpo.wrf_charstc2    , //    Characteristic Value 2
    ekpo.wrf_charstc3    , //    Characteristic Value 3
    ekpo.refsite , //    Reference Site For Purchasing
    ekpo./dmbe/optionalitykey    , //    Detail Number
    ekpo./dmbe/optionalityfor    , //    Optionality For
    ekpo./dmbe/cimax2    , //    Maximum Carbon Intensity Value
    ekpo./dmbe/item_type , //    Item Type
    ekpo./dmbe/effectivedatefrom , //    Effective From
    ekpo./dmbe/effectivedateto   , //    Effective To
    ekpo./dmbe/optionof  , //    Option of MM Item
    ekpo./dmbe/accounting_type   , //    Detail Accounting Type
    ekpo./dmbe/fas_code  , //    Financial Accounting Standards Code
    ekpo./dmbe/scheduling_desk   , //    Scheduling Desk
    ekpo./dmbe/componentfor  , //    Mixed Product Main Detail Number
    ekpo./dmbe/mixedproduct  , //    Product
    ekpo./dmbe/posteddate    , //    Posted Date of a Deal
    ekpo./dmbe/deal_posted   , //    Deal is Posted
    ekpo./dmbe/invoiceuom    , //    Invoice Unit of Measure
    ekpo.zapcgk  , //    Annexing package key
    ekpo.apcgk_extend    , //    Extended key for annexing package
    ekpo.zbas_date   , //    Base Date
    ekpo.zadattyp    , //    Annexing Date Type
    ekpo.zstart_dat  , //    Annexing start date
    ekpo.z_dev   , //    deviation percentage
    ekpo.zindanx , //    indicator for annexed order type
    ekpo.zlimit_dat  , //    Annexing limit date (purchasing)
    ekpo.numerator   , //    IL Annexing Numerator
    ekpo.hashcal_bdat    , //    The general acountant method New base date.
    ekpo.hashcal , //    Accountant general method
    ekpo.negative    , //    Do not allow negative annexing
    ekpo.hashcal_exists  , //    Purchasing organization
    ekpo.known_index , //    Known Index indicator in /ILE/T_ANNEXING_CALCULATION Func
    ekpo./sapmp/gpose    , //    Global Item Number in Purchasing Document
    ekpo.angpn   , //    Quotation Item Number (SD)
    ekpo.admoi   , //    Model ID Code
    ekpo.adpri   , //    Order Priority
    ekpo.lprio   , //    Delivery Priority
    ekpo.adacn   , //    Aircraft registration number
    ekpo.afpnr   , //    Sales Document Item
    ekpo.bsark   , //    Vendor confirmation type
    ekpo.audat   , //    Document Date (Date Received/Sent)
    ekpo.angnr   , //    Quotation number
    ekpo.pnstat  , //    Flag for  the S1PNSTAT message
    ekpo.addns   , //    Do Not Substitute
    ekpo.assignment_priority , //    ARun Demand Priority
    ekpo.arun_group_prio , //    ARun Demand Group Priority
    ekpo.arun_order_prio , //    ARun Order Priority
    ekpo.serru   , //    Type of subcontracting
    ekpo.sernp   , //    Serial Number Profile
    ekpo.disub_sobkz , //    Special stock indicator Subcontracting
    ekpo.disub_pspnr , //    Work Breakdown Structure Element (WBS Element)
    ekpo.disub_kunnr , //    Customer Number
    ekpo.disub_vbeln , //    Sales and Distribution Document Number
    ekpo.disub_posnr , //    Item number of the SD document
    ekpo.disub_owner , //    Owner of stock
    ekpo.fsh_season_year , //    Season Year
    ekpo.fsh_season  , //    Season
    ekpo.fsh_collection  , //    Fashion Collection
    ekpo.fsh_theme   , //    Fashion Theme
    ekpo.fsh_atp_date    , //    Starting Date with ATP
    ekpo.fsh_vas_rel , //    VAS Relevant
    ekpo.fsh_vas_prnt_id , //    Item Number of Purchasing Document
    ekpo.fsh_transaction , //    Transaction Number
    ekpo.fsh_item_group  , //    Item Group
    ekpo.fsh_item    , //    Item Number
    ekpo.fsh_ss  , //    Order Scheduling Strategy
    ekpo.fsh_grid_cond_rec   , //    Grid Condition Record Number
    ekpo.fsh_psm_pfm_split   , //    PSM and PFM Split ID
    @DefaultAggregation: #SUM
    @Semantics: { quantity : {unitOfMeasure: 'MEINS'} }
    ekpo.cnfm_qty    , //    Committed Quantity
    ekpo.fsh_pqr_uepos   , //    Higher-level item in Partial Quantity Rejection
    ekpo.rfm_diversion   , //    Status of Diversion process
    ekpo.rfm_scc_indicator   , //    Season Completeness Indicator
    ekpo.stpac   , //    Activate Static Stopping of Releases
    ekpo.lgbzo   , //    (Automotive) Unloading Point
    ekpo.lgbzo_b , //    (Automotive) Unloading Point
    ekpo.addrnum , //    Address Number
    ekpo.consnum , //    Sequence Number
    ekpo.borgr_miss  , //    Indicator: Action at Registration
    ekpo.dep_id  , //    Department
    ekpo.belnr   , //    Document Number for Earmarked Funds
    ekpo.kblpos_cab  , //    Earmarked Funds: Document Item
    ekpo.kblnr_comp  , //    Commitment document
    ekpo.kblpos_comp , //    Commitment item
    ekpo.wbs_element , //    Work Breakdown Structure Element (WBS Element)
    ekpo.rfm_psst_rule   , //    PSST Grouping Rule
    ekpo.rfm_psst_group  , //    PSST Group
    ekpo.rfm_ref_doc , //    Reference Document number for PO Traceability
    ekpo.rfm_ref_item    , //    Reference Item number for PO Traceability
    ekpo.rfm_ref_action  , //    Action for Traceability in  PO
    ekpo.rfm_ref_slitem  , //    Reference Schedule Line Item number for PO Traceability
    ekpo.ref_item    , //    Reference Item for Remaining Qty Cancellation
    ekpo.source_id   , //    Origin Profile
    ekpo.source_key  , //    Key in Source System
    ekpo.put_back    , //    Indicator for Putting Back from Grouped PO Document
    ekpo.pol_id  , //    Order List Item Number
    ekpo.cons_order  //    Purchase Order for Consignment
            
    }       
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    
