CLASS z2ui5_cl_demo_app_116 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES z2ui5_if_app.
    INTERFACES if_oo_adt_intrnl_classrun.

    DATA mv_classname TYPE string.
    DATA mv_output    TYPE string.
    DATA mv_time      TYPE string.
    DATA mv_check_init TYPE abap_bool.

    METHODS display_demo_output
      IMPORTING
        client TYPE REF TO z2ui5_if_client.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS z2ui5_cl_demo_app_116 IMPLEMENTATION.


  METHOD z2ui5_if_app~main.

    IF mv_check_init = abap_false.
      mv_check_init = abap_true.
      mv_classname = `Z2UI5_CL_DEMO_APP_117`.
      display_demo_output( client ).
    ENDIF.

    CASE client->get( )-event.

      WHEN 'BUTTON_POST'.
        DATA li_classrun TYPE REF TO if_oo_adt_classrun.
        CREATE OBJECT li_classrun TYPE (mv_classname).
        li_classrun->main( out = me ).
        mv_output = cl_demo_output=>get( ).
        client->view_model_update( ).
*        display_demo_output( client ).

      WHEN 'BACK'.
        client->nav_app_leave( client->get_app( client->get( )-s_draft-id_prev_app_stack  ) ).

    ENDCASE.

  ENDMETHOD.



  METHOD display_demo_output.

    DATA(view) = z2ui5_cl_xml_view=>factory( client ).
    client->view_display( view->shell(
          )->page(
                  title          = 'abap2UI5 - if_oo_adt_classrun'
                  navbuttonpress = client->_event( val = 'BACK' check_view_destroy = abap_true )
                  shownavbutton  = abap_true
              )->header_content(
                  )->link(
                      text = 'Source_Code'
                      href = view->hlp_get_source_code_url(  )
                      target = '_blank'
                 )->get_parent(
              )->sub_header(
                 )->overflow_toolbar(
                        )->label( 'Classname'


                        )->input( value = client->_bind_edit( mv_classname ) width = `20%`
                        )->button(
                            text  = 'Run'
                            press = client->_event( val = 'BUTTON_POST' )
                        )->toolbar_spacer(
                        )->input( value = client->_bind_edit( mv_time ) width = `5%`
                        )->button(
                            text  = 'Timer Run'
                            press = client->_event( val = 'BUTTON_POST' )
                        )->toolbar_spacer(
                        )->button(
                            text  = 'Clear'
                            press = client->_event( val = 'BUTTON_CLEAR' )
              )->get_parent( )->get_parent(
*                 )->simple_form( title = 'Console Output Starter' editable = abap_true
*                    )->content( 'form'
*

*            )->get_parent( )->get_parent(
            )->_cc( )->gui_demo_output( )->control( client->_bind( mv_output )
            )->stringify( ) ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~begin_section.

    cl_demo_output=>begin_section( ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~display.


  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~end_section.

    cl_demo_output=>end_section( ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~get.

    cl_demo_output=>get( ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~line.

    cl_demo_output=>line(  ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~next_section.

    cl_demo_output=>next_section( title ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~write.

    cl_demo_output=>write_data( data ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~write_data.

    cl_demo_output=>write_data( value ).

  ENDMETHOD.

  METHOD if_oo_adt_intrnl_classrun~write_text.

    cl_demo_output=>write_text( text ).

  ENDMETHOD.

ENDCLASS.
