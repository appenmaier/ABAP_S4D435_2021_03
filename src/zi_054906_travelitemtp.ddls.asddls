@AbapCatalog.sqlViewName: 'ZI054906TRITEMTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Transactional View: Travel Item'
@ObjectModel:{
    writeActivePersistence: 'Z054906_TRITEM',
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZI_054906_TravelItemTP
  as select from ZI_054906_TravelItem
  association [1] to ZI_054906_TravelTP as _Travel on  $projection.agencynum = _Travel.TravelAgency
                                                   and $projection.travelid  = _Travel.TravelNumber
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
      changedby,
      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT, #TO_COMPOSITION_ROOT]
      _Travel
}
