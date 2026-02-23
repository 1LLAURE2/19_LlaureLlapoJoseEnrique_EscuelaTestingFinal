package store;
import com.intuit.karate.junit5.Karate;

public class StoreRunner {
    @Karate.Test
    Karate testStore() {
        return Karate.run("store").relativeTo(getClass());
    }
}
