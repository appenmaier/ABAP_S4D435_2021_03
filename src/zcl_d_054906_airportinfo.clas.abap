CLASS zcl_d_054906_airportinfo DEFINITION
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



CLASS zcl_d_054906_airportinfo IMPLEMENTATION.

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

    LOOP AT connections REFERENCE INTO DATA(connection).

      SELECT SINGLE FROM scitairp
       FIELDS *
       WHERE airport = @connection->departureairport
       INTO @DATA(departure_airport).

      connection->departurecity = departure_airport-mastercity.
      connection->departurecountry = departure_airport-country.

      DATA changed_fields TYPE /bobf/t_frw_name.

      changed_fields = VALUE #(
        ( zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-departurecountry )
        ( zif_i_054906_connectiontp_c=>sc_node_attribute-zi_054906_connectiontp-departurecity ) ).

      io_modify->update(
        EXPORTING
          iv_node = is_ctx-node_key
          iv_key  = connection->key
          is_data = connection
          it_changed_fields = changed_fields ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
