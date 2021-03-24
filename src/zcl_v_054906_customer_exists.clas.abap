CLASS zcl_v_054906_customer_exists DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_validation~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_v_054906_customer_exists IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

    DATA travels TYPE zti054906_traveltp.

    io_read->retrieve(
      EXPORTING
        iv_node        = is_ctx-node_key
        it_key         = it_key
      IMPORTING
        eo_message     = eo_message
        et_data        = travels
        et_failed_key  = et_failed_key ).

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    LOOP AT travels REFERENCE INTO DATA(travel).
      SELECT SINGLE FROM scustom
       FIELDS *
       WHERE id = @travel->customer
       INTO @DATA(dummy).
      IF sy-subrc <> 0.
        DATA origin_location TYPE /bobf/s_frw_location.
        origin_location-bo_key = is_ctx-bo_key.
        origin_location-node_key = is_ctx-node_key.
        origin_location-key = travel->key.

        DATA(message) = NEW zcm_054906_travel(
            textid              = zcm_054906_travel=>customer_not_exist
            severity            = zcm_054906_travel=>co_severity_error
            ms_origin_location  = origin_location
            i_customer          = travel->customer ).

        eo_message->add_cm( message ).

        et_failed_key = VALUE #( BASE et_failed_key ( key = travel->key ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
