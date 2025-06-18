Feature: Autenticación de usuarios en FakeStore API

  Scenario: Autenticación exitosa con credenciales válidas
    * def credenciales = read('classpath:data/usuario-valido.json')
    Given url 'https://fakestoreapi.com/auth/login'
    And request credenciales
    When method POST
    Then status 200
    And match response contains { token: '#string' }

  Scenario: Autenticación fallida con credenciales inválidas
    * def credencialesInvalidas = read('classpath:data/usuario-invalido.json')
    Given url 'https://fakestoreapi.com/auth/login'
    And request credencialesInvalidas
    When method POST
    Then status 401
