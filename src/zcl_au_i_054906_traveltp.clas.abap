CLASS zcl_au_i_054906_traveltp DEFINITION
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



CLASS zcl_au_i_054906_traveltp IMPLEMENTATION.


  METHOD /bobf/if_lib_auth_draft_active~check_instance_authority.

*    DATA activity TYPE activ_auth.
*
*    IF is_ctx-activity = /bobf/cl_frw_authority_check=>sc_activity-change OR
*       is_ctx-activity = /bobf/cl_frw_authority_check=>sc_activity-create.
*      activity = is_ctx-activity.
*    ELSEIF is_ctx-activity = /bobf/cl_frw_authority_check=>sc_activity-execute AND is_ctx-action_name = 'SET_TO_CANCELLED'.
*      activity = /bobf/cl_frw_authority_check=>sc_activity-change.
*    ENDIF.
*
*    IF activity IS NOT INITIAL.
*
*      DATA travels TYPE zti054906_traveltp.
*
*      io_read->retrieve(
*        EXPORTING
*          iv_node        = is_ctx-node_key
*          it_key         = it_key
*        IMPORTING
*          eo_message     = eo_message
*          et_data        = travels
*          et_failed_key  = et_failed_key ).
*
*      IF eo_message IS NOT BOUND.
*        eo_message = /bobf/cl_frw_factory=>get_message( ).
*      ENDIF.
*
*      LOOP AT travels REFERENCE INTO DATA(travel).
*
*        AUTHORITY-CHECK OBJECT 'S_AGENCY'
*            ID 'AGENCYNUM' FIELD travel->travelagency
*            ID 'ACTVT' FIELD activity.
*        IF sy-subrc <> 0.
*          DATA origin_location TYPE /bobf/s_frw_location.
*          origin_location-bo_key = is_ctx-bo_key.
*          origin_location-node_key = is_ctx-node_key.
*          origin_location-key = travel->key.
*
*          DATA(message) = NEW zcm_054906_connection(
*              textid              = zcm_054906_connection=>no_auth
*              severity            = zcm_054906_connection=>co_severity_error
*              ms_origin_location  = origin_location ).
*
*          eo_message->add_cm( message ).
*
*          et_failed_key = VALUE #( BASE et_failed_key ( key = travel->key ) ).
*        ENDIF.
*
*      ENDLOOP.
*
*    ENDIF.

  ENDMETHOD.


  METHOD /bobf/if_lib_auth_draft_active~check_static_authority.
  ENDMETHOD.
ENDCLASS.
