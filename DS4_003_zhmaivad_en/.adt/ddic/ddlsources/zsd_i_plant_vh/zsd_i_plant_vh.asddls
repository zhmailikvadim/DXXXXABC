/************************************************************************
*  R E V I S I O N   H I S T O R Y                                     *
************************************************************************
* AUTHOR       | DATE       | CHANGE NUMBER & DESCRIPTION              *
*              |            | TRANSPORT REQUESTS                       *
************************************************************************
* KHRYSAND     | 20.09.2022 | 13764     : BE: Case Lot - Sales order List Report A *
*              |            | DS4K930674                               *
*----------------------------------------------------------------------*/
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help for Plant'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity zsd_i_plant_vh
  as select from t001w
{
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      @ObjectModel.text.element: ['PlantName']  
  key werks as Plant,
      @Search: { defaultSearchElement : true,
                 fuzzinessThreshold   : 0.8  }
      name1 as PlantName

}
