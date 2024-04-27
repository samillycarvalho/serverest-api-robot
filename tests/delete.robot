*** Settings ***
resource    ../resources/api_serverest.resource
Resource    ../resources/api_serverest.resource

*** Test Cases ***
CT01 - deletar o usuário
   Criar um novo usuario
   Cadastrar o novo usuario criado
   Excluir usuário criado
   Conferir se o usuário foi excluido corretamente