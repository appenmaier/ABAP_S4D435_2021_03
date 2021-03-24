@AbapCatalog.sqlViewName: 'ZI054906TRITEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Basic View: Travel Item'
define view ZI_054906_TravelItem
  as select from z054906_tritem
{
  key agencynum,
  key travelid,
  key tritemno,
      carrid,
      connid,
      fldate,
      bookid,
      class,
      passname,
      createdat,
      createdby,
      changedat,
      changedby
}
