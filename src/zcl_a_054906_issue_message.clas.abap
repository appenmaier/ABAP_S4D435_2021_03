CLASS zcl_a_054906_issue_message DEFINITION
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



CLASS zcl_a_054906_issue_message IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.

    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    DATA(message) = NEW zcm_054906_test_message(
      textid    = zcm_054906_test_message=>test_message
      severity  = zcm_054906_test_message=>co_severity_info ).

    eo_message->add_cm( message ).

    ev_static_action_failed = abap_false.

  ENDMETHOD.
ENDCLASS.
