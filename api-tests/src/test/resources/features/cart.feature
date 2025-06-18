Feature: Pruebas de carrito de compras en FakeStore API

  Scenario: Obtener carrito del usuario 2 correctamente
    Given url 'https://fakestoreapi.com/carts/user/2'
    When method GET
    Then status 200
    And match response[0].userId == 2

  Scenario: Obtener carrito de usuario inexistente
    Given url 'https://fakestoreapi.com/carts/user/99999'
    When method GET
    Then status 200
    And match response == []

  Scenario: Eliminar un producto del carrito correctamente
    Given url 'https://fakestoreapi.com/carts/5'
    When method DELETE
    Then status 200
    And match response contains { id: 5 }

  Scenario: Eliminar producto inexistente del carrito
    Given url 'https://fakestoreapi.com/carts/99999'
    When method DELETE
    Then status 200
    And match response == {}
