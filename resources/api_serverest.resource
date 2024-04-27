*** Settings ***
Library     SeleniumLibrary
Library     String
Library     RequestsLibrary
Library     Collections



*Keywords*
Criar sessão
  ${headers}   Create Dictionary    accept=application/json     Content-Type=application/json
  Create Session    alias=APIServerRest    url=https://serverest.dev/   headers=${headers}

 Criar um novo usuario
  ${palavra_randomica}   Generate Random String   length=8  chars=[LETTERS]
  ${palavra_randomica}   Convert To Lower Case    ${palavra_randomica}
  Set Test Variable     ${EMAIL_TEST}             ${palavra_randomica}@qacoders.com.br
  Log                   ${EMAIL_TEST}

Cadastrar o novo usuario criado
  ${body}  Create Dictionary  nome=Fulano da Silva  email=${EMAIL_TEST}   password=teste     administrador=true 
  Log   ${body}
  Criar sessão
  ${resposta}    POST On Session   alias=APIServerRest   url=/usuarios  json=${body}
  Log   ${resposta.json()}
  Set Test Variable  ${ID_USUARIO}  ${resposta.json()["_id"]}
  Set Test Variable  ${RESPOSTA}    ${resposta.json()}    


    

Conferir se o novo usuário foi cadastrado corretamente
  Log   ${RESPOSTA}
  Dictionary Should Contain Item   ${RESPOSTA}  message   Cadastro realizado com sucesso


Consultar os dados do usuário 
  ${resposta_consulta}   GET On Session  alias=APIServerRest   url=/usuarios/${ID_USUARIO}  
  Set Test Variable    ${RESPOSTA_CONSULTA}         ${resposta_consulta.json()}

Conferir os dados retornados de novo usuário
  Log   ${RESPOSTA_CONSULTA}
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    nome             Fulano da Silva 
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    email            ${EMAIL_TEST} 
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    password         teste 
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    administrador    true
  Dictionary Should Contain Item    ${RESPOSTA_CONSULTA}    _id              ${ID_USUARIO} 

Alterar perfil de acesso 
  ${alterar_perfil_usuario}   PUT ON Session    alias=APIServerRest   url=/usuarios/${ID_USUARIO}
...                expected_status=200  data={"nome":"Fulano da Silva", "email":"${EMAIL_TEST}","password":"teste","administrador":"true"}


Excluir usuário criado
  ${excluir_usuario}  DELETE ON Session  alias=APIServerRest   url=/usuarios/${ID_USUARIO}
  Set Test Variable   ${RESPOSTA_CONSULTA_APOS_EXCLUSAO}   ${excluir_usuario}
  
Conferir se o usuário foi excluido corretamente
  Log   ${RESPOSTA_CONSULTA_APOS_EXCLUSAO} 
  