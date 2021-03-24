@AbapCatalog.sqlViewName: 'ZI054906CONNTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Connection'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel:{
    compositionRoot: true,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZV054906_CONN',

    createEnabled: true,
    updateEnabled: 'EXTERNAL_CALCULATION',
    deleteEnabled: true,

    modelCategory: #BUSINESS_OBJECT,
    representativeKey: ['CarrierId', 'ConnectionId'],
    semanticKey: ['CarrierId', 'ConnectionId']
}
define view ZI_054906_ConnectionTP
  as select from ZI_054906_Connection
  association [*] to ZI_054906_FlightTP as _Flights on  $projection.CarrierId    = _Flights.carrid
                                                    and $projection.ConnectionId = _Flights.connid
{
      @ObjectModel.mandatory: true
  key CarrierId,
      @ObjectModel.mandatory: true
  key ConnectionId,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      DepartureCountry,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      DepartureCity,
      @ObjectModel.mandatory: true
      DepartureAirport,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      ArrivalCountry,
      @ObjectModel.readOnly: 'EXTERNAL_CALCULATION'
      ArrivalCity,
      @ObjectModel.mandatory: true
      ArrivalAirport,
      DepartureTime,
      ArrivalTime,
      Distance,
      DistanceUnit,
      FlightType,
      Period,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _Flights
}
