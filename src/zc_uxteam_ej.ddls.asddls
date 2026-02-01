@AccessControl.authorizationCheck: #NOT_REQUIRED

@EndUserText.label: 'UXTeam Consumption View'

@Metadata.allowExtensions: true

@Search.searchable: true

define root view entity ZC_UXTEAM_EJ

// TODO: check the itens bellow
//provider contract transactional_query
//provider contract transactional_interface
  as projection on zi_uxteam_ej as UXTeam

{
      @EndUserText.label: 'Id'
  key Id,

//      @EndUserText.label: 'First Name'
      @Search.defaultSearchElement: true
      Firstname,

      @EndUserText.label: 'Last Name'
      @Search.defaultSearchElement: true
      Lastname,

      @EndUserText.label: 'Age'
      Age,

      @EndUserText.label: 'Role'
      @Search.defaultSearchElement: true
//      @Consumption.valueHelpDefinition: [{ qualifier: 'ValueHelp2',
//                                       entity : { name    : 'I_BusinessPartner',                 
//                                                  element : 'BusinessPartnerID'
//                                                },
//                                       label  : 'Business Partner Value Help'
//                                     },
//                                     { entity : { name    : 'I_BuPa',                 
//                                                  element : 'BusinessPartnerID'
//                                                },
//                                       label  : 'Business Partner VH'
//                                     }]  
      Role,

      @EndUserText.label: 'Salary'
      Salary,

      @EndUserText.label: 'Active'
      Active,

      LastChangedAt,
      LocalLastChangedAt
}
