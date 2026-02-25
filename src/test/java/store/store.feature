@regresion
Feature: Automatizar el backend de Store (Acceso a pedidos de PetStore)

    Background:
      * url apiUrl
      * def jsonCrearStore = read('classpath:json/store/postStore.json')

      @TEST-01 @HappyPath
      Scenario: Retorna el inventario de mascotas por estado
        Given path 'store/inventory'
        When method get
        Then status 200
        And print response

      @TEST-02 @HappyPath
      Scenario: Realizar un pedido de mascota
        Given path 'store/order'
        And request jsonCrearStore.id = 10
        And request jsonCrearStore
        When method post
        Then status 200
        And match response.id == 10
        And print response

      # El servicio no retorna un 400 como indica en la documentación, lo que retorna es un 500 cuando se envían tipos inválidos
      @TEST-03 @UnHappyPath
      Scenario: Realizar un pedido de mascota - validacion
        Given path 'store/order'
        And request jsonCrearStore.quantity = 2999999999
        And request jsonCrearStore
        When method post
        Then status 400
        And print response

      @TEST-04 @HappyPath
      Scenario: Buscar Orden de compra por ID
        Given path 'store/order',10
        When method get
        Then status 200
        And print response

      @TEST-05 @UnHappyPath
      Scenario: Buscar Orden de compra por ID siendo 0
        Given path 'store/order',0
        When method get
        Then status 404
        And print response

        # TODO :  LO MISMO QUE EL TEST-05 PERO CON Scenario Outline
      @TEST-06
      Scenario Outline: Buscar Orden de compra por ID <id>
        Given path 'store/order', <id>
        When method get
        Then status <status>

        @Happy
        Examples:
          |id|status|
          |10|200   |
          |6 |200   |

        @UnHappy
        Examples:
          |id|status|
          |0 |404   |
          |a |400   |

      @TEST-07
      Scenario Outline: Eliminar orden de compra por ID <id>
        Given path 'store/order', <id>
        When method delete
        Then status <status>
        And match response.message == <message>
        And print response

        @Happy
        Examples:
          |id|status|message          |
          |10|200   |"10"             |
        @UnHappy
        Examples:
          |id|status|message          |
          |10|404   |"Order Not Found"|




      # mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @TEST-01"
      # mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @TEST-01"
      # mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @regresion"
      # mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @Happy"
