Feature: Pruebas de usuarios en FakeStore API

  Scenario: Crear nuevo usuario correctamente
    * def user = read('classpath:data/usuario-nuevo.json')
    Given url 'https://fakestoreapi.com/users'
    And request user
    When method POST
    Then status 200
    And match response contains { id: '#number' }

  Scenario: Crear usuario con datos incompletos
    * def userInvalido = { email: 'incompleto@demo.com' }
    Given url 'https://fakestoreapi.com/users'
    And request userInvalido
    When method POST
    Then status 200
    And print response

  Scenario: Actualizar un usuario existente
    * def usuarioEditado = read('classpath:data/usuario-actualizado.json')
    Given url 'https://fakestoreapi.com/users/1'
    And request usuarioEditado
    When method PUT
    Then status 200
    And match response.email == usuarioEditado.email
    And match response.username == usuarioEditado.username

  Scenario: Actualizar usuario inexistente
    * def usuarioInvalido = read('classpath:data/usuario-actualizado.json')
    Given url 'https://fakestoreapi.com/users/99999'
    And request usuarioInvalido
    When method PUT
    Then status 200
    And print response

  Scenario: Eliminar un usuario existente
    Given url 'https://fakestoreapi.com/users/1'
    When method DELETE
    Then status 200
    And print response

  Scenario: Eliminar usuario inexistente
    Given url 'https://fakestoreapi.com/users/99999'
    When method DELETE
    Then status 200
    And match response == {}
