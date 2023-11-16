CLASS Z2UI5_CL_DEMO_APP_078 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES Z2UI5_if_app.

    TYPES:
      BEGIN OF ty_s_token,
        key      TYPE string,
        text     TYPE string,
        visible  TYPE abap_bool,
        selkz    TYPE abap_bool,
        editable TYPE abap_bool,
      END OF ty_S_token.

    DATA mv_value          TYPE string.
    DATA mt_token          TYPE STANDARD TABLE OF ty_S_token WITH EMPTY KEY.
    DATA check_initialized TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS Z2UI5_CL_DEMO_APP_078 IMPLEMENTATION.


  METHOD Z2UI5_if_app~main.

    IF check_initialized = abap_false.
      check_initialized = abap_true.

      DATA(view) = Z2UI5_cl_xml_view=>factory( client ).

      view = view->shell( )->page( id = `page_main`
               title          = 'abap2UI5 - Select-Options'
               navbuttonpress = client->_event( 'BACK' )
               shownavbutton  = abap_true
           )->header_content(
               )->link(
                   text = 'Source_Code' target = '_blank' href = z2ui5_cl_demo_utility=>factory( client )->app_get_url_source_code( )
          )->get_parent( ).


      view->multi_input( tokens           = client->_bind_edit( mt_token )
                                showclearicon    = abap_true
                                value            = client->_bind_edit( mv_value )
                                submit           = client->_event( 'SUBMIT' )
                                tokenupdate      = client->_event( 'SUBMIT' )
                                valueHelpRequest = client->_event( 'FILTER_VALUE_HELP' )
                       )->item( key  = `{KEY}`
                                text = `{TEXT}`
                       )->tokens(
                           )->token( key      = `{KEY}`
                                     text     = `{TEXT}`
                                     visible  = `{VISIBLE}`
                                     selected = `{SELKZ}`
                                     editable = `{EDITABLE}` ).

      client->view_display( view->stringify( ) ).

    ENDIF.


    CASE client->get( )-event.

      WHEN 'SUBMIT'.
        INSERT VALUE #( key = mv_value text = mv_value visible = abap_true editable = abap_true ) INTO TABLE mt_token.
        CLEAR mv_value.
        client->view_model_update( ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack ) ).

    ENDCASE.

  ENDMETHOD.
ENDCLASS.
