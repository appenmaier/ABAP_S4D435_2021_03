@AbapCatalog.sqlViewName: 'ZC054906AIRPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help: Airport'
define view ZC_054906_AirportVH
  as select from sairport
{
  key id        as AirportId,
      name      as AirportName,
      time_zone as AirportTimeZone
}
