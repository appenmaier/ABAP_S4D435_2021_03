@AbapCatalog.sqlViewName: 'ZC054906CUSTVH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Value Help: Customer'
define view ZC_054906_CustomerVH
  as select from scustom
{
      @ObjectModel.text.element: ['name']
  key id,
      name,
      form,
      street,
      postbox,
      postcode,
      city,
      country,
      region,
      telephone,
      custtype,
      discount,
      langu,
      email,
      webuser
}
