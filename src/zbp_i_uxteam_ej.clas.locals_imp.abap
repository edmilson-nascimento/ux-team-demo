CLASS lhc_zi_uxteam_ej DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zi_uxteam_ej RESULT result.

    METHODS setActive FOR MODIFY
      IMPORTING keys FOR ACTION zi_uxteam_ej~setActive RESULT result.

    METHODS changeSalary FOR DETERMINE ON SAVE
      IMPORTING keys FOR zi_uxteam_ej~changeSalary.

    METHODS validateAge FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_uxteam_ej~validateAge.

ENDCLASS.

CLASS lhc_zi_uxteam_ej IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD setActive.

    " Do background check
    " Check references
    " Onboard member

    MODIFY ENTITIES OF zi_uxteam_ej IN LOCAL MODE
           ENTITY UXTeam
           UPDATE
           FIELDS ( Active )
           WITH VALUE #( FOR key IN keys
                         ( %tky   = key-%tky
                           Active = abap_true ) )

           FAILED failed
           REPORTED reported.


    " Fill the response table
    READ ENTITIES OF zi_uxteam_ej IN LOCAL MODE
         ENTITY UXTeam
         ALL FIELDS WITH CORRESPONDING #( keys )
         RESULT DATA(members).

    result = VALUE #( FOR member IN members
                      ( %tky   = member-%tky
                        %param = member ) ).

  ENDMETHOD.

  METHOD changeSalary.

    " Read relevant UXTeam instance data
    READ ENTITIES OF zi_uxteam_ej IN LOCAL MODE
         ENTITY UXTeam
         FIELDS ( Role ) WITH CORRESPONDING #( keys )
         RESULT DATA(members).

    LOOP AT members INTO DATA(member).

      IF member-Role = 'UX Developer'.

        " Change salary to hard coded value
        MODIFY ENTITIES OF zi_uxteam_ej IN LOCAL MODE
               ENTITY UXTeam
               UPDATE
               FIELDS ( Salary )
               WITH VALUE #( ( %tky   = member-%tky
                               Salary = 7000 ) ).

      ENDIF.

      IF member-Role = 'UX Lead'.

        " Change salary to hard coded value
        MODIFY ENTITIES OF zi_uxteam_ej IN LOCAL MODE
               ENTITY UXTeam
               UPDATE
               FIELDS ( Salary )
               WITH VALUE #( ( %tky   = member-%tky
                               Salary = 9000 ) ).

      ENDIF.

      IF member-Role = 'ABAP'.

        " Change salary to hard coded value
        MODIFY ENTITIES OF zi_uxteam_ej IN LOCAL MODE
               ENTITY UXTeam
               UPDATE
               FIELDS ( Salary )
               WITH VALUE #( ( %tky   = member-%tky
                               Salary = 3000 ) ).

      ENDIF.

      IF member-Role = 'ABAP Cloud'.

        " Change salary to hard coded value
        MODIFY ENTITIES OF zi_uxteam_ej IN LOCAL MODE
               ENTITY UXTeam
               UPDATE
               FIELDS ( Salary )
               WITH VALUE #( ( %tky   = member-%tky
                               Salary = 4000 ) ).

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

  METHOD validateAge.

    READ ENTITIES OF zi_uxteam_ej
         IN LOCAL MODE
         ENTITY UXTeam
         FIELDS ( Age ) WITH CORRESPONDING #( keys )
         RESULT DATA(members).

    LOOP AT members INTO DATA(member).

      IF member-Age < 21.
        " Does not continue anymore | failed
        APPEND VALUE #( %tky = member-%tky ) TO failed-uxteam.
        " Recomendo even you not use draft | %tky | Table Key
      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
