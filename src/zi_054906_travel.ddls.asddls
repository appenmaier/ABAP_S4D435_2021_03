@AbapCatalog.sqlViewName: 'ZI054906TRAVEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Interface View'

@VDM.viewType: #BASIC

define view ZI_054906_Travel
  as select from z054906_travel
{
  key agencynum as TravelAgency,
  key travelid  as TravelNumber,
      trdesc    as TravelDescription,
      customid  as Customer,
      stdat     as StartDate,
      enddat    as EndDate,
      status    as Status,
      changedat as ChangedAt,
      changedby as ChangedBy
}
