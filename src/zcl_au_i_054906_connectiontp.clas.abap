CLASS zcl_au_i_054906_connectiontp DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_auth_draft_active
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_lib_auth_draft_active~check_instance_authority
        REDEFINITION .
    METHODS /bobf/if_lib_auth_draft_active~check_static_authority
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_au_i_054906_connectiontp IMPLEMENTATION.


  METHOD /bobf/if_lib_auth_draft_active~check_instance_authority.

    DATA activity TYPE activ_auth.

    IF is_ctx-activity = /bobf/cl_frw_authority_check=>sc_activity-change OR
     is_ctx-activity = /bobf/cl_frw_authority_check=>sc_activity-execute AND
     is_ctx-action_name = 'SET_FLIGHTTYPE_TO_X'.
      activity = '02'.
    ELSEIF is_ctx-activity = /bobf/cl_frw_authority_check=>sc_activity-create.
      activity = '01'.
    ENDIF.

    IF activity IS NOT INITIAL.

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

        AUTHORITY-CHECK OBJECT 'S_CARRID'
            ID 'CARRID' FIELD connection->carrierid
            ID 'ACTVT' FIELD activity.
        IF sy-subrc <> 0.
          DATA origin_location TYPE /bobf/s_frw_location.
          origin_location-bo_key = is_ctx-bo_key.
          origin_location-node_key = is_ctx-node_key.
          origin_location-key = connection->key.

          DATA(message) = NEW zcm_054906_connection(
            textid             = zcm_054906_connection=>no_auth
            severity           = zcm_054906_connection=>co_severity_error
            ms_origin_location = origin_location
            i_carrier_id       = connection->carrierid
            i_connection_id    = connection->connectionid ).

          eo_message->add_cm( message ).
          et_failed_key = VALUE #( BASE et_failed_key ( key = connection->key ) ).
        ENDIF.

      ENDLOOP.

    ENDIF.

  ENDMETHOD.


  METHOD /bobf/if_lib_auth_draft_active~check_static_authority.
  ENDMETHOD.

ENDCLASS.
