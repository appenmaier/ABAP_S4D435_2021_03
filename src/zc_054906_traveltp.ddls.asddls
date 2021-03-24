@AbapCatalog.sqlViewName: 'ZC054906TRAVELTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Consumption View'

@VDM.viewType: #CONSUMPTION
@OData.publish: true

@Search.searchable: true

@Metadata.allowExtensions: true
@ObjectModel:{
    transactionalProcessingDelegated: true,
    semanticKey: ['TravelAgency', 'TravelNumber'],

    updateEnabled: true

}
define view ZC_054906_TravelTP
  as select from ZI_054906_TravelTP
  association [*] to ZC_054906_TravelItemTP as _TravelItems on  $projection.TravelAgency = _TravelItems.agencynum
                                                            and $projection.TravelNumber = _TravelItems.travelid
{
  key TravelAgency,
  key TravelNumber,

      @Search: { defaultSearchElement: true,
                 fuzzinessThreshold: 0.8
               }

      TravelDescription,
      Customer,
      StartDate,
      EndDate,
      Status,
      ChangedAt,
      ChangedBy,
      _Customer,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _TravelItems
}
