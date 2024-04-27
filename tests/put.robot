*** Settings ***
resource    ../resources/api_serverest.resource
Resource    ../resources/api_serverest.resource

*** Test Cases ***
CT01 - atualizar o usuário
   Criar um novo usuario
   Cadastrar o novo usuario criado
   Consultar os dados do usuário 
   Alterar perfil de acesso 
   Consultar os dados do usuário 