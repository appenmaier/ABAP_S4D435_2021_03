@AbapCatalog.sqlViewName: 'ZI054906FLIGHT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View: Flight'
@VDM.viewType: #BASIC
define view ZI_054906_Flight as select from sflight
{
  key carrid,
  key connid,
  key fldate,
      price,
      currency,
      planetype,
      seatsmax,
      seatsocc
}
