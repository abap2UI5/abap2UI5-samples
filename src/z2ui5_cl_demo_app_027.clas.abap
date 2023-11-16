CLASS Z2UI5_CL_DEMO_APP_027 DEFINITION PUBLIC.

  PUBLIC SECTION.

    INTERFACES Z2UI5_if_app.

    DATA product  TYPE string.
    DATA quantity TYPE i.
    DATA input2 TYPE string.
    DATA input31 TYPE i.
    DATA input32 TYPE i.
    DATA input41 TYPE string.
    DATA input51 TYPE string.
    DATA input52 TYPE string.

  PROTECTED SECTION.

    data client            TYPE REF TO Z2UI5_if_client.
    DATA:
      BEGIN OF app,
        check_initialized TYPE abap_bool,
        view_main         TYPE string,
        view_popup        TYPE string,
        s_get             TYPE Z2UI5_if_client=>ty_s_get,
      END OF app.

    METHODS Z2UI5_on_init.
    METHODS Z2UI5_on_event.
    METHODS Z2UI5_on_render.

  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_027 IMPLEMENTATION.


  METHOD Z2UI5_if_app~main.

    me->client     = client.
    app-s_get      = client->get( ).
    app-view_popup = ``.

    IF app-check_initialized = abap_false.
      app-check_initialized = abap_true.
      Z2UI5_on_init( ).
    ENDIF.

    IF app-s_get-event IS NOT INITIAL.
      Z2UI5_on_event( ).
    ENDIF.

    Z2UI5_on_render( ).

    CLEAR app-s_get.

  ENDMETHOD.


  METHOD Z2UI5_on_event.

    CASE app-s_get-event.

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( app-s_get-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.


  METHOD Z2UI5_on_init.

    product  = 'tomato'.
    quantity = '500'.
    app-view_main = 'VIEW_MAIN'.
    input41 = 'faasdfdfsaVIp'.

  ENDMETHOD.


  METHOD Z2UI5_on_render.

    data(view) = Z2UI5_CL_XML_VIEW=>factory( client ).
    data(lv_xml) = view->shell(
      )->page(
              title          = 'abap2UI5 - Binding Syntax'
              navbuttonpress = client->_event( 'BACK' )
              shownavbutton  = abap_true
          )->header_content(
              )->link( text = `Demo` target = `_blank` href = `https://twitter.com/abap2UI5/status/1647889242545111043`
              )->link(
                  text = 'Source_Code' target = '_blank'
                  href = z2ui5_cl_demo_utility=>factory( client )->app_get_url( )
          )->get_parent(
          )->simple_form( title = 'Binding Syntax' editable = abap_true
              )->content( 'form'
                )->title( 'Expression Binding'

                )->label( 'Documentation'
                )->link(
                  text = 'Expression Binding'
                  href = 'https://sapui5.hana.ondemand.com/sdk/#/topic/daf6852a04b44d118963968a1239d2c0'
                )->label( 'input in uppercase'
                )->input( client->_bind( input2 )
                )->input(
                    value   = '{= $' &&  client->_bind( input2 ) && '.toUpperCase() }'
                    enabled = abap_false


                )->label( 'max value of the first two inputs'
                )->input( '{ type : "sap.ui.model.type.Integer",' &&
                          '  path:"' &&  client->_bind( val = input31 path = abap_true ) && '" }'
                )->input( '{ type : "sap.ui.model.type.Integer",' && |\n|  &&
                          '  path:"' &&  client->_bind( val = input32 path = abap_true ) && '" }'
                )->input(
                    value   = '{= Math.max($' && client->_bind( input31 ) &&', $' &&  client->_bind( input32 ) &&  ') }'
                    enabled = abap_false


                )->label( 'only enabled when the quantity equals 500'
                )->input( '{ type : "sap.ui.model.type.Integer",' &&
                          '  path:"' && client->_bind( val = quantity path = abap_true ) && `"  }`
                )->input(
                    value   = product
                    enabled = '{= 500===$' && client->_bind( quantity ) && ' }'

                )->label( 'RegExp Set to enabled if the input contains VIP, ignoring the case.'
                )->input( client->_bind( val = input41 )
                )->button(
                    text   = 'VIP'
                    enabled = '{= RegExp(''vip'', ''i'').test($' && client->_bind( input41 ) && ') }'


                )->label( 'concatenate both inputs'
                )->input( client->_bind( val = input51 )
                )->input( client->_bind( val = input52 )
                )->input(
                    value   = '{ parts: [' && |\n|  &&
                              '                "' &&  client->_bind( val = input51 path = abap_true ) && '",' && |\n|  &&
                              '                "' &&  client->_bind( val = input52 path = abap_true ) && '"' && |\n|  &&
                              '               ]  }'
                    enabled = abap_false

       )->get_root( )->xml_get( ).


       client->view_display( lv_xml ).

  ENDMETHOD.
ENDCLASS.
