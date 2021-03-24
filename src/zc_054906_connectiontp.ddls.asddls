@AbapCatalog.sqlViewName: 'ZC054906CONNTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Connection'
@VDM.viewType: #CONSUMPTION
@OData.publish: true
@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel:{
    transactionalProcessingDelegated: true,

    createEnabled: true,
    updateEnabled: 'EXTERNAL_CALCULATION',
    deleteEnabled: true
}
define view ZC_054906_ConnectionTP
  as select from ZI_054906_ConnectionTP
  association [1] to ZC_054906_AirportVH as _DepartureAirport on  $projection.DepartureAirport = _DepartureAirport.AirportId
  association [1] to ZC_054906_AirportVH as _ArrivalAirport   on  $projection.ArrivalAirport = _ArrivalAirport.AirportId
  association [*] to ZC_054906_FlightTP  as _Flights          on  $projection.CarrierId    = _Flights.carrid
                                                              and $projection.ConnectionId = _Flights.connid
{
  key CarrierId,
  key ConnectionId,
      DepartureCountry,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      DepartureCity,
      @Consumption.valueHelp: '_DepartureAirport'
      @ObjectModel.text.element: ['DepartureAirportName']
      DepartureAirport,
      ArrivalCountry,
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.7
      ArrivalCity,
      @Consumption.valueHelp: '_ArrivalAirport'
      @ObjectModel.text.element: ['ArrivalAirportName']
      ArrivalAirport,
      DepartureTime,
      ArrivalTime,
      Distance,
      DistanceUnit,
      FlightType,
      Period,
      _DepartureAirport,
      _ArrivalAirport,
      @ObjectModel.readOnly: true
      _DepartureAirport.AirportName as DepartureAirportName,
      @ObjectModel.readOnly: true
      _ArrivalAirport.AirportName   as ArrivalAirportName,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Flights

}
