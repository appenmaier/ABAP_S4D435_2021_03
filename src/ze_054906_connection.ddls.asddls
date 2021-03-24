@AbapCatalog.sqlViewAppendName: 'ZE054906CONN'
@EndUserText.label: 'Extension View: Connection'
extend view ZI_054906_ConnectionTP with ZE_054906_Connection
  association [1] to ZI_054906_CarrierTP as _Carrier on ZI_054906_Connection.carrierid = _Carrier.carrid
{
  _Carrier.carrid,
  @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
  _Carrier
}
