## Data

This is a brief description of the data processed and made available by this repository.

### **deputies_leg55.csv**

Descriptive data per Member for all Members who participated in the House of Representatives' 55th legislature. House of Representatives in Brazil is called Chamber of Deputies (Câmara dos Deputados)
Source: https://dadosabertos.camara.leg.br/api/v2/deputados?idLegislatura=55

**Columns**

- **id**: unique id of deputy
- **house**: house of deputy. Only the value "camara" is possible.
- **cpf**: cpf of deputy.
- **civilian_name**: full name of deputy
- **electoral_name**: electoral name of deputy
- **state** state of deputy election 
- **party_name**: party of deputy (initials)
- **condition**: current status of the Member's term of office. Examples: Exercício (means that he is in the mandate)
- **gender**: gender of deputy. M or F. Only values provided by the API of Chamber.
- **schooling**: degree of education of the deputy
- **email**: email of deputy.

### **propositions_2017_2018.csv**

List of basic information on draft laws, resolutions, provisional measures, amendments, opinions and all other types of proposals in the Chamber of Deputies. All of these proposals were presented or had some change of situation in the period between January 1, 2017 and December 31, 2018.

**Columns**
- **page**: API page returned by Chamber of Deputies site,
- **id_proposition**: unique id of proposition in the API.
- **initials_type**: initials of the type of proposition. Type is a variable that describe the nature of the proposition.
- **cod_type**: Code of the type of proposition. Type is a variable that describe the nature of the proposition.
- **number**: number of proposition. (can be combined with type code and year to get a proposition's title)
- **year**: year of proposition
- **summary**: Brief description of the main points of the proposition. Provided by the Chamber.

