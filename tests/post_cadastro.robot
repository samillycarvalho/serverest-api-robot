*** Settings ***
resource    ../resources/api_serverest.resource
Resource    ../resources/api_serverest.resource

*** Test Cases ***
CT01 - cadastro de usuário
   Criar sessão
   Criar um novo usuario
   Cadastrar o novo usuario criado
   Conferir se o novo usuário foi cadastrado corretamente 