@AbapCatalog.sqlViewName: 'ZC054906TRITEMTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View: Travel Item'
@ObjectModel:{
    createEnabled: true,
    updateEnabled: true,
    deleteEnabled: true
}
define view ZC_054906_TravelItemTP
  as select from ZI_054906_TravelItemTP
  association [1] to ZC_054906_TravelTP as _Travel on  $projection.agencynum = _Travel.TravelAgency
                                                   and $projection.travelid  = _Travel.TravelNumber
{
      @UI.lineItem: [{ position: 10 }]
      @UI.identification: [{ position: 10 }]
  key agencynum,
      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key travelid,
      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
  key tritemno,
      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      carrid,
      @UI.lineItem: [{ position: 50 }]
      @UI.identification: [{ position: 50 }]
      connid,
      @UI.lineItem: [{ position: 60 }]
      @UI.identification: [{ position: 60 }]
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
