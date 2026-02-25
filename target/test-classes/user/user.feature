@regresion
Feature: Automatizar el backend de Store (Acceso a pedidos de PetStore)

  Background:
    * url apiUrl
    * def jsonCrearUser = read('classpath:json/user/postUser.json')
    * def jsonActualizarUser = read('classpath:json/user/putUser.json')

    @TEST-U-01 @HappyPath
    Scenario: Crea una lista de usuarios con la matriz de entrada
      Given path 'user/createWithList'
      And request jsonCrearUser
      When method post
      Then status 200
      And match response.message == "ok"
      And print response

    @TEST-U-02 @HappyPath
    Scenario Outline: Obtener usuario por nombre de usuario
      Given path 'user' , <nombreUsuario>
      When method get
      Then status <status>
      #And match response.message == <message>
      And if (<status> == 200) karate.match(response.message, <nombreUsuario>)
      And if (<status> == 404) karate.match(response.message, <message>)
      @Happy
        Examples:
        |nombreUsuario|status|message         |expected               |
        |"jllaure"    |200   |""              |{ username: 'jllaure' }|

      @UnHappy
        Examples:
        |nombreUsuario|status|message         |expected                     |
        |"user1"      |404   |"User not found"|{ message: 'User not found' }|

            #And match response contains <expected>
            #And match response.message == <message>

    @TEST-U-03
    Scenario Outline:  Actualizar usuario
      Given path 'user', <username>
      And request jsonActualizarUser.email = "actualizacionUser@gmail.com"
      And request jsonActualizarUser
      When method put
      Then status <status>
      @Happy
        Examples:
        |username   |status|
        |"jllaure"  |200   |

      @UnHappy
        Examples:
        |username   |status|
        |"user125"  |404   |

    @TEST-U-04 @delete
    Scenario Outline: Eliminar usuario
      Given path 'user' , <username>
      When method delete
      Then status <status>
      @Happy
        Examples:
        |username   |status|
        |"string"   |200   |

      @UnHappy
        Examples:
        |username   |status|
        |"user125"  |404   |

    @TEST-U-05
    Scenario Outline: Iniciar Sesión en el sistema
      Given path 'user/login'
      And param username = <username>
      And param password = <password>
      When method get
      Then status <status>
      @Happy
        Examples:
        |username |password |status|
        |"jllaure"|987654321|200   |
      @UnHappy
        Examples:
        |username |password |status|
        |"user1"  |987654321|404   |

    @TEST-U-06
    Scenario: Cerrar sesión del usuario
      Given path 'user/logout'
      When method get
      Then status 200
      And match response.message == "ok"

    @TEST-U-07
    Scenario: Creación de una lista de usuarios con la matriz de entrada dada
      Given path 'user' , 'createWithArray'
      And request jsonCrearUser[0].username = "jllaure2"
      And request jsonCrearUser
      When method post
      Then status 200
      And match response.message == 'ok'

    @TEST-U-08
    Scenario: Crear usuario
      Given path 'user'
      And request jsonCrearUser[0].id = 99
      And request jsonCrearUser[0].username = "jllapoa"
      And request jsonCrearUser[0].firstName = "Enrique"
      And request jsonCrearUser[0].lastName = "Llapo"
      And request jsonCrearUser[0].email = "enrique@gmail.com"
      And request jsonCrearUser[0].password = "987456"
      And request jsonCrearUser[0].phone = "123456789"
      And request jsonCrearUser[0]
      When method post
      Then status 200
      And match response.message == "99"


# mvn clean test -Dtest=UserRunner -Dkarate.options="--tags @regresion"