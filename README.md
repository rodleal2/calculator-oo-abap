#  Mini Calculadora ABAP OO

##  Descrição

Este projeto implementa uma **mini calculadora em ABAP Orientado a Objetos**, utilizando boas práticas de encapsulamento, tratamento de exceções e registro de logs em tabela customizada.

O report `ZR_CALCULATOR` permite executar operações matemáticas básicas entre dois valores e registra apenas operações bem-sucedidas na tabela de log.

---

##  Funcionalidades

- ✔️ Soma  
- ✔️ Subtração  
- ✔️ Multiplicação  
- ✔️ Divisão  
- ✔️ Tratamento de divisão por zero  
- ✔️ Tratamento de operação inválida  
- ✔️ Mensagens customizadas via SE91  
- ✔️ Registro automático em tabela `ZTCALC_LOG`  

---

##  Arquitetura

###  Classe `ZCL_MATH_CALCULATOR`
Responsável por:
- Executar as operações matemáticas
- Centralizar a lógica de cálculo
- Tratar exceções
- Retornar mensagens de sucesso

###  Report `ZR_CALCULATOR`
Responsável por:
- Receber parâmetros do usuário
- Chamar a classe de cálculo
- Exibir mensagens
- Registrar logs em tabela

---

##  Demonstração

### 1️ Tela inicial do report

<img width="1910" height="1071" alt="Tela do Report" src="https://github.com/user-attachments/assets/5da14578-9c45-43bd-98eb-d8ebb96581c4" />

---

### 2️ Resultado após execução com mensagem de sucesso

<img width="1911" height="1072" alt="Resultado" src="https://github.com/user-attachments/assets/4a50d35a-ada6-4d4e-8708-5e4b676e2290" />

---

### 3️ Tabela `ZTCALC_LOG` (SE16N) com registros gravados

<img width="1915" height="1075" alt="Tabela Log" src="https://github.com/user-attachments/assets/6ddff8a9-3979-4271-a1a8-5fa38c465069" />

---

##  Tratamento de Exceções

O sistema trata:

- `CX_SY_ZERODIVIDE` → divisão por zero  
- `CX_SY_NO_HANDLER` → operação inválida  

Em ambos os casos:
- Exibe mensagem de erro (005)
- Não grava registro na tabela

---

##  Controle de Logs

- Apenas operações bem-sucedidas são registradas
- ID gerado via `SELECT MAX(ID) + 1`
- Registro contém:
  - Valor 1
  - Operação
  - Valor 2
  - Resultado
  - Data e hora

---

##  Objetivo do Projeto

Projeto desenvolvido para prática de:

- ABAP OO  
- Tratamento de exceções  
- Boas práticas de organização de código  
- Estruturação de projetos para portfólio GitHub  
