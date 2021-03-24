@AbapCatalog.sqlViewName: 'ZI054906TRAVELTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Flight Travel Transactional View'

@VDM.viewType: #TRANSACTIONAL

@ObjectModel:{
    compositionRoot: true,
    transactionalProcessingEnabled: true,
    writeActivePersistence: 'ZV054906_TRAVEL2',

    updateEnabled: true,

    modelCategory: #BUSINESS_OBJECT,
    representativeKey: 'TravelNumber',
    semanticKey: ['TravelAgency', 'TravelNumber']
}
define view ZI_054906_TravelTP
  as select from ZI_054906_Travel
  association [1] to ZC_054906_CustomerVH   as _Customer    on  $projection.Customer = _Customer.id
  association [*] to ZI_054906_TravelItemTP as _TravelItems on  $projection.TravelAgency = _TravelItems.agencynum
                                                            and $projection.TravelNumber = _TravelItems.travelid
{
      @ObjectModel.readOnly: true
  key TravelAgency,
      @ObjectModel.readOnly: true
  key TravelNumber,
      TravelDescription,
      @ObjectModel.mandatory: true
      @ObjectModel.foreignKey.association: '_Customer'
      Customer,
      @ObjectModel.mandatory: true
      StartDate,
      @ObjectModel.mandatory: true
      EndDate,
      @ObjectModel.readOnly: true
      Status,
      @Semantics.systemDateTime.lastChangedAt: true
      ChangedAt,
      @Semantics.user.lastChangedBy: true
      ChangedBy,
      _Customer,
      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _TravelItems
}
