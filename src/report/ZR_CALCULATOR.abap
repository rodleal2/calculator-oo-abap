*&---------------------------------------------------------------------*
*& Report ZR_CALCULATOR
*&---------------------------------------------------------------------*
*& Mini calculadora ABAP OO com tratamento de exceções e mensagens
*&---------------------------------------------------------------------*
REPORT zr_calculator.

"--------------------------------------------------------------
" Parâmetros de seleção do usuário
"--------------------------------------------------------------
PARAMETERS:
  p_value1 TYPE zdevalue OBLIGATORY,       " Primeiro valor para cálculo
  p_op     TYPE op_properties OBLIGATORY,  " Operação desejada (+, -, *, /)
  p_value2 TYPE zdevalue OBLIGATORY.       " Segundo valor para cálculo

"--------------------------------------------------------------
" Variáveis locais
"--------------------------------------------------------------
DATA:
  lv_result TYPE zdevalue,  " Resultado do cálculo
  lv_msgno  TYPE symsgno.   " Número da mensagem de sucesso

"--------------------------------------------------------------
" Bloco principal
"--------------------------------------------------------------
START-OF-SELECTION.

  "--------------------------------------------------------------
  " Criação do objeto da classe de cálculo
  "--------------------------------------------------------------
  DATA(lo_calc) = NEW zcl_math_calculator( ).
  DATA: ls_log TYPE ztcalc_log,   " Estrutura para log
        lv_id  TYPE numc10.       " Próximo ID único para log

  "--------------------------------------------------------------
  " Executa o cálculo dentro de um bloco TRY para tratar exceções
  "--------------------------------------------------------------
  TRY.
      " Chama o método calculate da classe
      lv_result = lo_calc->calculate(
        iv_value1    = p_value1
        iv_value2    = p_value2
        iv_operation = p_op
      ).

      " Obtém o número da mensagem de sucesso (001 a 004)
      lv_msgno = lo_calc->get_success_message(
                         iv_operation = p_op ).

      " Exibe mensagem informativa ao usuário com o resultado
      MESSAGE ID 'ZCALC'
              TYPE 'I'
              NUMBER lv_msgno
              WITH lv_result.

  "--------------------------------------------------------------
  " Tratamento de exceções
  "--------------------------------------------------------------
  CATCH cx_sy_zerodivide cx_sy_no_handler.
      " Divisão por zero ou operação inválida → mensagem de erro 005
      MESSAGE ID 'ZCALC'
              TYPE 'E'
              NUMBER '005'.

  ENDTRY.

"--------------------------------------------------------------
" Gravação do log apenas se o cálculo foi bem-sucedido
"--------------------------------------------------------------
IF sy-subrc = 0.
    " Determina o próximo ID único na tabela de log
    SELECT MAX( id ) INTO lv_id FROM ztcalc_log.
    lv_id = lv_id + 1.

    " Preenche a estrutura de log
    ls_log-mandt         = sy-mandt.
    ls_log-id            = lv_id.
    ls_log-value1        = p_value1.
    ls_log-operation     = p_op.
    ls_log-value2        = p_value2.
    ls_log-zresult       = lv_result.
    ls_log-created_date  = sy-datum.
    ls_log-created_time  = sy-uzeit.

    " Insere o registro de log na tabela
    INSERT ztcalc_log FROM ls_log.
ENDIF.
