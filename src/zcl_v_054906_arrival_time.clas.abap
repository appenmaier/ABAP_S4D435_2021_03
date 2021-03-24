CLASS zcl_v_054906_arrival_time DEFINITION
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



CLASS zcl_v_054906_arrival_time IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.

    DATA connections TYPE zti054906_connectiontp2.

    io_read->retrieve(
      EXPORTING
        iv_node        = is_ctx-node_key
        it_key         = it_key
      IMPORTING
        eo_message     = eo_message
        et_data        = connections
        et_failed_key  = et_failed_key ).

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    LOOP AT connections REFERENCE INTO DATA(connection).
      IF connection->arrivaltime <= connection->departuretime.
        DATA origin_location TYPE /bobf/s_frw_location.
        origin_location-bo_key = is_ctx-bo_key.
        origin_location-node_key = is_ctx-node_key.
        origin_location-key = connection->key.

        DATA(message) = NEW zcm_054906_connection(
            textid              = zcm_054906_connection=>invalid_arrival_time
            severity            = zcm_054906_connection=>co_severity_error
            ms_origin_location  = origin_location ).

        eo_message->add_cm( message ).

        et_failed_key = VALUE #( BASE et_failed_key ( key = connection->key ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
