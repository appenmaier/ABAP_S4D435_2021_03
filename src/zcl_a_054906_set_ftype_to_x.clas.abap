CLASS zcl_a_054906_set_ftype_to_x DEFINITION
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



CLASS zcl_a_054906_set_ftype_to_x IMPLEMENTATION.

  METHOD /bobf/if_frw_action~execute.

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

      IF connection->flighttype = 'X'.
        DATA origin_location TYPE /bobf/s_frw_location.
        origin_location-bo_key = is_ctx-bo_key.
        origin_location-node_key = is_ctx-node_key.
        origin_location-key = connection->key.

        DATA(message) = NEW zcm_054906_connection(
            textid             = zcm_054906_connection=>flighttype_failed
            severity           = zcm_054906_connection=>co_severity_error
            ms_origin_location = origin_location
            i_carrier_id       = connection->carrierid
            i_connection_id    = connection->connectionid ).

        eo_message->add_cm( message ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = connection->key ) ).
        CONTINUE.
      ENDIF.

      connection->flighttype = 'X'.
      io_modify->update(
        EXPORTING
          iv_node = is_ctx-node_key
          iv_key  = connection->key
          is_data = connection ).

      message = NEW zcm_054906_connection(
            textid             = zcm_054906_connection=>flighttype_success
            severity           = zcm_054906_connection=>co_severity_success
            ms_origin_location = origin_location
            i_carrier_id       = connection->carrierid
            i_connection_id    = connection->connectionid ).

      eo_message->add_cm( message ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
