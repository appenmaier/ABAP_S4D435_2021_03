CLASS zcm_054906_connection DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cm_frw
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF test_message,
        msgid TYPE symsgid VALUE 'Z054906_CONNECTION',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF test_message.

    CONSTANTS:
      BEGIN OF flighttype_success,
        msgid TYPE symsgid VALUE 'Z054906_CONNECTION',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'CARRID',
        attr2 TYPE scx_attrname VALUE 'CONNID',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF flighttype_success.

    CONSTANTS:
      BEGIN OF flighttype_failed,
        msgid TYPE symsgid VALUE 'Z054906_CONNECTION',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'CARRID',
        attr2 TYPE scx_attrname VALUE 'CONNID',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF flighttype_failed.

    CONSTANTS:
      BEGIN OF no_auth,
        msgid TYPE symsgid VALUE 'Z054906_CONNECTION',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'CARRID',
        attr2 TYPE scx_attrname VALUE 'CONNID',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF no_auth.

    CONSTANTS:
      BEGIN OF invalid_arrival_time,
        msgid TYPE symsgid VALUE 'Z054906_CONNECTION',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF invalid_arrival_time.

    METHODS constructor
      IMPORTING
        !textid                  LIKE if_t100_message=>t100key OPTIONAL
        !previous                LIKE previous OPTIONAL
        !severity                TYPE ty_message_severity OPTIONAL
        !symptom                 TYPE ty_message_symptom OPTIONAL
        !lifetime                TYPE ty_message_lifetime DEFAULT co_lifetime_transition
        !ms_origin_location      TYPE /bobf/s_frw_location OPTIONAL
        !mt_environment_location TYPE /bobf/t_frw_location OPTIONAL
        !mv_act_key              TYPE /bobf/act_key OPTIONAL
        !mv_assoc_key            TYPE /bobf/obm_assoc_key OPTIONAL
        !mv_bopf_location        TYPE /bobf/conf_key OPTIONAL
        !mv_det_key              TYPE /bobf/det_key OPTIONAL
        !mv_query_key            TYPE /bobf/obm_query_key OPTIONAL
        !mv_val_key              TYPE /bobf/val_key OPTIONAL
        !i_carrier_id            TYPE s_carr_id OPTIONAL
        !i_connection_id         TYPE s_conn_id OPTIONAL .

    DATA carrid TYPE s_carr_id.
    DATA connid TYPE s_conn_id.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcm_054906_connection IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous                = previous
        severity                = severity
        symptom                 = symptom
        lifetime                = lifetime
        ms_origin_location      = ms_origin_location
        mt_environment_location = mt_environment_location
        mv_act_key              = mv_act_key
        mv_assoc_key            = mv_assoc_key
        mv_bopf_location        = mv_bopf_location
        mv_det_key              = mv_det_key
        mv_query_key            = mv_query_key
        mv_val_key              = mv_val_key.
    CLEAR me->textid.

    carrid = i_carrier_id.
    connid = i_connection_id.

    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
