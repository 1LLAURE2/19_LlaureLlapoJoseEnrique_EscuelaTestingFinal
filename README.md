# Automatización Store y User
Proyecto de automatización de pruebas API usando Karate DSL + Maven + JUnit5 para validar los endpoints de Store y User del Swagger Petstore.<br/>

[![alt text](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN2OQatCoFPEX0P82xER8aIz7-C5Mu-6noiQ&s)](https://github.com/1LLAURE2 )

### Tecnologías utilizadas
+ Java 17+
+ Maven
+ Karate DSL
+ JUnit 5
+ IntelliJ IDEA
+ Api pública: [Swagger Petstore](https://petstore.swagger.io/)

### Anotaciones
  ```
  @regresion
  @HappyPath
  @UnHappyPath
  ```
# Cómo Ejecutar
+ Ejecutar Store
  ```
  mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @regresion"
  ```
+ Ejecutar User
    ```
    mvn clean test -Dtest=UserRunner -Dkarate.options="--tags @regresion"
    ```

> [!IMPORTANT]
> puede cambiar las anotaciones de @regresion por anotaciones @HappyPath o UnHappyPath, ya sea el caso que requiera revisar.

# Evidencias

  + Store
    [Evidencia](src/assets/img/ScenarioStore.png)
  + User
    [Evidencia](src/assets/img/ScenarioUser.png)

# Autor

JOSE LLAURE LLAPO

> [!NOTE]
> Proyecto desarrollado como práctica de automatización API con Karate Framework.


![API Automation](https://img.shields.io/badge/API-Automation-success)
![Karate Framework](https://img.shields.io/badge/Karate-Framework-green)
![Swagger Petstore](https://img.shields.io/badge/Tested%20API-Swagger%20Petstore-blue)
![Regression Suite](https://img.shields.io/badge/Test%20Suite-Regression-orange)