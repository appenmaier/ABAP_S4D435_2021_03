CLASS zcl_d_i_054906_connectiontp_ac DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_d_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_determination~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_d_i_054906_connectiontp_ac IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.

    DATA connections TYPE zti054906_connectiontp2.

    io_read->retrieve(
      EXPORTING
        iv_node        = is_ctx-node_key
        it_key         = it_key
      IMPORTING
        eo_message     = eo_message
        et_data        = connections
        et_failed_key  = et_failed_key ).

    DATA(property_helper) = NEW /bobf/cl_lib_h_set_property(
      is_context = is_ctx
      io_modify  = io_modify ).

    LOOP AT connections REFERENCE INTO DATA(connection).

      property_helper->set_node_update_enabled(
        EXPORTING
          iv_key   = connection->key
          iv_value = abap_false ).

      property_helper->set_attribute_read_only(
        EXPORTING
          iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-arrivalcity
          iv_key            = connection->key
          iv_value          = abap_false ).

      property_helper->set_attribute_read_only(
        EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-arrivalcountry
            iv_key            = connection->key
            iv_value          = abap_false ).

      property_helper->set_attribute_read_only(
        EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-departurecity
            iv_key            = connection->key
            iv_value          = abap_false ).

      property_helper->set_attribute_read_only(
        EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-departurecountry
            iv_key            = connection->key
            iv_value          = abap_false ).

      IF connection->arrivalairport = 'FRA'
      OR connection->departureairport = 'FRA'.
        property_helper->set_node_update_enabled(
         EXPORTING
            iv_key   = connection->key
            iv_value = abap_true ).

        property_helper->set_attribute_read_only(
          EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-arrivalcity
            iv_key            = connection->key
            iv_value          = abap_true ).

        property_helper->set_attribute_read_only(
          EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-arrivalcountry
            iv_key            = connection->key
            iv_value          = abap_true ).

        property_helper->set_attribute_read_only(
          EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-departurecity
            iv_key            = connection->key
            iv_value          = abap_true ).

        property_helper->set_attribute_read_only(
          EXPORTING
            iv_attribute_name = zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-departurecountry
            iv_key            = connection->key
            iv_value          = abap_true ).

        property_helper->set_action_enabled(
          EXPORTING
            iv_action_key = zif_i_054906_connectiontp_c=>sc_action-zi_054906_connectiontp-set_flighttype_to_x
            iv_key        = connection->key
            iv_value      = abap_false ).
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
