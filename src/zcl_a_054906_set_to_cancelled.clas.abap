CLASS zcl_a_054906_set_to_cancelled DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_a_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_action~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_a_054906_set_to_cancelled IMPLEMENTATION.

  METHOD /bobf/if_frw_action~execute.

    DATA travels TYPE zti054906_traveltp.

    io_read->retrieve(
      EXPORTING
        iv_node                 = is_ctx-node_key
        it_key                  = it_key
      IMPORTING
        eo_message              = eo_message
        et_data                 = travels
        et_failed_key           = et_failed_key ).

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    LOOP AT travels REFERENCE INTO DATA(travel).

      IF travel->status = 'C'.
        DATA(message) = NEW zcm_054906_travel(
            textid          = zcm_054906_travel=>already_cancelled
            severity        = zcm_054906_travel=>co_severity_error
            i_travel_number = travel->travelnumber ).

        eo_message->add_cm( message ).

        et_failed_key = VALUE #( BASE et_failed_key ( key = travel->key ) ).
        CONTINUE.
      ENDIF.

      travel->status = 'C'.
      io_modify->update(
        EXPORTING
          iv_node           = is_ctx-node_key
          iv_key            = travel->key
          is_data           = travel ).
      message = NEW zcm_054906_travel(
        textid          = zcm_054906_travel=>cancel_success
        severity        = zcm_054906_travel=>co_severity_success
        i_travel_number = travel->travelnumber
        i_start_date    = travel->startdate ).

      eo_message->add_cm( message ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
