@AbapCatalog.sqlViewName: 'ZI054906CARRIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Carrier'
@ObjectModel:{
    writeActivePersistence: 'SCARR'
}
define view ZI_054906_CarrierTP
  as select from scarr
  association [*] to ZI_054906_ConnectionTP as _Connections on $projection.carrid = _Connections.CarrierId
{
  key carrid,
      carrname,
      currcode,
      url,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Connections
}
