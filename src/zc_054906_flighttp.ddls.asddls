@AbapCatalog.sqlViewName: 'ZC054906FLIGHTTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Flight'
@VDM.viewType: #CONSUMPTION
@ObjectModel:{
//    transactionalProcessingDelegated: true,

    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZC_054906_FlightTP
  as select from ZI_054906_FlightTP
  association [1] to ZC_054906_ConnectionTP as _Connection on  $projection.carrid = _Connection.CarrierId
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
