Feature: Pruebas de productos en FakeStore API

    Background:
      Given url 'https://fakestoreapi.com/products'
      When method GET
      Then status 200
      * def primerProductoId = response[0].id
      * print 'ID del primer producto:', primerProductoId

    Scenario: Consultar detalle usando ID dinámico
      Given url `https://fakestoreapi.com/products/${primerProductoId}`
      When method GET
      Then status 200
      And match response.id == primerProductoId

      Scenario: Obtener lista de todos los productos
        Given url 'https://fakestoreapi.com/products'
        When method GET
        Then status 200
        And match response[0] contains { id: '#number', title: '#string', price: '#number' }

      Scenario: Obtener detalle de producto existente
        Given url 'https://fakestoreapi.com/products/1'
        When method GET
        Then status 200
        And match response.id == 1

      Scenario: Consultar producto inexistente
        Given url 'https://fakestoreapi.com/products/99999'
        When method GET
        Then status 200
        And match response == {}

      Scenario: Actualizar producto 1 correctamente
        * def producto1 = read('classpath:data/producto1-actualizado.json')
        Given url 'https://fakestoreapi.com/products/1'
        And request producto1
        When method PUT
        Then status 200
        And match response.title == producto1.title
        And match response.price == producto1.price
        And match response.category == producto1.category

      Scenario: Actualizar producto 2 correctamente
        * def producto2 = read('classpath:data/producto2-actualizado.json')
        Given url 'https://fakestoreapi.com/products/2'
        And request producto2
        When method PUT
        Then status 200
        And match response.title == producto2.title
        And match response.price == producto2.price
        And match response.category == producto2.category

      Scenario: Fallar al intentar actualizar un producto con datos inválidos
        * def productoInvalido = read('classpath:data/producto-invalido.json')
        Given url 'https://fakestoreapi.com/products/1'
        And request productoInvalido
        When method PUT
        Then status 200
        And print 'Respuesta ante actualización inválida:', response
