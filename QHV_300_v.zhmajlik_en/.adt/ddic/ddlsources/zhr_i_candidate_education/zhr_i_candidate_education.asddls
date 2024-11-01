@AbapCatalog.sqlViewName: 'ZHRICANDIDATEEDU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Person Header Master Data'

@VDM: {
    viewType: #TRANSACTIONAL
}

@ObjectModel:{
    modelCategory : #BUSINESS_OBJECT,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZHR_PB0022',
    semanticKey: ['uuid'],
    representativeKey: 'uuid',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,
   writeDraftPersistence: 'ZHR_PB0022D'
}
define view ZHR_I_CANDIDATE_EDUCATION
  as select from zhr_pb0022
  association [1..1] to ZHR_I_CANDIDATEHEADER as _CandidateHeader on $projection.uuid_candidate = _CandidateHeader.uuid
{
  key       uuid,
            uuid_candidate,
            pernr     as Pernr,
            subty     as Subty,
            objps     as Objps,
            sprps     as Sprps,
            endda     as Endda,
            begda     as Begda,
            seqnr     as Seqnr,
            aedtm     as Aedtm,
            uname     as Uname,
            histo     as Histo,
            itxex     as Itxex,
            refex     as Refex,
            ordex     as Ordex,
            itbld     as Itbld,
            preas     as Preas,
            flag1     as Flag1,
            flag2     as Flag2,
            flag3     as Flag3,
            flag4     as Flag4,
            rese1     as Rese1,
            rese2     as Rese2,
            grpvl     as Grpvl,
            slart     as Slart,
            insti     as Insti,
            sland     as Sland,
            ausbi     as Ausbi,
            slabs     as Slabs,
            anzkl     as Anzkl,
            anzeh     as Anzeh,
            sltp1     as Sltp1,
            sltp2     as Sltp2,
            jbez1     as Jbez1,
            waers     as Waers,
            slpln     as Slpln,
            slktr     as Slktr,
            slrzg     as Slrzg,
            ksbez     as Ksbez,
            tx122     as Tx122,
            schcd     as Schcd,
            faccd     as Faccd,
            dptmt     as Dptmt,
            emark     as Emark,
            ftext     as ftext,
            qualiname as qualiname,
           

            @ObjectModel.association: {
            type: [ #TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT ]}
            _CandidateHeader

} 
 