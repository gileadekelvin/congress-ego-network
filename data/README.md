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
Source: https://dadosabertos.camara.leg.br/api/v2/proposicoes?dataInicio=2017-01-01&dataFim=2018-12-31&ordem=ASC&ordenarPor=id&pagina=1&itens=100

**Columns**
- **page**: API page returned by Chamber of Deputies site,
- **id_proposition**: unique id of proposition in the API.
- **initials_type**: initials of the type of proposition. Type is a variable that describe the nature of the proposition.
- **cod_type**: Code of the type of proposition. Type is a variable that describe the nature of the proposition.
- **number**: number of proposition. (can be combined with type code and year to get a proposition's title)
- **year**: year of proposition
- **summary**: Brief description of the main points of the proposition. Provided by the Chamber.

### **authors_propositions_2017_2018**

Authors of the proposals that passed through the Chamber of Deputies between 2017 and 2018.
Source: https://dadosabertos.camara.leg.br/api/v2/proposicoes/<id_proposition>/autores

**Columns**
- **id_proposition**: Unique id of proposition
- **id_deputy**: Unique id of deputy (can be NA returned by API)    
- **name**: Name of deputy
- **cod_type**: Type of author
- **type**: Name of the type of the author

### **revenue_candidates_deputy_2018.csv**

List of candidates for federal deputy in 2018 and how much they received from the party.

**Columns**
- **cpf_candidate**: cpf of the candidate
- **name**: name of the candidate
- **post**: Only "Deputado Federal" (federal deputy)
- **party**: party of the candidate
- **uf**: uf of the candidate
- **received_from_party**: total of money received from the party in 2018.

### **mandates.csv**

List of all deputies that participated in at least one legislature considering all legislatures provided by the API of the Chamber of Deputies. This data can be used to determinate the mandates of the deputies.

**Columns**
- **page**: API page returned by Chamber of Deputies site
- **id_deputy**: Unique id of the deputy
- **idLegislature**: Legislature's id that the deputy participated
- **name**: name of the candidate
- **party**: party of the candidate
- **uf**: uf of the candidate

### **patrimony_candidates_deputy_2018.csv**

List of candidates for federal deputy in 2018 and how much they declared as patrimony.

**Columns**
- **year**: year of declaration of patrimony
- **uf**: uf of the candidate
- **cpf**: cpf of the candidate
- **name**: name of the candidate
- **ocupation**: ocupation of the candidate
- **education**: degree of education
- **patrimony**: patrimony declared in REAIS (R$)
