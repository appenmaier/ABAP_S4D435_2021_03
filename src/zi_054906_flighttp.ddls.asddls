@AbapCatalog.sqlViewName: 'ZI054906FLIGHTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Flight'
@VDM.viewType: #TRANSACTIONAL
@ObjectModel:{
//    compositionRoot: true,
//    transactionalProcessingEnabled: true,
    writeActivePersistence: 'SFLIGHT',

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true,

//    modelCategory: #BUSINESS_OBJECT,
    representativeKey: ['carrid', 'connid', 'fldate'],
    semanticKey: ['carrid', 'connid', 'fldate']
}
define view ZI_054906_FlightTP
  as select from ZI_054906_Flight
  association [1] to ZI_054906_ConnectionTP as _Connection on  $projection.carrid = _Connection.CarrierId
                                                           and $projection.connid = _Connection.ConnectionId
{

  key carrid,
  key connid,
  key fldate,
      price,
      currency,
      planetype,
      seatsmax,
      seatsocc,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Connection
}
