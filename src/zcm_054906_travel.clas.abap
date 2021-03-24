CLASS zcm_054906_travel DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cm_frw
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF cancel_success,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '120',
        attr1 TYPE scx_attrname VALUE 'TRAVEL_NUMBER',
        attr2 TYPE scx_attrname VALUE 'START_DATE',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF cancel_success .

    CONSTANTS:
      BEGIN OF already_cancelled,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '130',
        attr1 TYPE scx_attrname VALUE 'TRAVEL_NUMBER',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF already_cancelled .

    CONSTANTS:
      BEGIN OF customer_not_exist,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '200',
        attr1 TYPE scx_attrname VALUE 'CUSTOMER',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF customer_not_exist .

    CONSTANTS:
      BEGIN OF dates_wrong_sequence,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '210',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF dates_wrong_sequence .

    CONSTANTS:
      BEGIN OF end_date_past,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '220',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF end_date_past .

    CONSTANTS:
      BEGIN OF start_date_past,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '230',
        attr1 TYPE scx_attrname VALUE '',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF start_date_past .

    CONSTANTS:
      BEGIN OF class_invalid,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '300',
        attr1 TYPE scx_attrname VALUE 'FLIGHT_CLASS',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF class_invalid .

    CONSTANTS:
      BEGIN OF flight_date_past,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '310',
        attr1 TYPE scx_attrname VALUE ' ',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF flight_date_past .

    CONSTANTS:
      BEGIN OF flight_not_exist,
        msgid TYPE symsgid VALUE 'DEVS4D435',
        msgno TYPE symsgno VALUE '320',
        attr1 TYPE scx_attrname VALUE 'AIRLINE_ID',
        attr2 TYPE scx_attrname VALUE 'CONNECTION_NUMBER',
        attr3 TYPE scx_attrname VALUE 'FLIGHT_DATE',
        attr4 TYPE scx_attrname VALUE '',
      END OF flight_not_exist .

    DATA travel_number TYPE s_travelid READ-ONLY .
    DATA start_date TYPE char10 READ-ONLY .
    DATA customer TYPE s_customer READ-ONLY .
    DATA flight_class TYPE s_class READ-ONLY .
    DATA airline_id TYPE s_carr_id READ-ONLY .
    DATA connection_number TYPE s_conn_id READ-ONLY .
    DATA flight_date TYPE char10 READ-ONLY .

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
        !i_travel_number         TYPE s_travelid OPTIONAL
        !i_start_date            TYPE s_stdat OPTIONAL
        !i_customer              TYPE s_customer OPTIONAL
        !i_flight_class          TYPE s_class OPTIONAL
        !i_airline_id            TYPE s_carr_id OPTIONAL
        !i_connection_number     TYPE s_conn_id OPTIONAL
        !i_flight_date           TYPE s_date OPTIONAL .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcm_054906_travel IMPLEMENTATION.

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
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.

    me->travel_number = i_travel_number.
    me->start_date = i_start_date.
    me->customer = i_customer.
    me->flight_class = i_flight_class.
    me->airline_id = i_airline_id.
    me->connection_number = i_connection_number.
    me->flight_date = i_flight_date.

  ENDMETHOD.

ENDCLASS.
