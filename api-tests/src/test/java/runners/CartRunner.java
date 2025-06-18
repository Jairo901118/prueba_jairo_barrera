package runners;

import com.intuit.karate.junit5.Karate;

public class CartRunner {
    @Karate.Test
    Karate testCart() {
        return Karate.run("classpath:features/cart.feature");
    }
}
