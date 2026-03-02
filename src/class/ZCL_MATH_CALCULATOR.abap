CLASS zcl_math_calculator DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    CONSTANTS gc_sum TYPE op_properties VALUE '+' ##NO_TEXT.
    CONSTANTS gc_sub TYPE op_properties VALUE '-' ##NO_TEXT.
    CONSTANTS gc_mul TYPE op_properties VALUE '*' ##NO_TEXT.
    CONSTANTS gc_div TYPE op_properties VALUE '/' ##NO_TEXT.

    METHODS calculate
      IMPORTING
        !iv_value1    TYPE zdevalue
        !iv_value2    TYPE zdevalue
        !iv_operation TYPE op_properties
      RETURNING
        VALUE(iv_result) TYPE zdevalue
      RAISING
        cx_sy_zerodivide.

    METHODS get_success_message
      IMPORTING
        !iv_operation TYPE op_properties
      RETURNING
        VALUE(rv_msgno) TYPE symsgno.

  PRIVATE SECTION.

    METHODS sum
      IMPORTING
        !iv_value1 TYPE zdevalue
        !iv_value2 TYPE zdevalue
      RETURNING
        VALUE(iv_result) TYPE zdevalue.

    METHODS subtract
      IMPORTING
        !iv_value1 TYPE zdevalue
        !iv_value2 TYPE zdevalue
      RETURNING
        VALUE(iv_result) TYPE zdevalue.

    METHODS multiplication
      IMPORTING
        !iv_value1 TYPE zdevalue
        !iv_value2 TYPE zdevalue
      RETURNING
        VALUE(iv_result) TYPE zdevalue.

    METHODS division
      IMPORTING
        !iv_value1 TYPE zdevalue
        !iv_value2 TYPE zdevalue
      RETURNING
        VALUE(iv_result) TYPE zdevalue
      RAISING
        cx_sy_zerodivide.

ENDCLASS.



CLASS ZCL_MATH_CALCULATOR IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MATH_CALCULATOR->CALCULATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALUE1                      TYPE        ZDEVALUE
* | [--->] IV_VALUE2                      TYPE        ZDEVALUE
* | [--->] IV_OPERATION                   TYPE        OP_PROPERTIES
* | [<-()] IV_RESULT                      TYPE        ZDEVALUE
* | [!CX!] CX_SY_ZERODIVIDE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD calculate.
    CASE iv_operation.
      WHEN gc_sum.
        iv_result = me->sum(
          iv_value1 = iv_value1
          iv_value2 = iv_value2 ).

      WHEN gc_sub.
        iv_result = me->subtract(
          iv_value1 = iv_value1
          iv_value2 = iv_value2 ).

      WHEN gc_div.
        iv_result = me->division(
          iv_value1 = iv_value1
          iv_value2 = iv_value2 ).

      WHEN gc_mul.
        iv_result = me->multiplication(
          iv_value1 = iv_value1
          iv_value2 = iv_value2 ).

      WHEN OTHERS.
        RAISE EXCEPTION TYPE cx_sy_no_handler.
    ENDCASE.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_MATH_CALCULATOR->DIVISION
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALUE1                      TYPE        ZDEVALUE
* | [--->] IV_VALUE2                      TYPE        ZDEVALUE
* | [<-()] IV_RESULT                      TYPE        ZDEVALUE
* | [!CX!] CX_SY_ZERODIVIDE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD division.
    IF iv_value2 = 0.
      RAISE EXCEPTION TYPE cx_sy_zerodivide.
    ELSE.
      iv_result = iv_value1 / iv_value2.
    ENDIF.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_MATH_CALCULATOR->GET_SUCCESS_MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_OPERATION                   TYPE        OP_PROPERTIES
* | [<-()] RV_MSGNO                       TYPE        SYMSGNO
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD get_success_message.
    CASE iv_operation.
      WHEN gc_sum.
        rv_msgno = '001'.
      WHEN gc_sub.
        rv_msgno = '002'.
      WHEN gc_mul.
        rv_msgno = '003'.
      WHEN gc_div.
        rv_msgno = '004'.
      WHEN OTHERS.
        rv_msgno = '005'.
    ENDCASE.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_MATH_CALCULATOR->MULTIPLICATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALUE1                      TYPE        ZDEVALUE
* | [--->] IV_VALUE2                      TYPE        ZDEVALUE
* | [<-()] IV_RESULT                      TYPE        ZDEVALUE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD multiplication.
    iv_result = iv_value1 * iv_value2.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_MATH_CALCULATOR->SUBTRACT
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALUE1                      TYPE        ZDEVALUE
* | [--->] IV_VALUE2                      TYPE        ZDEVALUE
* | [<-()] IV_RESULT                      TYPE        ZDEVALUE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD subtract.
    iv_result = iv_value1 - iv_value2.
  ENDMETHOD.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_MATH_CALCULATOR->SUM
* +-------------------------------------------------------------------------------------------------+
* | [--->] IV_VALUE1                      TYPE        ZDEVALUE
* | [--->] IV_VALUE2                      TYPE        ZDEVALUE
* | [<-()] IV_RESULT                      TYPE        ZDEVALUE
* +--------------------------------------------------------------------------------------</SIGNATURE>
  METHOD sum.
    iv_result = iv_value1 + iv_value2.
  ENDMETHOD.
ENDCLASS.
